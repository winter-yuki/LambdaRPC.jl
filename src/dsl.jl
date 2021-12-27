struct FunctionBuilder{Arg,Ret} end

fn(::Type{Arg}) where {Arg} = FunctionBuilder{Arg,()}()

function Base.:(=>)(
    builder::FunctionBuilder{Arg,()},
    ::Type{Ret},
)::FunctionBuilder{Arg,Ret} where {Arg,Ret}
    FunctionBuilder{Arg,Ret}()
end

Endpoint = String

struct Function{Arg,Ret}
    endpoint::Endpoint
    functionname::String
end

(builder::FunctionBuilder{Arg,Ret})(
    endpoint::Endpoint,
    functionname::String,
) where {Arg,Ret} = Function{Arg,Ret}(endpoint, functionname)

macro client(endpoint::Union{Symbol,Expr,Endpoint}, block)
    # TODO make working if endpoint is in local scope at the callsite
    endpoint = endpoint isa Endpoint ? endpoint : Endpoint(Core.eval(__module__, endpoint))
    @assert block.head == :block
    for s in block.args
        s isa LineNumberNode && continue
        s.head != :(=) && continue
        (name, expr) = s.args
        builder = Core.eval(__module__, expr)
        f = builder isa FunctionBuilder ? builder(endpoint, string(name)) : builder
        Core.eval(__module__, :($name = $f))
    end
end
