module Communicator

export @libserver, start, startblocking, @libclient, setendpoint

include("utils.jl")
include("serializer.jl")
include("server/server.jl")
include("server/dsl.jl")
include("client/client.jl")
include("client/dsl.jl")

end # module
