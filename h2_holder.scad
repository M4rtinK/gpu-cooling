include <BOSL2/std.scad>
include <BOSL2/screws.scad>

fn = 100;

mk=7;

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
        // radiator block
        cube([total_radiator_width, radiator_thickness, radiator_height], center=true);
        // side notches
        translate([(radiator_width+radiator_width_margin)/2-radiator_notch_depth/2+0.01, 0, 0]) {
            cube([radiator_notch_depth, radiator_notch_width, radiator_height+0.01], center=true);
        }
        translate([-(radiator_width+radiator_width_margin)/2+radiator_notch_depth/2-0.01, 0, 0]) {
            cube([radiator_notch_depth, radiator_notch_width, radiator_height+0.01], center=true);
        } 
    }
}

module heatpipe_end() {
    difference(){
        cube([heatpipe_thickness, heatpipe_width-heatpipe_thickness, heatpipe_depth], center=true);
        // round the hole edges to make it look nicer
        
    }
    translate([0, heatpipe_width-heatpipe_thickness*1.5, 0]){
        cylinder(d=heatpipe_thickness, h=heatpipe_depth, $fn=fn, center=true);
    }
    translate([0, -heatpipe_width+heatpipe_thickness*1.5, 0]){
        cylinder(d=heatpipe_thickness, h=heatpipe_depth, $fn=fn, center=true);
    }
}

module h2_cooler() {
    // move to sit on Z=0
    translate([0, 0, 0]){
        radiator_block();
        // add heatpipes
        translate([radiator_width/2-heatpipe_thickness/2-heatpipe_offset, 0, -radiator_height/2-heatpipe_depth/2]){        
            heatpipe_end();
        }
        translate([-radiator_width/2+heatpipe_thickness/2+heatpipe_offset, 0, -radiator_height/2-heatpipe_depth/2]){        
            heatpipe_end();
        }
    }
}

module cooling_module() {
    // a cooling module holding 2 H2 heatpipe coolers
    diff()
    cuboid([main_block_width, 45, main_block_height], anchor=BOTTOM) {
        up(8) fwd(radiator_thickness/2) tag("remove") h2_cooler();
        up(8) back(radiator_thickness/2) tag("remove") h2_cooler();
    }    
}

module fan_module(fan_thickness=thick_fan) {
    // a module holding one 80 mm fan, with support for variable fan thickness
    difference(){
        cube([main_block_width, fan_thickness+fan_block_groove*2, main_block_height], center=true);
        translate([0, 0, 10]){
            // fan analog
            cuboid([fan_width, fan_thickness, 100], rounding=3, edges = "Y", $fn=fn, center=true);         
        }
        translate([0, 0, 2]){            
            // air hole
            cube([fan_width-4, 80, fan_width-15], center=true);
        }        
        
        
    }
}

module m4_nut_trap(rotate=0) {
    zrot(rotate) screw_hole("M4", length=20, $fn=fn, anchor=BOTTOM)
        up(5) position(BOT) nut_trap_side(10, "M4", poke_len=10);
}

module leveling_ramp() {
    diff()
    cuboid([main_block_width, 15, 10], anchor=BOTTOM) {
        down(7) left((main_block_width/2)-12) tag("remove") m4_nut_trap(90);
        down(7) right((main_block_width/2)-12) tag("remove") m4_nut_trap(90);
    }
}

cooling_module();

//leveling_ramp();


// Left to righ is the opposite direction to the airflow. :)
last_cooling_block_offset = radiator_thickness;
central_fan_block_offset = (radiator_thickness*2)+(thick_fan+fan_block_groove*2)/2;
first_cooling_block_offset = (radiator_thickness*2)+(thick_fan+fan_block_groove*2)+radiator_thickness;
first_fan_offset = (radiator_thickness*2)+(thick_fan+fan_block_groove*2)+radiator_thickness*2+(slim_fan+fan_block_groove*2)/2;

/*
// last cooling block
translate([0, last_cooling_block_offset, 0]){
    cooling_module();
}
*/

// 25 mm main fan (arctic P8 Max)
/*
translate([0, central_fan_block_offset, 0]){
    fan_module(thick_fan);
}*/





/*
difference(){
    union(){
        translate([0, 5+(25+8)/2, -37]){
            cube([main_block_width, 10, 10], center=true);
        }        
        fan_module(thick_fan);
        translate([0, -5-(25+8)/2, -37]){
            cube([main_block_width, 10, 10], center=true);
        }
    }   
    rotate([0, 0, 270]){
        translate([21,0,-38]){
            screw_hole("M4", length=20, $fn=fn)
                up(10) position(BOT) nut_trap_side(10, "M4", poke_len=10);
        }
    }    
    rotate([0, 0, 90]){
        translate([21,0,-38]){
            screw_hole("M4", length=20, $fn=fn)
                up(10) position(BOT) nut_trap_side(10, "M4", poke_len=10);
        }
    }    
}*/
    
/*
// first cooling block
translate([0, first_cooling_block_offset, 0]){
    cooling_module();
}

// first 
translate([0, first_fan_offset, 0]){
    fan_module(slim_fan);
}*/