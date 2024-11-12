using DataStructures
using DelimitedFiles
using Distributions
using QuadGK
using LinearAlgebra

@doc """
    sim(N,ancestor,M,b,c)

Inputs: 
    N: 
        number of simulated events, including birth/death of cliques
    ancestor: 
        type of the ancestor (e.g. 2 -> edge, 3 -> triangle, etc.)
    M:
        the transition matrix
    b, c:
        parameters of the hazard function  

Outputs:
    true/false:
        network survival
    times:
        birth event times
    types:
        type of a clique at certain birth time

Example:
    N = 10^3; ancestor = 2;
    M = [0.5   0.5   0.0   0.0
        0.25  0.5   0.25  0.0
        0.0   0.25  0.5   0.25
        0.0   0.0   0.5   0.5];
    b = .1; c = .1;
    sim(N,ancestor,M,b,c)
""" ->

function sim(N,ancestor,M,b,c)
  
  ty_num = size(M)[1]-1

  Y = PriorityQueue() 
  cnt=1
  Y[cnt] = (0.,ancestor) 
  times = zeros(N)
  types = zeros(Int8,N)

  for i in 1:N
        if isempty(Y) 
	      return (false,times,types)	
        end
        (x,(TIME,typ)) = peek(Y) 
        dequeue!(Y)

	times[i] = TIME
	types[i] = typ

	distr = M[typ,:]

	chld = 0
	t = 0.
	
	while true
		tt = -log(rand())
	        t += tt
                if rand()>=exp(-(b*tt+c*tt*chld))
                   break;
                end
		chldtype = wsample(0:ty_num,distr)+1
		cnt += 1
		Y[cnt] = (TIME+t,chldtype)
		chld += 1
	end
  end
(true,times,types)
end

### Example
N = 10^3; ancestor = 2;
M = [0.5   0.5   0.0   0.0
        0.25  0.5   0.25  0.0
        0.0   0.25  0.5   0.25
        0.0   0.0   0.5   0.5];
b = .1; c = .1;

###
# Number of simulations
function procmaker(filename,NP)
    TIMES = []; TYPES = [];

    for j in 1:NP
        ext = false
        times = []
        types = []
        while !ext
            (ext,times,types) = sim(N,ancestor,M,b,c)
        end
        TIMES = [TIMES; times]
        TYPES = [TYPES; types]
        #writedlm(j*".txt", [times,types])
    end

    writedlm(filename, [times,types])
end
###
# Malthusian approxiamtion

@doc"""
    malt(M)

Input:
    M: 
        transition matrix

Output:
    slope:
        approximation of the Malthusian parameter
""" ->
function malt(M)
    function secant(f,x0,x1,tol=1e-14)
        f0=f(x0)
        f1=f(x1)
        while abs(x1-x0)>tol
          x2=x1-f1*(x1-x0)/(f1-f0)#; print(x2)
          f0=f1
          x0=x1
          f1=f(x2)
          x1=x2
        end
        x1
    end
  ty_num = size(M)[1]

  v = eigvecs(M)[:,ty_num]
  v = v / sum(v)
  u = eigvecs(M')[:,ty_num]
  u = v.*u
  u = u / sum(u)

  function A(x)
    f(u)=1/c*(1-u)^((x+b+1)/c-1)*exp(u/c)
    quadgk(f,0,1)[1]-1
  end

  slope = secant(A,0.1,0.6)
end
