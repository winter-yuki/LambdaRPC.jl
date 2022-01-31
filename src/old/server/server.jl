import ZMQ
import UUIDs

struct ServerFunction1{Arg,Ret}
    sourcefunction
end

function (f::ServerFunction1{Arg,Ret})(arg::Payload)::Payload where {Arg,Ret}
    arg = decode(arg, Arg)
    res = f.sourcefunction(arg)
    encode(res)
end

struct LibServer
    endpoint::Endpoint
    functions::Dict{String,ServerFunction1}
end

# TODO non-blocking
start(server::LibServer) = ()

function startblocking(server::LibServer)
    use(ZMQ.Socket(ZMQ.ROUTER), ZMQ.close) do socket
        ZMQ.bind(socket, server.endpoint)
        while true
            clientIdentity = ZMQ.recv(socket)
            msgtype = ZMQ.recv(socket, String)
            queryId = ZMQ.recv(socket, String)
            arg = ZMQ.recv(socket, Payload)
            functionname = ZMQ.recv(socket, String)
            @assert msgtype == "QUERY"

            println("1")

            ZMQ.send(socket, clientIdentity, true)
            ZMQ.send(socket, "QUERY_RECEIVED", true)
            ZMQ.send(socket, queryId, false)

            println("2")

            res = server.functions[functionname](arg)

            ZMQ.send(socket, clientIdentity, true)
            ZMQ.send(socket, "RESPONSE_RESULT", true)
            ZMQ.send(socket, queryId, true)
            ZMQ.send(socket, res, false)

            println("4")
        end
    end
end
