set i [lindex $::argv 0]
mol new equil11-pbc.gro type gro
mol addfile equil11-pbc.xtc type xtc first $i last $i 

set outfile [open test-angle-equil9.dat "a"]
set c3 {1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79}

foreach atmname $c3 {
        set ligg [atomselect top "resname LIG and resid $atmname" frame $i]
        set serials [$ligg get serial]
	set first_serial [lindex $serials 0]
	set last_serial  [lindex $serials end]
	set end1 [atomselect top "serial $first_serial"]
        set end2 [atomselect top "serial $last_serial"]
        set coord1 [lindex [$end1 get {x y z}] 0]
        set coord2 [lindex [$end2 get {x y z}] 0]
        set simdata [veclength [vecsub $coord1 $coord2]]
        set first20 [lrange $serials 0 19]
        set last20 [lrange $serials [expr {[llength $serials] -19}] end]
	set EO1 [atomselect top "serial $first20"]
        set cm1 [measure center $EO1 weight mass]
        set EO2 [atomselect top "serial $last20"]
        set cm2 [measure center $EO2 weight mass]
        set PO [atomselect top "resname LIG and resid $atmname and name PO"]
        set cm3 [measure center $PO weight mass]
        set vec1_2 [vecsub $cm3 $cm1]
        set vec2_3 [vecsub $cm3 $cm2]
        set angle_top [vecdot $vec1_2 $vec2_3]
        set vec3_2_len [veclength $vec2_3]
        set vec1_2_len [veclength $vec1_2]
        set angle_bottom [vecdot $vec1_2_len $vec3_2_len]
        set angle_cos [expr $angle_top/$angle_bottom]
        set angle_rad [expr acos($angle_cos)]
        puts $outfile "[expr $angle_rad*(180/3.14)] $simdata"
## cleanup
$ligg delete
$EO1 delete
$EO2 delete
$PO delete
$end1 delete
$end2 delete
}
close $outfile
exit
