# syntax: proto3
using ProtoBuf
import ProtoBuf.meta

mutable struct InitialRequest <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function InitialRequest(; kwargs...)
        obj = new(meta(InitialRequest), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct InitialRequest
const __meta_InitialRequest = Ref{ProtoMeta}()
function meta(::Type{InitialRequest})
    ProtoBuf.metalock() do
        if !isassigned(__meta_InitialRequest)
            __meta_InitialRequest[] = target = ProtoMeta(InitialRequest)
            allflds = Pair{Symbol,Union{Type,String}}[:serviceId => AbstractString, :executeRequest => ExecuteRequest]
            meta(target, InitialRequest, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_InitialRequest[]
    end
end
function Base.getproperty(obj::InitialRequest, name::Symbol)
    if name === :serviceId
        return (obj.__protobuf_jl_internal_values[name])::AbstractString
    elseif name === :executeRequest
        return (obj.__protobuf_jl_internal_values[name])::ExecuteRequest
    else
        getfield(obj, name)
    end
end

mutable struct InMessage <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function InMessage(; kwargs...)
        obj = new(meta(InMessage), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct InMessage
const __meta_InMessage = Ref{ProtoMeta}()
function meta(::Type{InMessage})
    ProtoBuf.metalock() do
        if !isassigned(__meta_InMessage)
            __meta_InMessage[] = target = ProtoMeta(InMessage)
            allflds = Pair{Symbol,Union{Type,String}}[:initialRequest => InitialRequest, :executeRequest => ExecuteRequest, :executeResponse => ExecuteResponse]
            oneofs = Int[1,1,1]
            oneof_names = Symbol[Symbol("content")]
            meta(target, InMessage, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, oneofs, oneof_names)
        end
        __meta_InMessage[]
    end
end
function Base.getproperty(obj::InMessage, name::Symbol)
    if name === :initialRequest
        return (obj.__protobuf_jl_internal_values[name])::InitialRequest
    elseif name === :executeRequest
        return (obj.__protobuf_jl_internal_values[name])::ExecuteRequest
    elseif name === :executeResponse
        return (obj.__protobuf_jl_internal_values[name])::ExecuteResponse
    else
        getfield(obj, name)
    end
end

export InitialRequest, InMessage
