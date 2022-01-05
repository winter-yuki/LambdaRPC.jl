module Lib

using Communicator

# struct Point
#     x::Double
#     y::Double
# end

@libclient begin
    square::UInt32 => UInt32
#     distance::(Point, Point) => Double
#     makePoint::(Double, Double) => Point
#     any::(Vector{Int64}, Int64 => Bool) => Bool
end

end # module

using .Lib
using Communicator

function main()
    setendpoint(Lib.lib, "tcp://127.0.0.1:8888")
    @assert Lib.square(UInt32(2)) == 4

    # setendpoint(client, "tcp://127.0.0.1:8888")
    # setserializer(client, Cbor)
    # settransport(client, Transport.ZMQ)

    # TODO eval code examples
    # res1 = square(2)
    # println("square(2) = $res1")
    # res2 = distance(Point(1.0, 2.0), Point(4.0, 6.0))
    # println("distance(Point(1.0, 2.0), Point(4.0, 6.0)) = $res2")
    # res3 = makePoint(1.0, 2.0)
    # println("makePoint(1.0, 2.0) = $res3")
    # res4 = any([1, 2, 3], x -> x == 2)
    # println("any([1, 2, 3], x -> x == 2) = $res4")
end

main()
