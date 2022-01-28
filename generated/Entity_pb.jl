# syntax: proto3
using ProtoBuf
import ProtoBuf.meta

mutable struct Entity <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function Entity(; kwargs...)
        obj = new(meta(Entity), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct Entity
const __meta_Entity = Ref{ProtoMeta}()
function meta(::Type{Entity})
    ProtoBuf.metalock() do
        if !isassigned(__meta_Entity)
            __meta_Entity[] = target = ProtoMeta(Entity)
            allflds = Pair{Symbol,Union{Type,String}}[:data => Vector{UInt8}, :_function => Function]
            oneofs = Int[1,1]
            oneof_names = Symbol[Symbol("content")]
            meta(target, Entity, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, oneofs, oneof_names)
        end
        __meta_Entity[]
    end
end
function Base.getproperty(obj::Entity, name::Symbol)
    if name === :data
        return (obj.__protobuf_jl_internal_values[name])::Vector{UInt8}
    elseif name === :_function
        return (obj.__protobuf_jl_internal_values[name])::Function
    else
        getfield(obj, name)
    end
end

export Entity
