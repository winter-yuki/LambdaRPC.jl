import ZMQ

Payload = Vector{UInt8}

encode(i::UInt32) = Payload(digits(i, base=256, pad=4) |> reverse)

decode(p::Payload, ::Type{UInt32})::UInt32 = foldr(p) do x, y
    x * 256 + y
end

encode(s::String) = s

function recv(socket, ::Type{UInt32})
    response = ZMQ.recv(socket, Payload)
    return decode(response, UInt32)
end

function recv(socket, ::Type{String})
    response = ZMQ.recv(socket, String)
    return response
end

# TODO make async
function (f::Function{UInt32, UInt32})(arg::UInt32)::UInt32
    # TODO close socket
    socket = ZMQ.Socket(ZMQ.DEALER)
    ZMQ.connect(socket, f.client.endpoint)

    # TODO make enums
    ZMQ.send(socket, "QUERY", true)
    # TODO generate UUID
    uuid = "2a122c04-6400-11ec-90d6-0242ac120003"
    ZMQ.send(socket, uuid, true)
    ZMQ.send(socket, encode(arg), true)
    ZMQ.send(socket, f.client.functionname, false)

    confirmation_msg = ZMQ.recv(socket, String)
    # TODO throw exception
    @assert (confirmation_msg == "QUERY_RECEIVED") confirmation_msg
    confirmation_uuid = ZMQ.recv(socket, String)
    @assert (confirmation_uuid == uuid) confirmation_uuid

    rc = ZMQ.recv(socket, String)
    result_uuid = ZMQ.recv(socket, String)
    @assert (result_uuid == uuid) result_uuid
    if rc == "RESPONSE_UNKNOWN_FUNCTION"
        # TODO throw exception
        functionname = ZMQ.recv(socket, String)
        @assert false "Unknown function $(functionname)"
    elseif rc == "RESPONSE_EXCEPTION"
        msg = ZMQ.recv(socket, String)
        @assert false msg
    end

    @assert (rc == "RESPONSE_RESULT") rc
    return recv(socket, UInt32)
end

# TODO
# function (f::Function{Arg, Ret})(arg::Arg)::Ret where {Arg, Ret}
#     error("Hello from unit unsupported type function!")
#     return Ret()
# end
