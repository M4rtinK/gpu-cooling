// bottom clamp for the H2 cooling block holder

// m4 nut
nut_width = 7.2;
nut_height = 3.6;
holder_width = 55.2;

// m4 screw
screw_diameter = 4;

difference(){
    // main block
    cube([50,130,10]);
    // holder block cutout
    translate([0,30,5]) {
        cube([50, holder_width, 5]);
    }
    // fan cutout - 25 mm front
    translate([0, 80, 9]) {
        cube([50, 25.2, 1]);
    }
    // fan cutout - 15 mm back
    translate([0, 15, 9]) {
        cube([50, 15.2, 1]);
    }    
    // vertical hole 1
    translate([25, 10, 0]) {
        cylinder(d=screw_diameter, h=100, $fn=100);
    }
    // vertical hole 2
    translate([25, 118, 0]) {
        cylinder(d=screw_diameter, h=100, $fn=100);
    }
    // horiozontal hole
    translate([25-nut_width/2.0, -30, 2.5]) {
        cube([nut_width, 170, nut_height]);
    }
}