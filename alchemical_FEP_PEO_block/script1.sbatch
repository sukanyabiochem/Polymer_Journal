#!/bin/bash
#SBATCH --mem=0
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=2
#SBATCH --cpus-per-task=32    # <- match to OMP_NUM_THREADS
#SBATCH --partition=cpu      # <- or one of: gpuA100x4 gpuA40x4 gpuA100x8 gpuMI100x8
#SBATCH --account=bcnm-delta-cpu    # <- match to a "Project" returned by the "accounts" command
#SBATCH --job-name=sedstate
#SBATCH --time=01:30:00      # hh:mm:ss for the job
#SBATCH --constraint="scratch&projects"
#SBATCH -o delta_slurm-%j.log
#SBATCH -e delta_slurm-%j.log
#SBATCH --mail-user=skonar@uic.edu
#SBATCH --mail-type="BEGIN,END" # See sbatch or srun man pages for more email options

export OMP_NUM_THREADS=32


export GMXDIR=/projects/bcnm/skonar/software/gromacs-2024.1
GMX=/projects/bcnm/skonar/software/gromacs-2024.1/bin/gmx


cd $SLURM_SUBMIT_DIR

$GMX mdrun -v -deffnm md -ntomp 32 > mdrun.log
