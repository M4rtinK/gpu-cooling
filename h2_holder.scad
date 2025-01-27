fn = 100;

revision_test=3;

heatpipe_depth = 9;
heatpipe_offset = 6.5;
heatpipe_thickness = 7+1;
heatpipe_width = 14.5+1; // actuall 2 heatpipes next to each other

radiator_height = 52;
radiator_width = 76;
// defined separately as not to move the hetpipe holes
radiator_width_margin = 0.5;

radiator_thickness = 22.5;
radiator_notch_width = 11 - 0.5;
radiator_notch_depth = 1.5 - 0.25;


/*
difference() {
    translate([0, 0, 20]) {
        cube([85, 55, 80], center=true);
    }
    // cooler 1
    translate([0, 13, 62]) {
        cube([77, 23, 150], center=true);
    }
    // heatpipe holes 1
    translate([28, 13, 3]) {
        cube([8, 15, 40], center=true);
    }
    translate([-28, 13, 3]) {
        cube([8, 15, 40], center=true);
    }
    
    // cooler 2
    translate([0, -13, 62]) {
        cube([77, 23, 150], center=true);
    }
    // heatpipe holes 2
    translate([28, -13, 3]) {
        cube([8, 15, 40], center=true);
    }
    translate([-28, -13, 3]) {
        cube([8, 15, 40], center=true);
    }    
        
    // flow channel
    translate([0, -13, 58]) {
        cube([70, 100, 140], center=true);
    }
}
*/

module radiator_block() {
    difference(){
        // radiator block
        cube([radiator_width+radiator_width_margin, radiator_thickness, radiator_height], center=true);
        // side notches
        translate([(radiator_width++radiator_width_margin)/2-radiator_notch_depth/2+0.01, 0, 0]) {
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



difference(){
    // main block

    cube([85, 45, 25], center=true);

    translate([0, -radiator_thickness/2, 26]) {
        h2_cooler();
    }
    translate([0, +radiator_thickness/2, 26]) {
        h2_cooler();
    }
}