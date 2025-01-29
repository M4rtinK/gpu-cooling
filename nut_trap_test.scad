include <BOSL2/std.scad>
include <BOSL2/screws.scad>

$fn=24;

mk=1;

difference(){
    cube([15, 25, 15], center=true);
    translate([0,0,6]){
        screw_hole("M4", length=20)
            position(BOT) nut_trap_side(10,poke_len=8);
    }
}