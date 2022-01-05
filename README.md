# communicator-jl

```
julia --project=. src/examples/client.jl
```

## Syntax client

```julia
@fn f::(Int, String) => String
f[endpoint](1, "2")
```

```julia
@fn(endpoint) f::(Int, String) => String
f(1, "2")
```

```julia
@fns begin
    f::Int => Int
    g::String => String
end
g[endpoint]("aa")
```

```julia
@fns endpoint begin
    f::Int => Int
    g::String => String
end
g("aa")
```

Can find endpoint automatically if it is not specified.

## Syntax server

```julia
server = FunctionalServer(endpoint)
@fns server begin
    f::Int => Int = myf
    g::String => String = myg
end
server.start()
```
