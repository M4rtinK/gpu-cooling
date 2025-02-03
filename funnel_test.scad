include <BOSL2/std.scad>
include <BOSL2/screws.scad>

mk=11;

fn=60;

// card end
card_hole_outer_diameter = 72.8;
card_hole_inner_diameter = 71;
card_side_funnel_diameter = 73;
card_plate_width = 95;
card_plate_depth = 94;
card_plate_y_offset = 3.6;
interface_plate_thickness = 5;

// fan end
fan_diameter = 120;
fan_duct_diameter = 123;
fan_end_x = 15;
fan_end_y = -30;
fan_end_z = -35;
fan_end_rotate_x = 0;
fan_end_rotate_y = -20;
fan_end_rotate_z = 0;

// fan interface
collar_height = 8;
collar_outer_width = 133;
// this seems to work good enough for press fit,
// at least with a  Arctic P12 MAX
collar_inner_fan_width = 120.2;
fan_plate_thickness = 6;
fan_interface_offset = -3;

funnel_wall_thickness = 10;

module card_attachment_interface(){
    difference() {
        union() {
            difference() {
                translate([0, card_plate_y_offset, 0]) {
                    cube([card_plate_width, card_plate_depth, interface_plate_thickness],true);            
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

module funnel(a=0, f=0, e=2) {
    // main funnel
    fan_hole_diameter = f!=0 ? f : fan_duct_diameter-a;
    union(){
        chain_hull(){
        //union(){
            // fan side                                            
            translate([fan_end_x, fan_end_y, fan_end_z]) {
                rotate([fan_end_rotate_x, fan_end_rotate_y, fan_end_rotate_z]){
                    cylinder(d=fan_hole_diameter, h=6, $fn=fn);
                }
            }
            // in between shapes
            translate([fan_end_x-5, fan_end_y+5, fan_end_z+15]) {
                rotate([fan_end_rotate_x, fan_end_rotate_y+10, fan_end_rotate_z]){
                    //cylinder(d=fan_duct_diameter-a-20, h=2, $fn=fn);
                    cyl(l=10, d=fan_duct_diameter-a-20, rounding=5, $fn=fn);
                }
            }             
            // card side
            cylinder(d=card_side_funnel_diameter-a-2, h=2, $fn=fn);
        }                
    } 
}

module hollow_funnel() {    
    difference(){
        // make the funnel hollow
        funnel(-funnel_wall_thickness);
        funnel(0, 116, 10);
        // clean up the fan face
 
        
        translate([fan_end_x, fan_end_y, fan_end_z-0.1]) {
            rotate([fan_end_rotate_x, fan_end_rotate_y, fan_end_rotate_z]){
                cylinder(d=fan_duct_diameter, h=1, $fn=fn);
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
    block_height = 55;
    // main cube
    translate([0, card_plate_y_offset, (-block_height/2)+2]){
        difference(){
            // main support block
            cube([card_plate_width, card_plate_depth, block_height], center=true);
            // cut the back side
            translate([0, 79.85, -10]) {
                cube([card_plate_width+2, card_plate_depth, block_height], center=true);
            }
            translate([10, 79.9, -34]) {
                rotate([0, -20, 0]) {
                    cube([card_plate_width+20, card_plate_depth*4, block_height], center=true);
                }
            }
        }        
    }
    translate([-50.5, 0, -54.51]){
        difference(){
            union(){
                translate([8, -3.4, 25]) {
                    //cube([10, 79.8, 50], center=true);     
                }            
                translate([0, -10, -3.36]) {                    
                    simple_support_block();                    
                }
            }            
        }
    }    
}


module simple_support_block(){
    difference(){
        union(){
            cube([15, 15, 15], center=true);
            translate([5, -20, -3]) {
                cube([5, 126, 9], center=true);
            }
        }
        translate([-2, 0, 0]){
            rotate([0, 0, 0]){
                screw_hole("M4", length=30, $fn=fn);
            }            
        }
    }
}  


module support_block(){
    difference(){
        cube([25, 15, 15], center=true);
        translate([-5, 0, -3]){
            rotate([0, 0, 90]){
                screw_hole("M4", length=30, $fn=fn)
                    position(CENTER) nut_trap_side(10,poke_len=8);
            }
        }
    }
}    

// main composition


hollow_funnel();
translate([0, 0, interface_plate_thickness-0.5]) {
    card_attachment_interface();
}



translate([fan_end_x, fan_end_y, fan_end_z-0.1]) {
    rotate([fan_end_rotate_x+90, fan_end_rotate_y, fan_end_rotate_z]){
        fan_interface(fan_interface_offset);
    }
}

difference(){
    stabilization_block();
    funnel();
    translate([fan_end_x, fan_end_y, fan_end_z-0.1]) {
        rotate([fan_end_rotate_x+90, fan_end_rotate_y, fan_end_rotate_z]){
            fan_interface(fan_interface_offset, true);
        }
    }  
}












