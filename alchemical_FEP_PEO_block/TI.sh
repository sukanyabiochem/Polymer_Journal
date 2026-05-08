#!/bin/bash
basedir=$(pwd)

export GMXDIR=/projects/bcnm/skonar/software/GPU-GROMACS/gromacs-2024.1/bin
GMX=/projects/bcnm/skonar/software/GPU-GROMACS/gromacs-2024.1/bin/gmx_mpi
##module load gromacs/2022.5.cuda

rm -rf \#*
set -e

for state in {11..20}
do
    mkdir -p $state
    sed -e "s/sedstate/$state/" md1.mdp > $state/md1.mdp
    sed -e "s/sedstate/$state/" script1.sbatch > $state/script1.sbatch
    cd $state
    $GMX grompp -f md1.mdp -p ../topol1.top -c ../equil-1.gro -n ../index.ndx -o md.tpr -maxwarn 2
    sbatch script1.sbatch
    rm -rf \#*
    cd ../
done
