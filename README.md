# Polymer_Journal
This repository contains a coarsed-grained (CG) molecular dynamics workflow built around VMD, Tk/tcl, GROMACS, bash script. The pipeline performs four major tasks:


1. Run GROMACS MD simulation stages for minimization, NVT equilibration, NPT equilibration, and production dynamics in NPT condition.
2. Before the analysis in GROMACS production trajectory is processed and then analysis performed using GROMACS tools, Tk/tcl tools and Python.
3. After the analysis, the out files plotted using Python.

## Repository Layout ##
1. analysis_2D_plot/ : Python script for the calculation of 2D dynamical density profile for the simulation trajectory.
2. analysis_IE/ : Automatic script for the preparation of all GROMACS input file and submission of jobs for interaction between the system components, and then plot them and get the avergae value of last 300 ns of simulation.
3. analysis_ML_Kappa/ : Python script for analysis of MD simulation trajectory using ML based algorithm.
4. analysis_RDF/ : Bash script for post processing of the MD simulation trajectory and then calculated radial distribution function (RDF) and plot them using python script.
5. analysis_chain_morphology/ : 
