# syntax: proto3
using ProtoBuf
import ProtoBuf.meta

const ErrorType = (;[
    Symbol("OTHER") => Int32(0),
    Symbol("TIMEOUT_ERROR") => Int32(1),
    Symbol("SERIALIZATION_ERROR") => Int32(2),
    Symbol("WRONG_SERVICE_ERROR") => Int32(3),
    Symbol("FUNCTION_NOT_FOUND_ERROR") => Int32(4),
]...)

mutable struct ExecuteError <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function ExecuteError(; kwargs...)
        obj = new(meta(ExecuteError), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct ExecuteError
const __meta_ExecuteError = Ref{ProtoMeta}()
function meta(::Type{ExecuteError})
    ProtoBuf.metalock() do
        if !isassigned(__meta_ExecuteError)
            __meta_ExecuteError[] = target = ProtoMeta(ExecuteError)
            allflds = Pair{Symbol,Union{Type,String}}[:_type => Int32, :message => AbstractString]
            meta(target, ExecuteError, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_ExecuteError[]
    end
end
function Base.getproperty(obj::ExecuteError, name::Symbol)
    if name === :_type
        return (obj.__protobuf_jl_internal_values[name])::Int32
    elseif name === :message
        return (obj.__protobuf_jl_internal_values[name])::AbstractString
    else
        getfield(obj, name)
    end
end

export ErrorType, ExecuteError
