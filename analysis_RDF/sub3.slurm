#!/usr/bin/env bash
#SBATCH --job-name=mod-beads
#SBATCH --output=CG-pluronic.log
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

echo -e "3 & a N3A \n name 5 TQ5 \n 3 & a CZA \n name 6 TN2ar \n del 0-4 \n q" | mpiexec -np 1 $GMX make_ndx -f ../equil5.tpr -o anion.ndx

echo -e "2 & a EO \n name 5 SP1ar \n 2 & a PO \n name 6 C3 \n del 0-4 \n q" | mpiexec -np 1 $GMX make_ndx -f ../equil5.tpr -o pluronic.ndx

cat pluronic.ndx anion.ndx > anion-pluronic.ndx

echo -e "4 & a C06 \n name 5 SC6 \n 4 & a C01 \n name 6 TC6 \n 4 & a C04 \n name 7 TC5e \n del 0-4 \n q" | mpiexec -np 1 $GMX make_ndx -f ../equil5.tpr -o cation.ndx

cat pluronic.ndx cation.ndx > pluronic-cation.ndx

echo 0 | mpiexec -np 1 $GMX trjconv -s ../equil5.tpr -f ../equil5.xtc -o equil5.whole.xtc -pbc whole

