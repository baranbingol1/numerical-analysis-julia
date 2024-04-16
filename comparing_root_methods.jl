using BenchmarkTools

const global eps = 0.05;

# nümerik türev alma
function derivative(f::Function, x, h)
    x = Float32(x);
    h = Float32(h);
    return (f(x + h) - f(x)) / h;
end

function bisection_method(f::Function, x0, x1)
    
    x0 = Float32(x0);
    y0 = f(x0);
    x1 = Float32(x1);
    xp = (x1 + x0) / 2.0;
    yp = f(xp);


    if abs(x0 - x1) < eps
        return xp
    elseif y0*yp < 0
        return bisection_method(f, x0, xp)
    else
        return bisection_method(f, xp, x1)
    end
end

function newton_rhapson_method(f::Function, x0)
    x0 = Float32(x0);
    df_dx = derivative(f, x0, 0.0001);
    xp = x0 - f(x0) / df_dx;

    if abs(xp - x0) > eps
        return newton_rhapson_method(f, xp)
    else
        return xp
    end
end

# secant yöntemi aynı zamanda kiriş yöntemi demek
function secant_method(f::Function, x0, x1)
	x0 = Float32(x0);
	x1 = Float32(x1);
	y0 = f(x0);
	y1 = f(x1);
	
	xp = x1 - (y1 * ((x1 - x0) / (y1 - y0)));
	if x0 - x1 < eps
        return xp
    elseif y0*f(xp)
        return secant_method(f, x0, xp)
    else
        return secant_method(f, xp, x1)
    end
end

function regula_falsi_method(f::Function, x0, x1)
	x0 = Float32(x0);
	x1 = Float32(x1);
	xp = 0;
	while abs(x0-x1) > eps
        xp = (x0 + x1) / 2.0;
        y0 = f(x0);
        yp = f(xp);
		if yp*y0 > 0
			x0 = xp;
		else
			x1 = xp;
		end
    end
    return xp;
end

# random polinom üretir
function generate_polynomial(degree)
    coeffs = randn(degree + 1)
    return x -> sum(coeffs[i] * x^(i-1) for i in 1:length(coeffs))
end

degree = 10
polynomial = generate_polynomial(degree)

# testler ve runtime sonuçları
@btime x_kok = bisection_method(polynomial, -10, 10); # 2.144 μs (1 allocation: 16 bytes)
@btime x_kok2 = newton_rhapson_method(polynomial, 0); # 2.811 μs (1 allocation: 16 bytes)
@btime x_kok3 = secant_method(polynomial, -10, 10);  # 215.888 ns (1 allocation: 16 bytes)
@btime x_kok4 = regula_falsi_method(polynomial, -10, 10); # 2.233 μs (1 allocation: 16 bytes)