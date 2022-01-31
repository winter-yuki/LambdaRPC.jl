import JSON
using UUIDs
using .io.lambdarpc.transport.grpc

Base.@kwdef mutable struct ClientFunctionDefaultConfiguration
    endpoint::Union{Nothing,Endpoint} = nothing
end

struct ClientFunction1{A,R} <: Function1{A,R}
    default::ClientFunctionDefaultConfiguration
    endpoint::Union{Nothing,Endpoint}
    accessName::AccessName
end

function (f::ClientFunction1{A,R})(arg::A)::R where {A,R}
    s = JSON.json(arg)
    e = Entity(data = Vector{Int8}(codeunits(s)))
    message = InMessage(
        initialRequest = InitialRequest(
            serviceId = "",
            executeRequest = ExecuteRequest(
                accessName = f.accessName,
                executionId = string(uuid4()),
                args = [e],
            ),
        ),
    )
    JSON.parse(String(message.initialRequest.executeRequest.args[1].data))
end
