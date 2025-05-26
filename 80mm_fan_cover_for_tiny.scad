include <BOSL2/std.scad>
include <BOSL2/screws.scad>
include <BOSL2/walls.scad>

mk = 1;

fn = 100;

cover_thickness = 3.7;

diff()
    hex_panel([134, 118.9, cover_thickness], strut=1.5, spacing=10, frame=8, anchor=BOTTOM){
        // hole for the fan bracket
        tag("remove") xrot(90) cuboid([80.5, 25, 80.5]);
        // fan bracket
        tag("keep") rect_tube(isize=[80.5, 80.5], wall=2,5, h=cover_thickness, rounding=3, anchor=CENTER, $fn=fn);
        // screw holes
        tag("remove") fwd(5.3) left(5.3) position(RIGHT + BACK) screw_hole("M3", length=20, $fn=fn, anchor=CENTER);
        tag("remove") fwd(-5.3) left(-5.3) position(LEFT + FWD) screw_hole("M3", length=20, $fn=fn, anchor=CENTER);
        
    };
    
