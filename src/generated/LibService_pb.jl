# syntax: proto3
using ProtoBuf
import ProtoBuf.meta

# service methods for LibService
const _LibService_methods = MethodDescriptor[
        MethodDescriptor("execute", 1, Channel{InMessage}, Channel{OutMessage})
    ] # const _LibService_methods
const _LibService_desc = ServiceDescriptor("io.lambdarpc.transport.grpc.LibService", 1, _LibService_methods)

LibService(impl::Module) = ProtoService(_LibService_desc, impl)

mutable struct LibServiceStub <: AbstractProtoServiceStub{false}
    impl::ProtoServiceStub
    LibServiceStub(channel::ProtoRpcChannel) = new(ProtoServiceStub(_LibService_desc, channel))
end # mutable struct LibServiceStub

mutable struct LibServiceBlockingStub <: AbstractProtoServiceStub{true}
    impl::ProtoServiceBlockingStub
    LibServiceBlockingStub(channel::ProtoRpcChannel) = new(ProtoServiceBlockingStub(_LibService_desc, channel))
end # mutable struct LibServiceBlockingStub

execute(stub::LibServiceStub, controller::ProtoRpcController, inp::Channel{InMessage}, done::Function) = call_method(stub.impl, _LibService_methods[1], controller, inp, done)
execute(stub::LibServiceBlockingStub, controller::ProtoRpcController, inp::Channel{InMessage}) = call_method(stub.impl, _LibService_methods[1], controller, inp)

export LibService, LibServiceStub, LibServiceBlockingStub, execute
