macro libclient(definitions::Expr)
    libname = nameof(__module__) |> string |> lowercase |> Symbol
    default = LibClientDefaultConfiguration()
    Core.eval(__module__, :($libname = $default))

    @assert definitions.head == :block
    for definition in definitions.args
        definition isa LineNumberNode && continue
        @assert definition.head == :call
        (arrow, left, ret) = definition.args
        @assert arrow == :(=>)
        @assert left.head == :(::)
        (name, arg) = left.args
        arg = Core.eval(__module__, arg)
        ret = Core.eval(__module__, ret)
        f = Function1{arg,ret}(default, "", string(name))
        Core.eval(__module__, :($name = $f))
    end
end

function setendpoint(client::LibClientDefaultConfiguration, endpoint::Endpoint)
    client.endpoint = endpoint
end
