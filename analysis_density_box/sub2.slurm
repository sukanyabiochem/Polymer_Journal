#!/usr/bin/env bash
#SBATCH --job-name=density-prep
#SBATCH --output=density-prep.log
#SBATCH --ntasks-per-node=1
#SBATCH -N 1
#SBATCH -p long 
#SBATCH --time=48:00:00      # hh:mm:ss for the job
#SBATCH --mail-user=sukanya.konar@stonybrook.edu
#SBATCH --mail-type="BEGIN,END" # See sbatch or srun man pages for more email options

module load openmpi/gcc13.1.0/4.1.5
module load CPE/23.02

export GMXDIR=/lustre/home/sukonar/software/gromacs-2025.1/bin

GMX=/lustre/home/sukonar/software/gromacs-2025.1/bin/gmx_mpi

##echo -e "2 & a EO \n name 5 EO \n 2 & a PO \n name 6 PO \n del 0-4 \n q" | mpiexec -np 1 $GMX make_ndx -f ../equil8.tpr -o dens_PEO-PPO.ndx


##echo -e "4 & a C06 \n name 5 SC6 \n 4 & a C01 \n name 6 TC6 \n 4 & a C04 \n name 7 TC5e \n del 0-4 \n q" | mpiexec -np 1 $GMX make_ndx -f ../equil5.tpr -o cation.ndx


##echo 0 | mpiexec -np 1 $GMX trjconv -s ../equil7.tpr -f ../equil7.xtc -o equil7.whole.xtc -pbc whole

##echo 0 | mpiexec -np 1 $GMX trjconv -s ../equil8.tpr -f ../equil8.xtc -o equil8.whole.xtc -pbc whole

echo -e "0 \n 6" | mpiexec -np 1 $GMX density -sl 95 -f md-400-600ns.xtc -s ../equil7.tpr -center -n density-index.ndx -o density-EO.xvg

echo -e "0 \n 5" | mpiexec -np 1 $GMX density -sl 95 -f md-400-600ns.xtc -s ../equil7.tpr -center -n density-index.ndx -o density-PO.xvg
