# General Workflow #
This repository contains a coarse-grained (CG) molecular dynamics workflow built around VMD, Tk/tcl, GROMACS, and a Bash script. The pipeline performs four major tasks:

1. Run GROMACS MD simulation stages for minimization, NVT equilibration, NPT equilibration, and production dynamics in NPT conditions.
2. Before the analysis, the GROMACS production trajectory is processed, and then the analysis is performed using GROMACS tools, Tk/tcl tools, and Python.
3. After the analysis, the output files were plotted using Python.
4. This work is published in [Polymer Journal](https://doi.org/10.1016/j.polymer.2026.130125) 

## Repository Layout ##
1. alchemical_FEP_PEO_block/ : GROMACS input file to calculate the Free Energy of Solvation for PEO in [EMIM][DCA] IL (all-atom) and automatic submission script in HPC. Python script to run the alchemical free energy (solvation free energy) from GROMACS out file using JAX for parella run of the job in CPU using multiple thread. 
2. analysis_2D_plot/ : Python script for the calculation of 2D dynamical density profile for the simulation trajectory.
3. analysis_IE/ : Automatic script for the preparation of all GROMACS input files and submission of jobs (HPC) for interaction between the system components, and then plot them and get the average value of the last 300 ns of simulation.
4. analysis_ML_Kappa/ : Python script for analysis of MD simulation trajectory using ML-based algorithm.
5. analysis_RDF/ : Bash script for post-processing of the MD simulation trajectory and then calculating the radial distribution function (RDF) in HPC and plotting them using a Python script.
6. analysis_chain_morphology/ : tcl/Tk script for the analysis of chain flexibility during the production run, a bash script helps to run the previous script for automation, this script helps to analyze big trajectories using a reasonable amount of memory on the computer. Finally, the Python script plots the data in 2D format.
7. analysis_density_box/ : Automatic bash script for processing the trajectory (in HPC) and calculating the 2D density with respect to the simulation box. Plotting the data using the Python script.
8. conf/ : All the input file used for the MD simulation run from Energy minimization ---> NVT equlibration ---> NPT equlibration ---> NPT production run. Details of the sequence of using the files are mentioned in the jobs_script/script.slurm.
9. jobs_script/ : Automatic submission script to run the steps MD simulation in HPC. 

## Prerequisites ##
Install the following tools and make sure that they are on your PATH:
1. VMD with all the additional tools, such as pbctools.
2. GROMACS updated version.
3. Python 3.10 or newer version.
4. A PBS/SLURM scheduler to use the job scripts.

## Required Input Files ##
This repo does not contain the system-specific  coordinate/topology & Parameter files. Before running the workflow of analysis and simulation, collect all the files such as : 
1. Initial Coordinate file of the Polymer+[EMIM][DCA] IL systems generated using PACKMOL: .gro file
2. Topology files that contain the detailed information of Molecules present in the system: topolo.top
3. All the files with parameter information of the molecules: itp file
4. Index number of each of the molecules and group: index.ndx

## Cluster Usage ##
Submit the MD simulation workflow in the HPC cluster: 
sbatch script.slurm
