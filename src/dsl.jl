Endpoint = String

Base.@kwdef struct FunctionBuilder{Arg,Ret,isMeta}
    endpoint::Endpoint = ""
    functionname::String = ""
end

fn = FunctionBuilder{(),(),()}()

Base.getindex(::FunctionBuilder{(),(),()}, name::String, endpoint::Endpoint) =
    FunctionBuilder{(),(),false}(endpoint, name)

(builder::FunctionBuilder{(),(),isMeta})(::Type{Arg}) where {Arg,isMeta} =
    FunctionBuilder{Arg,(),isMeta}(builder.endpoint, builder.functionname)

Base.:(=>)(::FunctionBuilder{Arg,(),()}, ::Type{Ret}) where {Arg,Ret} =
    FunctionBuilder{Arg,Ret,true}()

Base.:(=>)(builder::FunctionBuilder{Arg,(),false}, ::Type{Ret}) where {Arg,Ret} =
    Function{Arg,Ret}(builder.endpoint, builder.functionname)

struct Function{Arg,Ret}
    endpoint::Endpoint
    functionname::String
end

(::FunctionBuilder{Arg,Ret,true})(
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
