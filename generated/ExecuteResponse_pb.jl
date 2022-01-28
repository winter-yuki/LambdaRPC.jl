# syntax: proto3
using ProtoBuf
import ProtoBuf.meta

mutable struct ExecuteResponse <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function ExecuteResponse(; kwargs...)
        obj = new(meta(ExecuteResponse), Dict{Symbol,Any}(), Set{Symbol}())
        values = obj.__protobuf_jl_internal_values
        symdict = obj.__protobuf_jl_internal_meta.symdict
        for nv in kwargs
            fldname, fldval = nv
            fldtype = symdict[fldname].jtyp
            (fldname in keys(symdict)) || error(string(typeof(obj), " has no field with name ", fldname))
            if fldval !== nothing
                values[fldname] = isa(fldval, fldtype) ? fldval : convert(fldtype, fldval)
            end
        end
        obj
    end
end # mutable struct ExecuteResponse
const __meta_ExecuteResponse = Ref{ProtoMeta}()
function meta(::Type{ExecuteResponse})
    ProtoBuf.metalock() do
        if !isassigned(__meta_ExecuteResponse)
            __meta_ExecuteResponse[] = target = ProtoMeta(ExecuteResponse)
            allflds = Pair{Symbol,Union{Type,String}}[:executionId => AbstractString, :result => Entity, :error => ExecuteError]
            oneofs = Int[0,1,1]
            oneof_names = Symbol[Symbol("content")]
            meta(target, ExecuteResponse, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, oneofs, oneof_names)
        end
        __meta_ExecuteResponse[]
    end
end
function Base.getproperty(obj::ExecuteResponse, name::Symbol)
    if name === :executionId
        return (obj.__protobuf_jl_internal_values[name])::AbstractString
    elseif name === :result
        return (obj.__protobuf_jl_internal_values[name])::Entity
    elseif name === :error
        return (obj.__protobuf_jl_internal_values[name])::ExecuteError
    else
        getfield(obj, name)
    end
end

export ExecuteResponse
