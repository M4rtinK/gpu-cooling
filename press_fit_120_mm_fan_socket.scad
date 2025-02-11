include <BOSL2/std.scad>
include <BOSL2/screws.scad>

mk=5;

// set to false if you want to use a free rotating screw
screw_should_engage = true;

collar_height = 8;
collar_outer_width = 125;
// this seems to work good enough for press fit,
// at least with a  Arctic P12 MAX
collar_inner_fan_width = 120.2;
plate_thickness = 2;
fan_screw_distance = 105;
fan_screw = "M5";
fan_screw_counterbore = 0.5;
inner_fan_hole = 116;
fn = 100;

module fan_screw_hole(){
    rotate([90, 0, 0]) {       
        if (screw_should_engage == true) {
            cylinder(d=4.3, h=10, $fn=fn);
        } else {
            screw_hole(fan_screw, length=10, head="flat", counterbore=2, head_oversize=-2, $fn=fn);
        }
    }
}

difference(){
    union(){
        // 120 mm fan mounting plate
            difference(){
                // main body
                cuboid([collar_outer_width, plate_thickness, collar_outer_width], rounding=3, edges = "Y", $fn=fn, center=true);
                // inner fan hole
                rotate([90, 0, 0]){
                    cylinder(d=inner_fan_hole, h=100, center=true, $fn=fn);
                }
                // screw holes
                translate([-fan_screw_distance/2, 2+fan_screw_counterbore, fan_screw_distance/2]) {
                    fan_screw_hole();                    
                }
                translate([fan_screw_distance/2, 2+fan_screw_counterbore, fan_screw_distance/2]) {
                    fan_screw_hole();
                }        
                translate([fan_screw_distance/2, 2+fan_screw_counterbore, -fan_screw_distance/2]) {
                    fan_screw_hole();
                }                        
                translate([-fan_screw_distance/2, 2+fan_screw_counterbore, -fan_screw_distance/2]) {
                    fan_screw_hole();
                }                                
            }                    
        // fan collar
        // - making sure there i overlap or else apparently resulting STL might be sliuced as split :P
        translate([0, -(plate_thickness/2+collar_height/2)+0.01, 0]){
            difference(){        
                cuboid([collar_outer_width, collar_height+0.01, collar_outer_width], rounding=3, edges = "Y", $fn=fn, center=true);
                cube([collar_inner_fan_width, collar_height+5, collar_inner_fan_width], center=true);        
            }
        }
    }
}