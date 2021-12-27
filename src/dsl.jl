struct FunctionalClientFactory end

const fn = FunctionalClientFactory()

Base.getindex(::FunctionalClientFactory, name::String, endpoint::String) =
    FunctionalClient(endpoint, name)

struct FunctionalClient
    endpoint::String
    functionname::String
end

(client::FunctionalClient)(::Type{Arg}) where {Arg} = UnitFunction{Arg}(client)

struct UnitFunction{Arg}
    client::FunctionalClient
end

Base.:>>(f::UnitFunction{Arg}, ::Type{Ret}) where {Arg,Ret} = Function{Arg,Ret}(f.client)

struct Function{Arg,Ret}
    client::FunctionalClient
end
