include <BOSL2/std.scad>
include <BOSL2/screws.scad>

$fn=24;

mk=1;


difference(){
    cube([15, 25, 15], center=true);
    translate([0,0,6]){
        screw_hole("M4", length=20)
            up(2) position(BOT) nut_trap_side(10, "M4", poke_len=0);
    }
}



            
            
            
            
/*            
module support_block(){
    difference(){
        cube([25, 15, 15], center=true);
        translate([3, 0, -3]){
            rotate([0, 0, 90]){
                screw_hole("M4", length=30)
                    position(CENTER) nut_trap_side(10,poke_len=8);
            }
        }
    }
}*/    


//support_block();


//screw_hole("M5", length=10, head="flat", counterbore=4, head_oversize=1);

//screw("M5", length=8);



