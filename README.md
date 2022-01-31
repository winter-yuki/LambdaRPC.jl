# λRPC

## Run examples

```bash
$ cd LambdaRPC.jl
$ julia --project=. src/examples/basic/client.jl
```

<!--
## Run examples

```
$ julia --project=. src/examples/server.jl
$ julia --project=. src/examples/client.jl
```

## LibServer API

```julia
module Lib

square(x::UInt32)::UInt32 = x * x

end # module

using Communicator

function main()
    endpoint = "tcp://127.0.0.1:8888"
    @libserver server endpoint begin
        square:Lib.square::UInt32 => UInt32
    end
    startblocking(server)
end

main()
```

## LibClient API

```julia
module Lib

using Communicator

@libclient begin
    square:"square"::UInt32 => UInt32
end

end # module

using Communicator

function main()
    setendpoint(Lib.lib, "tcp://127.0.0.1:8888")
    @assert Lib.square(UInt32(2)) == 4
    @assert Lib.square["tcp://127.0.0.1:8899"](UInt32(2)) == 4
end

main()
```

## Communicator vs gRPC

Advs
- HOF support (+ pure functions result cache)
- Familiar in-language declarations (?)

Disadvs:
- Custom implementation
- Serialization ambiguity

## Serialization

```
val bytes = Cbor.encodeToByteArray(...)
val data = Cbor.decodeFromencodeToByteArray<Data>(bytes)

val string = Json.encodeToString(...)
val data = Json.decodeFromString<Data>("""{"a":42, "b": "str"}""")
``` -->
