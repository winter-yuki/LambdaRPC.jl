module Lib

# struct Point {
#     x::Double
#     y::Double
# }

square(x::UInt32)::UInt32 = x * x

# function distance(a::Point, b::Point)::Point
#     dx = a.x - b.x
#     dy = a.y - b.y
#     sqrt(dx * dx - dy * dy)
# end

# makePoint(x::Double, y::Double) = Point(x, y)

# any(xs::Vector{Int64}, p) = any(p, xs)

end # module

using .Lib
using Communicator

function main()
    endpoint = "tcp://127.0.0.1:8888"
    @libserver server endpoint begin
        square:Lib.square::UInt32 => UInt32
    end
    startblocking(server)
end

main()
