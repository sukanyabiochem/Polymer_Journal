#!/bin/bash
##[ -e Index-file-EMIM-SC6-RP.dat] && rm Index-file-EMIM-SC6-RP.dat

echo "Bash version ${BASH_VERSION}..."

for ((i=0; i<=10001; i+=50));
do
vmd -dispdev text -e test-RP.tcl -args $i
echo $i 
done
