module student


function f(x)
    println("im in f")
    println("im in f")
    # throw(ErrorException)
    return x + 5
end

export f
end