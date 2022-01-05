macro libserver(servername::Symbol, endpoint::Union{Symbol, String, Expr}, declarations::Expr)
    @assert declarations.head == :block
    functions = Dict()
    for declaration in declarations.args
        declaration isa LineNumberNode && continue
        @assert declaration.head == :call
        (arrow, left, ret) = declaration.args
        @assert arrow == :(=>)
        if left.head == :call
            (colon, functionname, right) = left.args
            @assert colon == :(:)
            @assert right.head == :(::)
            (sourcename, arg) = right.args
        elseif left.head == :(::)
            (functionname, arg) = left.args
            sourcename = functionname
        else
            @assert false
        end
        arg = Core.eval(__module__, arg)
        ret = Core.eval(__module__, ret)
        f = Core.eval(__module__, sourcename)
        functions[string(functionname)] = ServerFunction1{arg,ret}(f)
    end
    esc(:($servername = $LibServer($endpoint, $functions)))
end
