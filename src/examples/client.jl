import Communicator as Co

function main()
    endpoint = "tcp://127.0.0.1:8888"
    # TODO make macro
    f = Co.fn["f", endpoint](UInt32) >> UInt32
    g = Co.fn["g", endpoint](UInt32) >> String
    res1 = f(UInt32(2))
    println("res1 = $res1")
    res2 = g(UInt32(5))
    println("res2 = $res2")
end

main()