## Call the gromacs excutable and dependies ##
module load foss/2024a

module load OpenMPI/5.0.3-GCC-13.3.0

export GMXDIR=/projects/cme_santc_chi/skonar/software/gromacs-2025.2/bin

GMX=/projects/cme_santc_chi/skonar/software/gromacs-2025.2/bin/gmx_mpi

## create the index file for interaction energy run ##
echo -e "2 & a EO \n name 5 EO \n 2 & a PO \n name 6 PO \n 3|4 \n name 7 IL \n q" | $GMX make_ndx -f ../equil3.tpr -o energy.ndx


## Gromacs input file generation ##
dt=0.01
nsteps=5000000
nstep1=20000000


for j in 3 4 5 6 7 8  
do
    if [ "$j" -eq 3 ]; then
        current_nsteps=$nsteps
    else
        current_nsteps=$nstep1
    fi

##    tstart=$(awk "BEGIN {print ($j-3)*$dt*$current_nsteps}")

cat > equil${j}.mdp <<EOF
title                   = Polymer-IL CG MD simulation (interaction energy) 
; Run parameters
integrator               = md
; start time and timestep in ps =
tinit                    = ${tstart_ps}
dt                       = ${dt}

nsteps                   = ${current_nsteps}
nstcomm                  = 1000

nstxout                  = 1000
nstvout                  = 1000
nstfout                  = 1000
nstlog                   = 1000
nstenergy                = 1000
nstxout-compressed       = 1000
compressed-x-precision   = 1000
energygrps              = sub1 sub2
; Bond parameters
continuation            = yes       ; continuing from NPT 
constraint_algorithm    = lincs     ; holonomic constraints 
constraints             = h-bonds   ; bonds to H are constrained
lincs_iter              = 1         ; accuracy of LINCS
lincs_order             = 4         ; also related to accuracy
; Neighbor searching and vdW
cutoff-scheme           = Verlet
ns_type                 = grid      ; search neighboring grid cells
nstlist                 = 20        ; largely irrelevant with Verlet
vdwtype                 = cutoff
vdw-modifier            = Potential-shift-verlet
rvdw                    = 3.5       ; short-range van der Waals cutoff (in nm)
verlet-buffer-tolerance  = 0.005
; Electrostatics
coulombtype             = reaction-field       ; Particle Mesh Ewald for long-range electrostatics
rcoulomb                = 3.5
epsilon_r               = 15                   ; 2.5 (with polarizable water)
epsilon_rf              = 0
; Temperature coupling
tcoupl                  = Nose-Hoover                   ; modified Berendsen thermostat
tc-grps                 = system                      ; two coupling groups - more accurate
tau_t                   = 1.0                        ; time constant, in ps
ref_t                   = 300                    ; reference temperature, one for each group, in K
; Pressure coupling 
pcoupl                  = Parrinello-Rahman             ; pressure coupling is on for NPT
pcoupltype              = isotropic                     ; uniform scaling of box vectors
tau_p                   = 12.0                          ;parrinello-rahman is more stable with larger tau-p, DdJ, 20130422                     
ref_p                   = 1.0                           ; reference pressure, in bar
compressibility         = 4.5e-5                        ; isothermal compressibility of water, bar^-1
; Periodic boundary conditions
pbc                     = xyz       ; 3-D PBC
; Dispersion correction is not used for proteins with the C36 additive FF
DispCorr                = no 
; Velocity generation
gen_vel                 = no        ; continuing from NPT equilibration 
EOF
# update for next file
increment=$(awk "BEGIN {printf \"%d\", ($dt*$current_nsteps)}")
    tstart_ps=$((tstart_ps + increment))
##    tstart=$(awk "BEGIN {print $tstart + $dt*$current_nsteps}")
done
## replace the energy group in the gromacs input file ##
##cd archive
for i in 3 4 5 6 7 8 
do 
sed -i 's/sub1/EO/g; s/sub2/EMI/g' equil${i}.mdp
done

## submission script for job ##
cat > sub2.slurm <<EOF
#!/bin/bash
##SBATCH --mem=0 
#SBATCH --partition=batch
#SBATCH --job-name=proc
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=32
#SBATCH --time=48:10:00
#SBATCH --output=myjob_%j.log
#SBATCH --mail-user=skonar@uic.edu
#SBATCH --mail-type=END,FAIL
#SBATCH --export=ALL


module load foss/2024a

module load OpenMPI/5.0.3-GCC-13.3.0

export GMXDIR=/projects/cme_santc_chi/skonar/software/gromacs-2025.2/bin

GMX=/projects/cme_santc_chi/skonar/software/gromacs-2025.2/bin/gmx_mpi

cd \$SLURM_SUBMIT_DIR

EOF

for i in  3 4 5 6 7 8 
do 
cat >> sub2.slurm <<EOF	
\$GMX grompp -f equil${i}.mdp -c ../equil${i}.gro -t ../equil${i}.cpt -p ../topolo.top -n energy.ndx -o ie${i}.tpr
mpiexec -np 32 \$GMX mdrun -rerun ../equil${i}.xtc -deffnm ie${i} -ntomp 1
EOF
done

## submission of jobs ##
sbatch sub2.slurm

