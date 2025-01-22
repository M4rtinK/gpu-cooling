// base platform with guide rails for the lift mechanism

wedge_width = 25;
rail_width = 5.05;
rail_height = 5.05;
rail_length = 80;
platform_width = 50;

union(){
    difference(){        
        cube([platform_width, rail_length, 10]);
        // main groove
        translate([12.5, -1, 2]) {
            cube([wedge_width, 82, 15]);
        }
        // rails
        translate([12.5-rail_width, -1, 2]) {
            cube([rail_width+0.2, 82, rail_height]);
        }
        translate([12.5+wedge_width-0.1, -1, 2]) {
            cube([rail_width+0.1, 82, rail_height]);
        }

    }
    // vertical guides
    translate([0, rail_length/2-5/2, rail_height+2]){
        cube([15, 5, 20]);
    }
    translate([platform_width-15, rail_length/2-5/2, rail_height+2]){
        cube([15, 5, 20]);
    }
}






