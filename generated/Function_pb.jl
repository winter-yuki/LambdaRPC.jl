# syntax: proto3
using ProtoBuf
import ProtoBuf.meta

mutable struct ChannelFunction <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function ChannelFunction(; kwargs...)
        obj = new(meta(ChannelFunction), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct ChannelFunction
const __meta_ChannelFunction = Ref{ProtoMeta}()
function meta(::Type{ChannelFunction})
    ProtoBuf.metalock() do
        if !isassigned(__meta_ChannelFunction)
            __meta_ChannelFunction[] = target = ProtoMeta(ChannelFunction)
            allflds = Pair{Symbol,Union{Type,String}}[:accessName => AbstractString]
            meta(target, ChannelFunction, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_ChannelFunction[]
    end
end
function Base.getproperty(obj::ChannelFunction, name::Symbol)
    if name === :accessName
        return (obj.__protobuf_jl_internal_values[name])::AbstractString
    else
        getfield(obj, name)
    end
end

mutable struct ClientFunction <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function ClientFunction(; kwargs...)
        obj = new(meta(ClientFunction), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct ClientFunction
const __meta_ClientFunction = Ref{ProtoMeta}()
function meta(::Type{ClientFunction})
    ProtoBuf.metalock() do
        if !isassigned(__meta_ClientFunction)
            __meta_ClientFunction[] = target = ProtoMeta(ClientFunction)
            allflds = Pair{Symbol,Union{Type,String}}[:accessName => AbstractString, :serviceURL => AbstractString, :serviceUUID => AbstractString]
            meta(target, ClientFunction, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_ClientFunction[]
    end
end
function Base.getproperty(obj::ClientFunction, name::Symbol)
    if name === :accessName
        return (obj.__protobuf_jl_internal_values[name])::AbstractString
    elseif name === :serviceURL
        return (obj.__protobuf_jl_internal_values[name])::AbstractString
    elseif name === :serviceUUID
        return (obj.__protobuf_jl_internal_values[name])::AbstractString
    else
        getfield(obj, name)
    end
end

mutable struct Function <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function Function(; kwargs...)
        obj = new(meta(Function), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct Function
const __meta_Function = Ref{ProtoMeta}()
function meta(::Type{Function})
    ProtoBuf.metalock() do
        if !isassigned(__meta_Function)
            __meta_Function[] = target = ProtoMeta(Function)
            allflds = Pair{Symbol,Union{Type,String}}[:cached => Bool, :channelFunction => ChannelFunction, :clientFunction => ClientFunction]
            oneofs = Int[0,1,1]
            oneof_names = Symbol[Symbol("function")]
            meta(target, Function, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, oneofs, oneof_names)
        end
        __meta_Function[]
    end
end
function Base.getproperty(obj::Function, name::Symbol)
    if name === :cached
        return (obj.__protobuf_jl_internal_values[name])::Bool
    elseif name === :channelFunction
        return (obj.__protobuf_jl_internal_values[name])::ChannelFunction
    elseif name === :clientFunction
        return (obj.__protobuf_jl_internal_values[name])::ClientFunction
    else
        getfield(obj, name)
    end
end

export ChannelFunction, ClientFunction, Function
