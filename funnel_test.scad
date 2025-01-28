include <BOSL2/std.scad>

mk=1;

fn=100;

// card end
card_hole_outer_diameter = 72.8;
card_hole_inner_diameter = 71;
card_side_funnel_diameter = 73;
interface_plate_thickness = 5;

// fan end
fan_diameter = 120;
fan_duct_diameter = 123;
fan_end_x = 15;
fan_end_y = -30;
fan_end_z = -30;
fan_end_rotate_x = 0;
fan_end_rotate_y = -20;
fan_end_rotate_z = 0;

// fan interface
collar_height = 25;
collar_outer_width = 127;
// this seems to work good enough for press fit,
// at least with a  Arctic P12 MAX
collar_inner_fan_width = 120.2;
fan_plate_thickness = 6;

module card_attachment_interface(){
    difference() {
        union() {
            difference() {
                translate([0, 3.6, 0]) {
                    cube([95, 94, interface_plate_thickness],true);            
                }
                // ziptie groves
                // - for 5 m wide zip ties
                translate([85/2-10/2+3, -50, -10]) {
                    cube([5.5, 150, 10]);
                }    
                translate([-85/2-3.5, -50, -10]) {            
                    cube([5.5, 150, 10]);
                }                       
            }
            translate([0, 0, interface_plate_thickness/2]) {
                // outer cylinder
                cylinder(h = 3, d=card_hole_outer_diameter, center = true, $fn=fn);
            }
        }
        // inner cylinder
        cylinder(h = 20, d=card_hole_inner_diameter, center = true, $fn=fn);
    }
}

module funnel(a=0) {
    // main funnel    
    difference(){
        chain_hull(){
        //union(){
            // fan side
            translate([fan_end_x, fan_end_y, fan_end_z]) {
                rotate([fan_end_rotate_x, fan_end_rotate_y, fan_end_rotate_z]){
                    cylinder(d=fan_duct_diameter-a, h=2, $fn=fn);
                }
            }
            // in between shapes
            translate([fan_end_x-5, fan_end_y+15, fan_end_z+15]) {
                rotate([fan_end_rotate_x, fan_end_rotate_y+10, fan_end_rotate_z]){
                    //cylinder(d=fan_duct_diameter-a-20, h=2, $fn=fn);
                    cyl(l=10, d=fan_duct_diameter-a-20, rounding=5, $fn=fn);
                }
            }             
            // card side
            cylinder(d=card_side_funnel_diameter-a, h=2, $fn=fn);
        }
    } 
}

module hollow_funnel() {    
    difference(){
        // make the funnel hollow
        funnel();
        funnel(2);
        // clean up the fan face            
        translate([fan_end_x, fan_end_y, fan_end_z-0.1]) {
            rotate([fan_end_rotate_x, fan_end_rotate_y, fan_end_rotate_z]){
                cylinder(d=fan_duct_diameter-2, h=1, $fn=fn);
            }
        }   
    }    
}

module fan_interface(offset=0, full=false){
    translate([0, offset, 0]) {
        difference(){
            union(){
                // 120 mm fan mounting plate
                translate([0, fan_plate_thickness, 0]) {
                    difference(){
                        cube([collar_outer_width, fan_plate_thickness, collar_outer_width], center=true);
                        // inner fan hole
                        if(!full){
                            rotate([90, 0, 0]){
                                cylinder(d=116, h=100, center=true, $fn=fn);
                            }
                        }                    
                    }            
                }
                // fan collar
                translate([0, (-collar_height/2)+(fan_plate_thickness/2), 0])
                difference(){        
                    cube([collar_outer_width, collar_height, collar_outer_width], center=true);
                    if(!full){
                        cube([collar_inner_fan_width, collar_height, collar_inner_fan_width], center=true);        
                    }
                }
            }
        }
    }
}

module stabilization_block() {
    cube([15, 15, 72], center=true);
    translate([-10, 0, -37]){
        cube([30, 15, 10], center=true);
    }
}



// main composition


hollow_funnel();
translate([0, 0, interface_plate_thickness-0.5]) {
    card_attachment_interface();
}

translate([fan_end_x, fan_end_y, fan_end_z-0.1]) {
    rotate([fan_end_rotate_x+90, fan_end_rotate_y, fan_end_rotate_z]){
        fan_interface(-6);
    }
}  

difference(){
    translate([-40, -20, -34]) {
        stabilization_block();
    }
    funnel();
    translate([fan_end_x, fan_end_y, fan_end_z-0.1]) {
    rotate([fan_end_rotate_x+90, fan_end_rotate_y, fan_end_rotate_z]){
        fan_interface(-6, true);
    }
}  
}












