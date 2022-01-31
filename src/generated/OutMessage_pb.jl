# syntax: proto3
using ProtoBuf
import ProtoBuf.meta

mutable struct OutMessage <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function OutMessage(; kwargs...)
        obj = new(meta(OutMessage), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct OutMessage
const __meta_OutMessage = Ref{ProtoMeta}()
function meta(::Type{OutMessage})
    ProtoBuf.metalock() do
        if !isassigned(__meta_OutMessage)
            __meta_OutMessage[] = target = ProtoMeta(OutMessage)
            allflds = Pair{Symbol,Union{Type,String}}[:executeRequest => ExecuteRequest, :executeResponse => ExecuteResponse, :finalResponse => ExecuteResponse]
            oneofs = Int[1,1,1]
            oneof_names = Symbol[Symbol("content")]
            meta(target, OutMessage, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, oneofs, oneof_names)
        end
        __meta_OutMessage[]
    end
end
function Base.getproperty(obj::OutMessage, name::Symbol)
    if name === :executeRequest
        return (obj.__protobuf_jl_internal_values[name])::ExecuteRequest
    elseif name === :executeResponse
        return (obj.__protobuf_jl_internal_values[name])::ExecuteResponse
    elseif name === :finalResponse
        return (obj.__protobuf_jl_internal_values[name])::ExecuteResponse
    else
        getfield(obj, name)
    end
end

export OutMessage
