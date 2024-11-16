# Continuous-Time Network Evolution Model Describing *N*-interactions -- Simulation Code

This repository contains the simulation code for the continuous-time network evolution model as described in the accompanying paper. The simulation is implemented in the Julia programming environment, leveraging its dynamic structure for efficient numerical computations.

## Overview

The model focuses on the evolution of networks based on N-interactions among nodes, represented as cliques of varying sizes. This setup simulates interactions and cooperation within dynamically evolving networks, supporting theoretical results derived from branching processes.

The simulation provides empirical evidence for the model's asymptotic properties, particularly validating Theorem 5.1 concerning clique count growth over time on a logarithmic scale.

## Requirements

To run the simulation, ensure the following dependencies are met:

- **Julia 1.x** or higher and **R**
- Julia packages required: 
   ``` julia
   using Pkg
   Pkg.add(["DataStructures", "DelimitedFiles", "Distributions", "QuadGK", "LinearAlgebra", "DataFrames", "CSV"])

## Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/bartaa89/n_interact.git
   cd n_interact

## Example usage

1. Simulate the process in Julia.
   ```julia
   include("simulate.jl")
   # Define the parameters
   N = 10^3; ancestor = 2;
   M = [0.5   0.5   0.0   0.0;
        0.25  0.5   0.25  0.0;
        0.0   0.25  0.5   0.25;
        0.0   0.0   0.5   0.5];
   b = .1; c = .1;
   # Get the Malthusian parameter
   malt(M)
   # Write process into .csv file
   procmaker("data.csv")

2. Investigate the results in R.
   Use the 'plotter.R' script.
