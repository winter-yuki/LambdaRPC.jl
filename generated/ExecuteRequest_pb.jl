# syntax: proto3
using ProtoBuf
import ProtoBuf.meta

mutable struct ExecuteRequest <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function ExecuteRequest(; kwargs...)
        obj = new(meta(ExecuteRequest), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct ExecuteRequest
const __meta_ExecuteRequest = Ref{ProtoMeta}()
function meta(::Type{ExecuteRequest})
    ProtoBuf.metalock() do
        if !isassigned(__meta_ExecuteRequest)
            __meta_ExecuteRequest[] = target = ProtoMeta(ExecuteRequest)
            allflds = Pair{Symbol,Union{Type,String}}[:accessName => AbstractString, :executionId => AbstractString, :args => Base.Vector{Entity}]
            meta(target, ExecuteRequest, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_ExecuteRequest[]
    end
end
function Base.getproperty(obj::ExecuteRequest, name::Symbol)
    if name === :accessName
        return (obj.__protobuf_jl_internal_values[name])::AbstractString
    elseif name === :executionId
        return (obj.__protobuf_jl_internal_values[name])::AbstractString
    elseif name === :args
        return (obj.__protobuf_jl_internal_values[name])::Base.Vector{Entity}
    else
        getfield(obj, name)
    end
end

export ExecuteRequest
