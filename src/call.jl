import ZMQ
import UUIDs

Payload = Vector{UInt8}

abstract type CommunicatorException <: Exception end

struct UnknownFunctionError <: CommunicatorException
    name::String
end

Base.showerror(io::IO, e::UnknownFunctionError) = print(io, e.name, " function is unknown")

struct RemoteFunctionException <: CommunicatorException
    msg::String
end

Base.showerror(io::IO, e::RemoteFunctionException) = print(io, "exception message: ", e.msg)

encode(i::UInt32) = Payload(digits(i, base = 256, pad = 4) |> reverse)

decode(p::Payload, ::Type{UInt32})::UInt32 =
    foldr(p) do x, y
        x * 256 + y
    end

encode(s::String) = s

function recv(socket, ::Type{String})
    response = ZMQ.recv(socket, String)
    return response
end

function recv(socket, ::Type{T}) where {T}
    response = ZMQ.recv(socket, Payload)
    return decode(response, T)
end

function (f::Function{Arg,Ret})(arg::Arg)::Ret where {Arg,Ret}
    use(ZMQ.Socket(ZMQ.DEALER), ZMQ.close) do socket
        ZMQ.connect(socket, f.endpoint)

        uuid = string(UUIDs.uuid4())
        ZMQ.send(socket, "QUERY", true)
        ZMQ.send(socket, uuid, true)
        ZMQ.send(socket, encode(arg), true)
        ZMQ.send(socket, f.functionname, false)

        confirmation_msg = ZMQ.recv(socket, String)
        @assert (confirmation_msg == "QUERY_RECEIVED") confirmation_msg
        confirmation_uuid = ZMQ.recv(socket, String)
        @assert (confirmation_uuid == uuid) confirmation_uuid

        rc = ZMQ.recv(socket, String)
        result_uuid = ZMQ.recv(socket, String)
        @assert (result_uuid == uuid) result_uuid
        if rc == "RESPONSE_UNKNOWN_FUNCTION"
            functionname = ZMQ.recv(socket, String)
            throw(UnknownFunctionError(functionname))
        elseif rc == "RESPONSE_EXCEPTION"
            msg = ZMQ.recv(socket, String)
            throw(RemoteFunctionException(msg))
        end

        @assert (rc == "RESPONSE_RESULT") rc
        return recv(socket, Ret)
    end
end
