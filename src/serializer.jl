Payload = Vector{UInt8}

encode(i::UInt32) = Payload(digits(i, base = 256, pad = 4) |> reverse)

decode(p::Payload, ::Type{UInt32})::UInt32 =
    foldr(p) do x, y
        x * 256 + y
    end

encode(s::String) = s
