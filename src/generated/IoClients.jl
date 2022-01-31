module IoClients
using gRPCClient

include("io.jl")
using .io.lambdarpc.transport.grpc

import Base: show

# begin service: io.lambdarpc.transport.grpc.LibService

export LibServiceBlockingClient, LibServiceClient

struct LibServiceBlockingClient
    controller::gRPCController
    channel::gRPCChannel
    stub::LibServiceBlockingStub

    function LibServiceBlockingClient(api_base_url::String; kwargs...)
        controller = gRPCController(; kwargs...)
        channel = gRPCChannel(api_base_url)
        stub = LibServiceBlockingStub(channel)
        new(controller, channel, stub)
    end
end

struct LibServiceClient
    controller::gRPCController
    channel::gRPCChannel
    stub::LibServiceStub

    function LibServiceClient(api_base_url::String; kwargs...)
        controller = gRPCController(; kwargs...)
        channel = gRPCChannel(api_base_url)
        stub = LibServiceStub(channel)
        new(controller, channel, stub)
    end
end

show(io::IO, client::LibServiceBlockingClient) = print(io, "LibServiceBlockingClient(", client.channel.baseurl, ")")
show(io::IO, client::LibServiceClient) = print(io, "LibServiceClient(", client.channel.baseurl, ")")

import .io.lambdarpc.transport.grpc: execute
"""
    execute

- input: Channel{io.lambdarpc.transport.grpc.InMessage}
- output: Channel{io.lambdarpc.transport.grpc.OutMessage}
"""
execute(client::LibServiceBlockingClient, inp::Channel{io.lambdarpc.transport.grpc.InMessage}) = execute(client.stub, client.controller, inp)
execute(client::LibServiceClient, inp::Channel{io.lambdarpc.transport.grpc.InMessage}, done::Function) = execute(client.stub, client.controller, inp, done)

# end service: io.lambdarpc.transport.grpc.LibService

end # module IoClients
