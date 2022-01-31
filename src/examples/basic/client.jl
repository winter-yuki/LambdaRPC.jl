module Lib

using LambdaRPC

@facade "f74127d2-d27f-4271-b46e-10b79143260e" begin
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
