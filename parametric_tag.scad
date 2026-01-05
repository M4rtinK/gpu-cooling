// parametric box tag

include <BOSL2/std.scad>
include <BOSL2/screws.scad>
include <BOSL2/walls.scad>

mk = 1;
fn = 100;

// main tag
width = 90;
height = 60;
thickness = 1;

// attachment bit on top
bit_height = 15; 
bit_width = 25;

cuboid([width, height, thickness], rounding=5, edges="Z", $fn=fn)
    attach(BACK,RIGHT)
            color("lightblue")cuboid([bit_height, bit_width, thickness],
                  rounding=2, edges=[LEFT+FRONT, BACK+LEFT], $fn=fn
            );