using Communicator

endpoint = "tcp://127.0.0.1:8888"

function meta()
    @client endpoint begin
        f = fn(UInt32) => UInt32
        g = fn(UInt32) => String
    end

    res1 = f(UInt32(2))
    println("f(2) = $res1")
    res2 = g(res1)
    println("g($res1) = $res2")
end

function nemeta()
    f = fn["f", endpoint](UInt32) => UInt32
    g = fn["g", endpoint](UInt32) => String

    res1 = f(UInt32(2))
    println("f(2) = $res1")
    res2 = g(res1)
    println("g($res1) = $res2")
end

function main()
    println("Meta:")
    meta()
    println("Nemeta:")
    nemeta()
    println("Done!")
end

main()
