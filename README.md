# Continuous-Time Network Evolution Model - Simulation Code

This repository contains the simulation code for the continuous-time network evolution model as described in the accompanying paper. The simulation is implemented in the Julia programming environment, leveraging its dynamic structure for efficient numerical computations.

## Overview

The model focuses on the evolution of networks based on N-interactions among nodes, represented as cliques of varying sizes. This setup simulates interactions and cooperation within dynamically evolving networks, supporting theoretical results derived from branching processes.

The simulation provides empirical evidence for the model's asymptotic properties, particularly validating Theorem 5.1 concerning clique count growth over time on a logarithmic scale.

## Requirements

To run the simulation, ensure the following dependencies are met:

- **Julia 1.x** or higher
- Julia packages for numerical and statistical analysis 
   ``` julia
   using Pkg
   Pkg.add(["DataStructures", "DelimitedFiles", "Distributions"])

## Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/bartaa89/n_interact.git
   cd n_interact

