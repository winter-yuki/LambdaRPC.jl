import JSON

Base.@kwdef mutable struct ClientFunctionDefaultConfiguration
    endpoint::Endpoint = ""
end

struct ClientFunction1{A, R} <: Function1{A, R}
    default::ClientFunctionDefaultConfiguration
    endpoint::Endpoint
    accessName::AccessName
end

function (f::ClientFunction1{A, R})(arg::A)::R where {A, R}
    s = JSON.json(arg)
    JSON.parse(s)
end
