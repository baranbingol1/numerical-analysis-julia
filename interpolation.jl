using Interpolations

xs = 1.0:0.2:5
ys = log.(xs)

# lineer interpolasyon
interp_lin = linear_interpolation(xs, ys)
interp_cubic = CubicSplineInterpolation(xs, ys)

println("log(3.1) gerçek değeri : ", log(3.1))
println("Lineer interpolasyon ile değeri : ", interp_lin(3.1))
println("Cubic interpolasyon ile değeri : ", interp_cubic(3.1))