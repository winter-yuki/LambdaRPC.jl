module Lib

using LambdaRPC

@facade begin
    add5::Int => Int
end

end # module

using LambdaRPC
using .Lib

function main()
    setendpoint(Lib.lib, "localhost", 8088)
    println(Lib.add5(37))
end

main()
