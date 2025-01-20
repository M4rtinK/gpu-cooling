screw_hole_diameter = 4.5;
screw_head_diameter = 8;
screw_hole_offset = 2.5;
plate_thickness = 5;
fn = 100;

difference() {
    union() {
        difference() {
            translate([0, 3.6, 0]) {
                cube([95, 94, plate_thickness],true);            
            }
            // ziptie groves
            // - for 5 m wide zip ties
            translate([85/2-10/2+3, -50, -10]) {
                cube([5.5, 150, 10]);
            }    
            translate([-85/2-3.5, -50, -10]) {            
                cube([5.5, 150, 10]);
            }             
            // hole 1
            translate([35.75,35.75,0]) {
                cylinder(h = 40, d=screw_hole_diameter, center = true, $fn=fn);
            }
            translate([35.75,35.75,screw_hole_offset]) {
                cylinder(h = 4, d=screw_head_diameter, center = true, $fn=fn);
            }
            
            // hole 2
            translate([-35.75,35.75,0]) {
                cylinder(h = 40, d=screw_hole_diameter, center = true, $fn=fn);
            }
            translate([-35.75,35.75,screw_hole_offset]) {
                cylinder(h = 4, d=screw_head_diameter, center = true, $fn=fn);
            }
            
            // hole 3
            translate([-35.75,-35.75,0]) {
                cylinder(h = 40, d=screw_hole_diameter, center = true, $fn=fn);
            }
            translate([-35.75,-35.75,screw_hole_offset]) {
                cylinder(h = 4, d=screw_head_diameter, center = true, $fn=fn);
            }
            
            // hole 4                        
            translate([35.75,-35.75,0]) {
                cylinder(h = 40, d=screw_hole_diameter, center = true, $fn=fn);
            }
            translate([35.75,-35.75,screw_hole_offset]) {
                cylinder(h = 4, d=screw_head_diameter, center = true, $fn=fn);
            }            
        }
        translate([0, 0, plate_thickness/2]) {
            // outer cylinder
            cylinder(h = 3, d=72.8, center = true, $fn=fn);
        }
    }
    // inner cylinder
    cylinder(h = 20, d=71, center = true, $fn=fn);
    translate([0,0,3.5]) {
        cylinder(h = 20, d1=82, d2=52, center = true, $fn=fn);
    }
}


       
