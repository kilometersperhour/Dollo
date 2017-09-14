include <include.scad>;
include <globals.scad>;

use <long_tie.scad>;

$fn=20;
switch_length = 20.5;
switch_depth = 6.5;
switch_width = 11;
radius = 1;

module button(){
	difference(){
		hull(){
			translate([radius/2,radius/2,0]) cylinder(h=switch_depth, d=radius);
			translate([switch_length-radius/2,radius/2,0]) cylinder(h=switch_depth, d=radius);
			translate([radius/2,switch_width-radius/2,0]) cylinder(h=switch_depth, d=radius);
			translate([switch_length-radius/2,switch_width-radius/2,0]) cylinder(h=switch_depth, d=radius);
		}
		//union(){
		//	translate([radius/2,radius/2,0]) cylinder(h=switch_depth, d=3);
		//	translate([switch_length-radius/2,switch_width-radius/2,0]) cylinder(h=switch_depth, d=3);
		//}
	}
}
module button_plus(){
	button();
	hull(){
		translate([-5,10,3]) sphere(r=3);
		translate([-5,10,10]) sphere(r=3);
		translate([16,10,3]) sphere(r=3);
		translate([16,10,10]) sphere(r=3);
	}
	
	hull(){
		translate([25,0,3]) sphere(r=3);
		translate([25,0,10]) sphere(r=3);
		translate([5,0,3]) sphere(r=3);
		translate([5,0,10]) sphere(r=3);
	}
}



module endstop_v1() {
    translate([-3,-2,switch_depth+2]) cube([4,9,1]);
    difference(){
        difference(){
            translate([-3,-2,-7]) cube([switch_length+6,switch_width+3,switch_depth+9]);
            translate([0,0,2]) button_plus();
        }
        rotate([90,0,0]) translate([switch_width,-7,-13]) male_dovetail(height=15);
    }
}

module endstop_v2() {
    difference() {
        union() {
            endstop_v1();
            translate([-3,-2,-9]) cube([switch_length+6,switch_width+4,12]);
        }
        translate([switch_length-7,switch_width+2,-9]) rotate([0,0,180]) male_dovetail(height=11);
        translate([-3,switch_width-1,-9]) rotate([0,0,25]) cube([10,10,15]);
    }
}

module endstop_v3() {
    intersection() {
        endstop_v1();
        translate([0,0,10/2]) cube([50,50,10],center=true);
    }
    intersection() {
        translate ([8,50/2+9/2,2]) difference() {
            rotate([0,180,0]) long_tie();
            cube([10,101,4],center=true);
        }
        translate([-3,-2,-7]) cube([switch_length+6,switch_width+3,switch_depth+9]);
    }
}

module z_endstop() {
    difference() {
        union() {
            endstop_v1();
            translate([-3,-9,-9]) cube([switch_length+6,switch_width+11,12]);
        }
        #translate([-5,-2,-9]) rotate([90,0,90]) male_dovetail(height=41);
        translate([-3,switch_width-1,-9]) rotate([0,0,25]) cube([10,10,15]);
    }
    //translate([0,-2,-20]) %cube([30,30,30],center=true);
}


//endstop_v1();
//endstop_v2();
endstop_v3();

module do_tie() {

}
//z_endstop();