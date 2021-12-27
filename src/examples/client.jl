using Communicator

function main()
    @client "tcp://127.0.0.1:8888" begin
        f = fn(UInt32) => UInt32
        g = fn(UInt32) => String
    end

    res1 = f(UInt32(2))
    println("f(2) = $res1")
    res2 = g(res1)
    println("g($res1) = $res2")
end

main()
