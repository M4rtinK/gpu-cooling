// bottom pigtail holder block for Sensecap Solar

include <BOSL2/std.scad>
include <BOSL2/screws.scad>
include <BOSL2/walls.scad>
include <BOSL2/turtle3d.scad>

mk = 3;

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

screw_hole_y = 4;
screw_hole_z = 10;

diff()
cube([block_width, block_depth, block_height], anchor=BOTOM) {
    tag("remove") fwd(8) {
        right(0) up(2) {
        // pigtail nut trap
            back(11) zrot(90) yrot(90) nut_trap_side(10, "M5", shape="hex", nutwidth=11.1,thickness="thin", poke_len=15);
            // pigtail front
            down(4
            ) fwd(-11) cuboid([pigtail_front_width,15,15], rounding=2, anchor=FRONT);
            // pigtail back
            down(2.5) back(2) xrot(90) cylinder(h=20, d=pigtail_back_width, anchor=FRONT);
            // pigtail back gap
            down(4
            ) fwd() cuboid([pigtail_back_width,15,6], rounding=1, anchor=FRONT);
            
            
        }
        // top right notch
        fwd(10) up(block_height/2-notch_height/2+0.01) left(19.01) cube([notch_width + 1, 30, notch_height], anchor=FRONT);
        // right notch
        fwd(10) left(21.5) cube([notch_width + 1, 30, 30], anchor=FRONT);                
        // top ridge
        attach(UP) left(16)down(5) cube([44, 8, 5]);              
        // USB notch
        fwd(10) 
        down(block_height/2-USB_notch_height/2+0.01) 
        right(block_width/2-USB_notch_width/2-USB_notch_left_offset) 
            cube([USB_notch_width + 1, 30, USB_notch_height], anchor=FRONT);            
        // screw hole right
        up(screw_hole_y) back(screw_hole_z) left(9.5) zrot(90) yrot(90) screw_hole("m3,20")
          up(10) position(BOT) nut_trap_side(trap_width=20,poke_len=12);
        // screw hole left
        up(screw_hole_y) back(screw_hole_z) right(15) zrot(90) yrot(90) screw_hole("m3,20")
          up(10) position(BOT) nut_trap_side(trap_width=10,poke_len=12);
    };      
};