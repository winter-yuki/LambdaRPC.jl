struct FunctionalClientFactory end

const fn = FunctionalClientFactory()

Base.getindex(::FunctionalClientFactory, name::String, endpoint::String) =
    FunctionalClient(endpoint, name)

struct FunctionalClient
    endpoint::String
    functionname::String
end

(client::FunctionalClient)(argtype::Type) = UnitFunction{argtype}(client)

struct UnitFunction{Arg}
    client::FunctionalClient
end

Base.:>>(f::UnitFunction{Arg}, returntype::Type) where Arg = Function{Arg, returntype}(f.client)

struct Function{Arg, Ret}
    client::FunctionalClient
end
