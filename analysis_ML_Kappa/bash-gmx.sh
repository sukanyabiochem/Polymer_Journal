## alternative command to make index file in gromacs ##
## create the text file ##
cat > residues.txt << EOF
1 2 3 5 6 7 8 9 10 11 12 13 14 16 17 18 19 23 24 27 28 31 32 33 34 36 38 39 40 41 42 45 47 48 49 50 51 53 54 55 56 57 61 62 63 64 65 67 68 69 70 71 72 73 74 75 76 77 78 79
EOF

## gromacs command to select those residues of polymers and create the index file ##
gmx select -s equil8.gro -on index_Rg.ndx -select "resid $(cat residues.txt)"

