# Polymer_Journal
This repository contains a coarsed-grained (CG) molecular dynamics workflow built around VMD, Tk/tcl, GROMACS, bash script. The pipeline performs four major tasks:


1. Run GROMACS MD simulation stages for minimization, NVT equilibration, NPT equilibration, and production dynamics in NPT condition.
2. Before the analysis in GROMACS production trajectory is processed and then analysis performed using GROMACS tools, Tk/tcl tools and Python.
3. After the analysis, the out files plotted using Python.

## Repository Layout ##
1. analysis_2D_plot/ : Python script for the calculation of 2D dynamical density profile for the simulation trajectory.
2. analysis_IE/ : Automatic script for the preparation of all GROMACS input file and submission of jobs (HPC) for interaction between the system components, and then plot them and get the avergae value of last 300 ns of simulation.
3. analysis_ML_Kappa/ : Python script for analysis of MD simulation trajectory using ML based algorithm.
4. analysis_RDF/ : Bash script for post processing of the MD simulation trajectory and then calculated radial distribution function (RDF) in HPC and plot them using python script.
5. analysis_chain_morphology/ : tcl/Tk script for the analysis of chains flexibility during the production run, a bash script help to run the previous script for the automation, this script helps to analysis big trajectory using reasonable number of memory of the computer. Finally, the python script plot the data in 2D format.
6. analysis_density_box/ : Automatic bash script for processing of the trajectory (in HPC) and calculate the 2D density with respect to simulation box. Poltting the data uisng the python script.
7. conf/ : All the input file used for the MD simulation run from Energy minimization ---> NVT equlibration ---> NPT equlibration ---> NPT production run. Details of the using sequence of the files are mentioned in the jobs_script/script.slurm.
8. jobs_script/ : Automatic submission script to run the steps MD simulation in HPC. 

## Prerequisites ##
Install the following tools and make sure that they are on your PATH:
1. VMD with all the additional tools such as pbctools.
2. GROMACS updated verswion.
3. Python 3.10 or newer version.
4. A PBS/SLURM schedular to use the job scripts.

## Required Input Files ##
This repo does not contain the system specific  coordinate/topology & Parameter files. Before, running the workflow of analysis and simulation, collect all the files such as : 
1. Initial Coordinate file of the Polymer+[EMIM][DCA] IL systems generated using PACKMOL: .gro file
2. Topolgy files that conatin the detail information of Molecules present in the system : topolo.top
3. All the files with parameter information of the molecules : itp file
4. Index number of each of molecules and group : index.ndx

## Cluster Usage ##
Submit the MD simulation workflow in HPC cluster: 
sbatch script.slurm
