n = 7  # rand(1:10)
m = 17 # rand(1:20)
A = matrixdepot("pei", n, m)
B = ones(n,n)
@test issymmetric(A)
@test matrixdepot("pei", n) - triu(B) - tril(B) ≈ zeros(n,n)
println("'pei' passed test...") 
