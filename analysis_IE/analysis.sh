## GROMACS excutable calling ##
## extracting the energy term from the gromacs output files (.edr) ##
for num in  3 4 5 6 7 8  
do
echo -e "16 0" | gmx energy -f ie${num}.edr -o EO-EMI-LJ-equil$num.xvg
done

## Plotting and analysis of the average values of IE ##
python IE-modify.py 
