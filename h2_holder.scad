include <BOSL2/std.scad>
include <BOSL2/screws.scad>

fn = 100;

mk=9;

revision_test=3;

// heatpipe
heatpipe_depth = 8.5;
heatpipe_offset = 6.5;
heatpipe_thickness = 7+1;
heatpipe_width = 14.5+1; // actually 2 heatpipes next to each other

// radiator
radiator_height = 52 + 20;
// 16 is the additional distance to the top of the coldplate,
// so use this to make the grooves go to the top of the block
radiator_width = 76;
// defined separately as not to move the hetpipe holes
radiator_width_margin = 0.5;
total_radiator_width = radiator_width+radiator_width_margin;
radiator_thickness = 22.5;
radiator_notch_width = 11 - 0.2;
radiator_notch_depth = 1.5 - 0.2;

// fan block
fan_block_groove = 4;
fan_width = 80.5;
thick_fan = 25.5;
slim_fan = 15.5;

// main block
main_block_width = 95;
main_block_height = 84;

module radiator_block() {
    difference(){
        // radiator block - add 0.01 mm to avoid flickering
        cube([total_radiator_width, radiator_thickness+0.01, radiator_height], center=true);
        // side notches        
        right((radiator_width+radiator_width_margin)/2-radiator_notch_depth/2+0.01) 
            cube([radiator_notch_depth, radiator_notch_width, radiator_height+0.01], center=true);        
        right(-(radiator_width+radiator_width_margin)/2+radiator_notch_depth/2-0.01)
            cube([radiator_notch_depth, radiator_notch_width, radiator_height+0.01], center=true);
    }
}

module heatpipe_end() {
    cube([heatpipe_thickness, heatpipe_width-heatpipe_thickness, heatpipe_depth+0.01], center=true);    
    // round the hole edges to make it look nicer    
    back(heatpipe_width-heatpipe_thickness*1.5) cylinder(d=heatpipe_thickness, h=heatpipe_depth, $fn=fn, center=true);    
    fwd(heatpipe_width-heatpipe_thickness*1.5) cylinder(d=heatpipe_thickness, h=heatpipe_depth, $fn=fn, center=true);    
}

module h2_cooler() { 
    union(){   
        radiator_block();
        // add heatpipes
        translate([radiator_width/2-heatpipe_thickness/2-heatpipe_offset, 0, -radiator_height/2-heatpipe_depth/2]){        
            up(0.01) heatpipe_end();
        }
        translate([-radiator_width/2+heatpipe_thickness/2+heatpipe_offset, 0, -radiator_height/2-heatpipe_depth/2]){        
            up(0.01) heatpipe_end();
        }
    }
}

module cooling_module() {
    // a cooling module holding 2 H2 heatpipe coolers
    diff()
    cuboid([main_block_width, 45, main_block_height], anchor=BOTTOM + BACK) {
        up(8) fwd(radiator_thickness/2) tag("remove") h2_cooler();
        up(8) back(radiator_thickness/2) tag("remove") h2_cooler();
    }    
}

module fan_module(fan_thickness=thick_fan, groove=fan_block_groove) {
    // a module holding one 80 mm fan, with support for variable fan thickness
    diff(){
        cuboid([main_block_width, fan_thickness+groove*2, main_block_height], anchor=BOTTOM + BACK){        
            // fan analog
            up(10) tag("remove") cuboid([fan_width, fan_thickness+0.01, 100], rounding=3, edges = "Y", $fn=fn, center=true); 
            // air hole
            up(2) tag("remove") cube([fan_width-4, 80, fan_width-15], center=true);
        }        
    }
}

module m4_nut_trap(rotate=0) {
    zrot(rotate) screw_hole("M4", length=20, $fn=fn, anchor=BOTTOM)
        up(5) position(BOT) nut_trap_side(10, "M4", poke_len=10);
}

module leveling_ramp() {
    diff()
    cuboid([main_block_width, 15, 10], anchor=BOTTOM + BACK) {
        down(7) left((main_block_width/2)-12) tag("remove") m4_nut_trap(90);
        down(7) right((main_block_width/2)-12) tag("remove") m4_nut_trap(90);
    }
}

//cooling_module();

back(15) leveling_ramp();
cooling_module();
fwd(2*radiator_thickness) cooling_module();
fwd(4*radiator_thickness) fan_module(thick_fan, 0);
fwd(thick_fan+4*radiator_thickness+15) zrot(180) leveling_ramp();