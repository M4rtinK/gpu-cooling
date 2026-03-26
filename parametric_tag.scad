// parametric box tag

include <BOSL2/std.scad>
include <BOSL2/screws.scad>
include <BOSL2/walls.scad>
include <BOSL2/turtle3d.scad>

mk = 2;
fn = 100;

// main tag
width = 90;
height = 60;
thickness = 1;

// attachment bit on top
bit_height = 25; 
bit_width = 50;

r = 5;
path = turtle3d(["move",20,"arcleft",r,"move", 20,"arcleft",r,"move",20], transforms=true);

difference(){
cuboid([width, height, thickness], rounding=5, edges="Z", $fn=fn)
    attach(BACK,RIGHT) color("lightblue") cuboid(
        [bit_height, bit_width, thickness], rounding=2, edges=[LEFT+FRONT, BACK+LEFT], $fn=fn
    );
up (1.5) left(15) fwd(-47) zrot(270) sweep(square(2.5), path, caps=true);
}
            

//%stroke(path,closed=true, width=2);
//path = turtle3d(["repeat", 3, ["move",10,"arczrot",4]],transforms=true);
            