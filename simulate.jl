using DataStructures
using DelimitedFiles
using Distributions

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

# Number of simulations
NS = 100

for j in 1:NS
    ext = false
    times = []
    types = []
    while !ext
        (ext,times,types) = sim(N,ancestor,M,b,c)
    end
    writedlm(j*".txt", [times,types])
end
