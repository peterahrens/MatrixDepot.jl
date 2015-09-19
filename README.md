
# ![logo](doc/logo2.png) Matrix Depot 

[![Build Status](https://travis-ci.org/weijianzhang/MatrixDepot.jl.svg?branch=master)](https://travis-ci.org/weijianzhang/MatrixDepot.jl)

An extensible test matrix collection for Julia.

* [Documentation](http://matrixdepotjl.readthedocs.org/en/latest/)

* [Demo](https://github.com/weijianzhang/MatrixDepot.jl/blob/master/doc/MatrixDepot_Demo.ipynb)

* [Release Notes](https://github.com/weijianzhang/MatrixDepot.jl/blob/master/NEWS.md)

**NOTE:** If you use Windows, you need to install MinGW/MSYS or
  Cygwin in order to use the UF sparse matrix collection interface.

## Install

To install the release version, type

```julia
julia> Pkg.add("MatrixDepot")
```

## Basic Usage

To see all the matrices in the collection, type

```julia
julia> matrixdepot()

Matrices:
   1) baart            2) binomial         3) cauchy           4) chebspec      
   5) chow             6) circul           7) clement          8) deriv2        
   9) dingdong        10) fiedler         11) forsythe        12) foxgood       
  13) frank           14) grcar           15) hadamard        16) heat          
  17) hilb            18) invhilb         19) invol           20) kahan         
  21) kms             22) lehmer          23) lotkin          24) magic         
  25) minij           26) moler           27) neumann         28) oscillate     
  29) parter          30) pascal          31) pei             32) phillips      
  33) poisson         34) prolate         35) randcorr        36) rando         
  37) randsvd         38) rohess          39) rosser          40) sampling      
  41) shaw            42) toeplitz        43) tridiag         44) triw          
  45) vand            46) wathen          47) wilkinson       48) wing          

Groups:
  data          eigen         ill-cond      inverse
  pos-def       random        regprob       sparse
  symmetric
```

We can generate a Hilbert matrix of size 4 by typing

```julia
julia> matrixdepot("hilb", 4)
4x4 Array{Float64,2}:
 1.0       0.5       0.333333  0.25    
 0.5       0.333333  0.25      0.2     
 0.333333  0.25      0.2       0.166667
 0.25      0.2       0.166667  0.142857
```

We can type the matrix name to see the parameter options and matrix
properties.

```julia
julia> matrixdepot("hilb")
Hilbert matrix:
             
 Input options:
             
 [type,] dim: the dimension of the matrix
             
 [type,] row_dim, col_dim: the row and column dimension
             
 ['inverse', 'ill-cond', 'symmetric', 'pos-def']
             
 Reference: M.-D. Choi, Tricks or treats with the Hilbert matrix,
             Amer. Math. Monthly, 90 (1983), pp. 301-312.
             N.J. Higham, Accuracy and Stability of Numerical Algorithms,
             Society for Industrial and Applied Mathematics, Philadelphia, PA,
             USA, 2002; sec. 28.1.
```

We can also specify the data type

```julia
julia> matrixdepot("hilb", Float16, 5, 3)
5x3 Array{Float16,2}:
 1.0      0.5      0.33325
 0.5      0.33325  0.25   
 0.33325  0.25     0.19995
 0.25     0.19995  0.16663
 0.19995  0.16663  0.14282
```

Matrices can be accessed by number.

```julia
julia> matrixdepot(5)
"chow"

julia> matrixdepot(5:10)
6-element Array{ASCIIString,1}:
 "chow"    
 "circul"  
 "clement" 
 "deriv2"  
 "dingdong"
 "fiedler" 
```

By typing a matrix name, we can see what properties that matrix have.
Conversely, if we type a property (or properties), we can see all the 
matrices (in the collection) having that property (or properties).

```julia
julia> matrixdepot("symmetric")
18-element Array{ASCIIString,1}:
 "hilb"     
 "cauchy"   
 "circul"   
 "dingdong" 
 "invhilb"  
 "moler"    
 "pascal"   
 "pei"      
 "clement"  
 "fiedler"  
 "minij"    
 "tridiag"  
 "lehmer"   
 "randcorr" 
 "poisson"  
 "wilkinson"
 "kms"      
 "wathen" 
```

## Extend Matrix Depot

We can add more matrices to Matrix Depot by downloading them from UF
sparse matrix collection and Matrix Market. See
[here](http://matrixdepotjl.readthedocs.org/en/latest/interface.html)
for more details.

We can add new groups of matrices. See
[here](http://matrixdepotjl.readthedocs.org/en/latest/properties.html)
for more details.

## Interface to the UF Sparse Matrix Collection 

Use ``matrixdepot(NAME, :get)``, where ``NAME`` is ``collection
name + '/' + matrix name``, to download a test matrix from the University of
Florida Sparse Matrix Collection:
http://www.cise.ufl.edu/research/sparse/matrices/list_by_id.html.  For
example:

```julia
julia> matrixdepot("HB/1138_bus", :get)
```
When download is complete, we can check matrix information using

```julia
julia> matrixdepot("HB/1138_bus")
%%MatrixMarket matrix coordinate real symmetric
%----------------------------------------------------------------------
% UF Sparse Matrix Collection, Tim Davis
% http://www.cise.ufl.edu/research/sparse/matrices/HB/1138_bus
% name: HB/1138_bus
% [S ADMITTANCE MATRIX 1138 BUS POWER SYSTEM, D.J.TYLAVSKY, JULY 1985.]
% id: 1
% date: 1985
% author: D. Tylavsky
% ed: I. Duff, R. Grimes, J. Lewis
% fields: title A name id date author ed kind
% kind: power network problem
%---------------------------------------------------------------------
```
and generate it with the Symbol ``:r`` or ``:read``.

```julia
julia> matrixdepot("HB/1138_bus", :r)
1138x1138 Base.LinAlg.Symmetric{Float64,Base.SparseMatrix.SparseMatrixCSC{Float64,Int64}}:
 1474.78      0.0       0.0     …   0.0       0.0         0.0    0.0  
    0.0       9.13665   0.0         0.0       0.0         0.0    0.0  
    0.0       0.0      69.6147      0.0       0.0         0.0    0.0  
    0.0       0.0       0.0         0.0       0.0         0.0    0.0  
   -9.01713   0.0       0.0         0.0       0.0         0.0    0.0  
    0.0       0.0       0.0     …   0.0       0.0         0.0    0.0  
    0.0       0.0       0.0         0.0       0.0         0.0    0.0  
    0.0       0.0       0.0         0.0       0.0         0.0    0.0  
    0.0       0.0       0.0         0.0       0.0         0.0    0.0  
    0.0      -3.40599   0.0         0.0       0.0         0.0    0.0  
    ⋮                           ⋱             ⋮                       
    0.0       0.0       0.0         0.0       0.0         0.0    0.0  
    0.0       0.0       0.0     …   0.0     -24.3902      0.0    0.0  
    0.0       0.0       0.0         0.0       0.0         0.0    0.0  
    0.0       0.0       0.0         0.0       0.0         0.0    0.0  
    0.0       0.0       0.0         0.0       0.0         0.0    0.0  
    0.0       0.0       0.0        26.5639    0.0         0.0    0.0  
    0.0       0.0       0.0     …   0.0      46.1767      0.0    0.0  
    0.0       0.0       0.0         0.0       0.0     10000.0    0.0  
    0.0       0.0       0.0         0.0       0.0         0.0  117.647
```

The NIST Matrix Market interface is similar. See
[documentation](http://matrixdepotjl.readthedocs.org/en/latest/interface.html#interface-to-nist-matrix-market)
for more details.


## References

- Nicholas J. Higham,
  "Algorithm 694, A Collection of Test Matrices in MATLAB",
  *ACM Trans. Math. Software*,
  vol. 17. (1991), pp 289-305
  [[pdf]](http://www.maths.manchester.ac.uk/~higham/narep/narep172.pdf)
  [[doi]](https://dx.doi.org/10.1145/114697.116805)

- T.A. Davis and Y. Hu,
  "The University of Florida Sparse Matrix Collection",
  *ACM Transaction on Mathematical Software*,
  vol. 38, Issue 1, (2011), pp 1:1-1:25
  [[pdf]](http://www.cise.ufl.edu/research/sparse/techreports/matrices.pdf)

- R.F. Boisvert, R. Pozo, K. A. Remington, R. F. Barrett, & J. Dongarra,
  " Matrix Market: a web resource for test matrix collections",
  *Quality of Numerical Software* (1996) (pp. 125-137).
  [[pdf]](http://www.netlib.org/utk/people/JackDongarra/pdf/matrixmarket.pdf)

- Per Christian Hansen,
  "Test Matrices for Regularization Methods",
  *SIAM Journal on Scientific Computing*,
  vol. 16, 2, (1995) pp.506-512.
  [[pdf]](http://epubs.siam.org/doi/abs/10.1137/0916032)
  [[doi]](https://dx.doi.org/10.1137/0916032)
