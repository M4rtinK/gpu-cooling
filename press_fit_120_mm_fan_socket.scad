collar_height = 6;
collar_outer_width = 125;
// this seems to work good enough for press fit,
// at least with a  Arctic P12 MAX
collar_inner_fan_width = 120.2;
plate_thickness = 6;
fan_screw_hole = 4.3;
fan_screw_head_hole_depth = 2;
fan_screw_head = 8;
fan_screw_distance = 105;
fn = 100;

difference(){
    union(){
        // 120 mm fan mounting plate
        translate([0, plate_thickness, 0]) {
            difference(){
                cube([collar_outer_width, plate_thickness, collar_outer_width], center=true);
                // inner fan hole
                rotate([90, 0, 0]){
                    cylinder(d=116, h=100, center=true, $fn=fn);
                }
                // screw holes
                translate([-fan_screw_distance/2, 0, fan_screw_distance/2]) {
                    rotate([90, 0, 0]){
                        cylinder(d=fan_screw_hole , h=100, center=true, $fn=fn);
                        translate([0,0,plate_thickness-2*fan_screw_head_hole_depth]){
                            cylinder(d=fan_screw_head , h=fan_screw_head_hole_depth, center=true, $fn=fn);
                        }
                    }
                }
                translate([fan_screw_distance/2, 0, fan_screw_distance/2]) {
                    rotate([90, 0, 0]){
                        cylinder(d=fan_screw_hole , h=100, center=true, $fn=fn);
                        translate([0,0,plate_thickness-2*fan_screw_head_hole_depth]){
                            cylinder(d=fan_screw_head , h=fan_screw_head_hole_depth, center=true, $fn=fn);
                        }
                    }
                }        
                translate([fan_screw_distance/2, 0, -fan_screw_distance/2]) {
                    rotate([90, 0, 0]){
                        cylinder(d=fan_screw_hole , h=100, center=true, $fn=fn);
                        translate([0,0,plate_thickness-2*fan_screw_head_hole_depth]){
                            cylinder(d=fan_screw_head , h=fan_screw_head_hole_depth, center=true, $fn=fn);
                        }
                    }
                }                        
                translate([-fan_screw_distance/2, 0, -fan_screw_distance/2]) {
                    rotate([90, 0, 0]){
                        cylinder(d=fan_screw_hole , h=100, center=true, $fn=fn);
                        translate([0,0,plate_thickness-2*fan_screw_head_hole_depth]){
                            cylinder(d=fan_screw_head , h=fan_screw_head_hole_depth, center=true, $fn=fn);
                        }
                    }
                }                                
            }            
        }
        // fan collar
        difference(){        
            cube([collar_outer_width, collar_height, collar_outer_width], center=true);
            cube([collar_inner_fan_width, collar_height, collar_inner_fan_width], center=true);        
        }
    }
}