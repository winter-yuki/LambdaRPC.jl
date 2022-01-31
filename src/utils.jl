Endpoint = String

function endpoint(address::String, port::Int)::Endpoint
    address * string(port)
end

AccessName = String
