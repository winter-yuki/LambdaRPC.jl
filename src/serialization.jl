abstract type Serializer{T} end

abstract type DataSerializer{T} <: Serializer{T} end

struct DefaultDataSerializer{T} end

abstract type FunctionSerializer{T} <: Serializer{T} end

struct FunctionSerializer1{A, R} <: FunctionSerializer{Function1{A, R}} end
