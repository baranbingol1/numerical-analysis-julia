function exp_taylor(x, n)
    result = 0.0
    for i = 0:n
        result += (x)^i / factorial(big(i))
    end
    return result
end

function sin_taylor(x, n)
    result = 0.0
    for i = 0:n
        result += (-1)^i*(x)^(2*i+1) / factorial(big(2*i+1))
    end
    return result
end

function cos_taylor(x, n)
    result = 0.0
    for i = 0:n
        result += (-1)^i*(x)^(2*i) / factorial(big(2*i))
    end
    return result
end

# testler
n_steps = 20
println(exp_taylor(5, n_steps))
println(sin_taylor(1, n_steps))
println(cos_taylor(1, n_steps))