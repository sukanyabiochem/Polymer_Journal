#!/usr/bin/env bash
#SBATCH --job-name=mod-beads
#SBATCH --output=CG-pluronic.log
#SBATCH --ntasks-per-node=24
#SBATCH -N 1
#SBATCH -p long 
#SBATCH --time=48:00:00      # hh:mm:ss for the job
#SBATCH --mail-user=sukanya.konar@stonybrook.edu
#SBATCH --mail-type="BEGIN,END" # See sbatch or srun man pages for more email options

source /lustre/home/sukonar/software/gromacs-2024.5/bin/GMXRC.bash

cd $SLURM_SUBMIT_DIR

for bead_a in SC6 TC6 TC5e
do
for bead_b in SP1ar C3
do
gmx rdf -f equil5.whole.xtc -ref $bead_a -seltype atom -sel $bead_b -n pluronic-cation.ndx -o rdf-$bead_a-$bead_b.xvg
rm -rf \#*
done
done
