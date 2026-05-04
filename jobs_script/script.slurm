#!/usr/bin/env bash
#SBATCH --job-name=micelle-test
#SBATCH --output=CG-pluronic.log
#SBATCH --error=CG-pluronic.err
#SBATCH -N 6                # Number of nodes
#SBATCH --ntasks-per-node=8   # Total MPI ranks per node
#SBATCH --partition=long
#SBATCH --time=48:00:00
#SBATCH --mail-user=sukanya.konar@stonybrook.edu
#SBATCH --mail-type=BEGIN,END,FAIL


##export OMP_NUM_THREADS=2
##export OMP_PLACES=cores
##export OMP_PROC_BIND=close

module load openmpi/gcc13.1.0/4.1.5
module load CPE/23.02

export GMXDIR=/lustre/home/sukonar/software/gromacs-2025.1/bin

GMX=/lustre/home/sukonar/software/gromacs-2025.1/bin/gmx_mpi

cd $SLURM_SUBMIT_DIR

#cd /projects/bcnm/skonar/IL-PEO/saber-run
#source /projects/bcnm/skonar/software/gromacs-2024.1/bin/GMXRC.bash

##$GMX grompp -f input-file/minim.mdp -c min2.gro -p topolo.top -n index.ndx -o min3.tpr
##mpiexec -np 48 $GMX mdrun -v -deffnm min3 

##$GMX grompp -f input-file/nvt.mdp -c min3.gro -p topolo.top -n index.ndx -o equil1.tpr
##mpiexec -np 48 $GMX mdrun -deffnm equil1 -ntomp 6 

##$GMX grompp -f input-file/martini_v3.x_example.mdp -c equil1.gro -t equil1.cpt -p topolo.top -n index.ndx -o equil2.tpr -maxwarn 2
##mpiexec -np 48 $GMX mdrun -s equil2.tpr -deffnm equil2 -ntomp 6 

##$GMX grompp -f input-file/martini_v3.1.mdp -c equil2.gro -t equil2.cpt -p topolo.top -n index.ndx -o equil3.tpr -maxwarn 2
##mpiexec -np 48 $GMX mdrun -s equil3.tpr -deffnm equil3 -ntomp 6 

##$GMX grompp -f input-file/martini_v3.5.mdp -c equil3.gro -t equil3.cpt -p topolo.top -n index.ndx -o equil4.tpr
##mpiexec -np 48 $GMX mdrun -s equil4.tpr -deffnm equil4 -ntomp 6 

##$GMX grompp -f input-file/martini_v3.6.mdp -c equil4.gro -t equil4.cpt -p topolo.top -n index.ndx -o equil5.tpr
##mpiexec -np 48 $GMX mdrun -s equil5.tpr -deffnm equil5 -ntomp 6 

##$GMX grompp -f input-file/martini_v3.7.mdp -c equil5.gro -t equil5.cpt -p topolo.top -n index.ndx -o equil6.tpr
##mpiexec -np 48 $GMX mdrun -s equil6.tpr -deffnm equil6 -ntomp 6 

##$GMX grompp -f input-file/martini_v3.8.mdp -c equil7.gro -t equil7.cpt -p topolo.top -n index.ndx -o equil8.tpr
##mpiexec -np 48 $GMX mdrun -s equil8.tpr -deffnm equil8 -ntomp 6 

$GMX grompp -f input-file/martini_v3.9.mdp -c equil8.gro -t equil8.cpt -p topolo.top -n index.ndx -o equil9.tpr
mpiexec -np 48 $GMX mdrun -s equil9.tpr -deffnm equil9 -ntomp 6 
