// bottom pigtail holder block for Sensecap Solar

include <BOSL2/std.scad>
include <BOSL2/screws.scad>
include <BOSL2/walls.scad>
include <BOSL2/turtle3d.scad>

mk = 1;

$fn = 100;

block_width = 50;
block_height = 17+5;
block_depth = 15;

notch_width = 11;
notch_height = 4.5+5;

USB_notch_width = 23;
USB_notch_height = 10;
USB_notch_left_offset = 7.4;

pigtail_front_width = 6.1+0.2;
pigtail_back_width = 4.1+0.1;

screw_hole_y = 2;
screw_hole_z = 4;

diff()
cube([block_width, block_depth, block_height], anchor=BOTOM) {
    tag("remove") fwd(8) {
        // top right notch
        fwd(10) up(block_height/2-notch_height/2+0.01) left(19.01) cube([notch_width + 1, 30, notch_height], anchor=FRONT);
        // right notch
        fwd(10) left(21.5) cube([notch_width + 1, 30, 30], anchor=FRONT);                
        // top ridge
        attach(UP) left(16)down(5) cube([44, 10, 5]);              
        // USB notch
        fwd(10) 
        down(block_height/2-USB_notch_height/2+0.01) 
        right(block_width/2-USB_notch_width/2-USB_notch_left_offset) 
            cube([USB_notch_width + 1, 30, USB_notch_height], anchor=FRONT);            
        // screw hole right
        up(screw_hole_y) back(screw_hole_z) left(9.5) zrot(90) yrot(270) screw_hole("m3,40")
          up(10) position(BOT) nut_trap_side(trap_width=20,poke_len=20);
        // screw hole left
        up(screw_hole_y) back(screw_hole_z) right(15) zrot(90) yrot(270) screw_hole("m3,40")
          up(10) position(BOT) nut_trap_side(trap_width=10,poke_len=20);
    };   
};
// USB cable attachment block   
diff() back(15) up(16) right(30) cube([16, 20, 12], anchor=FRONT) {
    tag("remove") left(5) fwd(17) down(5) {
        // some screw holes
        right(5) back(12) up(5) yrot(90) screw_hole("m3,40");
        right(5) back(22) up(5) yrot(90) screw_hole("m3,40");
        right(10) back(17) screw_hole("m3,40");
        left(0) back(17) screw_hole("m3,40");
    };
}
