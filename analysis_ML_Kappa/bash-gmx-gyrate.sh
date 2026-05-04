## calculation of radius of gyration for traj ##
for num in 8
do	
gmx gyrate-legacy -s ../equil$num.tpr -f ../equil$num.pbc.xtc -o Rg-equil$num-300K.xvg -n index_Rg.ndx -p
done 
