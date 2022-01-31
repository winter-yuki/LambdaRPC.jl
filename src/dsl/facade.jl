macro facade(declarations::Expr)
    libname = nameof(__module__) |> string |> lowercase |> Symbol
    default = ClientFunctionDefaultConfiguration()
    Core.eval(__module__, :($libname = $default))

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
        f = ClientFunction1{arg,ret}(default, "", string(name))
        Core.eval(__module__, :($name = $f))
    end
end

function setendpoint(client::ClientFunctionDefaultConfiguration, address::String, port::Int)
    client.endpoint = endpoint(address, port)
end
