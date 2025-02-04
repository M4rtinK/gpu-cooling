include <BOSL2/std.scad>
include <BOSL2/screws.scad>

mk=2;

collar_height = 9;
collar_outer_width = 125;
// this seems to work good enough for press fit,
// at least with a  Arctic P12 MAX
collar_inner_fan_width = 120.2;
plate_thickness = 6;
fan_screw_distance = 105;
fan_screw = "M5";
fan_screw_counterbore = 0.5;
inner_fan_hole = 116;
fn = 100;

module case_fan_screw(){
    rotate([90, 0, 0]) {
        screw_hole(fan_screw, length=10, head="flat", counterbore=2, head_oversize=1, $fn=fn);
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
                    case_fan_screw();                    
                }
                translate([fan_screw_distance/2, 2+fan_screw_counterbore, fan_screw_distance/2]) {
                    case_fan_screw();
                }        
                translate([fan_screw_distance/2, 2+fan_screw_counterbore, -fan_screw_distance/2]) {
                    case_fan_screw();
                }                        
                translate([-fan_screw_distance/2, 2+fan_screw_counterbore, -fan_screw_distance/2]) {
                    case_fan_screw();
                }                                
            }                    
        // fan collar
        translate([0, -(plate_thickness/2+collar_height/2), 0]){
            difference(){        
                cuboid([collar_outer_width, collar_height, collar_outer_width], rounding=3, edges = "Y", $fn=fn, center=true);
                cube([collar_inner_fan_width, collar_height+5, collar_inner_fan_width], center=true);        
            }
        }
    }
}