Endpoint = String

"""
Validates that function builder is fully constructed in both two types of dsl.
"""
@enum DslTypeProtocol begin
    dslunknown
    metadsl
    nemetadsl
end

Base.@kwdef struct FunctionBuilder{Arg,Ret,dslType}
    endpoint::Endpoint = ""
    functionname::String = ""
end

struct Function{Arg,Ret}
    endpoint::Endpoint
    functionname::String
end

fn = FunctionBuilder{(),(),dslunknown}()

Base.getindex(::FunctionBuilder{(),(),dslunknown}, name::String, endpoint::Endpoint) =
    FunctionBuilder{(),(),nemetadsl}(endpoint, name)

(builder::FunctionBuilder{(),(),dslType})(::Type{Arg}) where {Arg,dslType} =
    FunctionBuilder{Arg,(),dslType}(builder.endpoint, builder.functionname)

Base.:(=>)(::FunctionBuilder{Arg,(),dslunknown}, ::Type{Ret}) where {Arg,Ret} =
    FunctionBuilder{Arg,Ret,metadsl}()

Base.:(=>)(builder::FunctionBuilder{Arg,(),nemetadsl}, ::Type{Ret}) where {Arg,Ret} =
    Function{Arg,Ret}(builder.endpoint, builder.functionname)

(::FunctionBuilder{Arg,Ret,metadsl})(
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
