using UUIDs

macro facade(serviceId::Union{Symbol,String}, declarations::Expr)
    libname = nameof(__module__) |> string |> lowercase |> Symbol
    conf = ClientFunctionConfiguration(serviceId = UUID(Core.eval(__module__, serviceId)))
    Core.eval(__module__, :($libname = $conf))

    @assert declarations.head == :block
    for declaration in declarations.args
        declaration isa LineNumberNode && continue
        @assert declaration.head == :call
        (arrow, left, ret) = declaration.args
        @assert arrow == :(=>)
        @assert left.head == :(::)
        (name, arg) = left.args
        arg = Core.eval(__module__, arg)
        ret = Core.eval(__module__, ret)
        f = ClientFunction1{arg,ret}(conf, nothing, string(name))
        Core.eval(__module__, :($name = $f))
    end
end

function setendpoint(client::ClientFunctionConfiguration, address::Address, port::Port)
    client.endpoint = Endpoint(address, port)
end
