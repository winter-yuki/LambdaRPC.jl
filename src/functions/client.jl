import JSON
using UUIDs
using .io.lambdarpc.transport.grpc
using .IoClients
using gRPCClient


Base.@kwdef mutable struct ClientFunctionConfiguration
    serviceId::UUID
    endpoint::Union{Nothing,Endpoint} = nothing
end

struct ClientFunction1{A,R} <: Function1{A,R}
    conf::ClientFunctionConfiguration
    endpoint::Union{Nothing,Endpoint}
    accessName::AccessName
end

function (f::ClientFunction1{A,R})(arg::A)::R where {A,R}
    s = JSON.json(arg)
    e = Entity(data = Vector{Int8}(codeunits(s)))
    message = InMessage(
        initialRequest = InitialRequest(
            serviceId = string(f.conf.serviceId),
            executeRequest = ExecuteRequest(
                accessName = f.accessName,
                executionId = string(uuid4()),
                args = [e],
            ),
        ),
    )
    controller = gRPCController()
    channel = gRPCChannel(f.conf.endpoint.address * ":" * string(f.conf.endpoint.port))
    stub = LibServiceBlockingStub(channel)
    @sync begin
        inMessages = Channel{InMessage}(1)
        # @async begin
        put!(inMessages, message)
        close(inMessages)
        # end
        outMessages, status_future = execute(stub, controller, inMessages)
        # @async begin
        for outMessage in outMessages
            data = outMessage.finalResponse.result.data
            return JSON.parse(String(data))
        end
        # end
        # @async begin
        #     gRPCCheck(status_future)
        # end
    end
end
