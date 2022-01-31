import ZMQ
import UUIDs

Base.@kwdef mutable struct LibClientDefaultConfiguration
    endpoint::Endpoint = ""
end

struct Function1{Arg,Ret}
    default::LibClientDefaultConfiguration
    endpoint::Endpoint
    functionname::String
end

abstract type CommunicatorException <: Exception end

struct UnknownFunctionError <: CommunicatorException
    name::String
end

Base.showerror(io::IO, e::UnknownFunctionError) = print(io, e.name, " function is unknown")

struct RemoteFunctionException <: CommunicatorException
    msg::String
end

Base.showerror(io::IO, e::RemoteFunctionException) = print(io, "exception message: ", e.msg)

function recv(socket, ::Type{String})
    response = ZMQ.recv(socket, String)
    return response
end

function recv(socket, ::Type{T}) where {T}
    response = ZMQ.recv(socket, Payload)
    return decode(response, T)
end

function (f::Function1{Arg,Ret})(arg::Arg)::Ret where {Arg,Ret}
    use(ZMQ.Socket(ZMQ.DEALER), ZMQ.close) do socket
        @assert f.default.endpoint != "" || f.endpoint != ""
        ZMQ.connect(socket, f.endpoint == "" ? f.default.endpoint : f.endpoint)

        uuid = string(UUIDs.uuid4())
        ZMQ.send(socket, "QUERY", true)
        ZMQ.send(socket, uuid, true)
        ZMQ.send(socket, encode(arg), true)
        ZMQ.send(socket, f.functionname, false)

        println("1")

        confirmation_msg = ZMQ.recv(socket, String)
        @assert (confirmation_msg == "QUERY_RECEIVED") confirmation_msg
        confirmation_uuid = ZMQ.recv(socket, String)
        @assert (confirmation_uuid == uuid) confirmation_uuid

        println("2")

        rc = ZMQ.recv(socket, String)
        println("4")
        result_uuid = ZMQ.recv(socket, String)
        println("5")
        @assert (result_uuid == uuid) result_uuid
        if rc == "RESPONSE_UNKNOWN_FUNCTION"
            functionname = ZMQ.recv(socket, String)
            throw(UnknownFunctionError(functionname))
        elseif rc == "RESPONSE_EXCEPTION"
            msg = ZMQ.recv(socket, String)
            throw(RemoteFunctionException(msg))
        end

        println("6")

        @assert (rc == "RESPONSE_RESULT") rc
        return recv(socket, Ret)
    end
end
