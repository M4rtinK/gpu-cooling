
ridge_width = 9.8;
ridge_cutout_height = 5.1;
wedge_width = 25;
rail_width = 5.05;
rail_height = 5.05;

// m4 nut
nut_width = 7.2;
nut_height = 3.6;

module prism(l, w, h){
      polyhedron(//pt 0        1        2        3        4        5
              points=[[0,0,0], [l,0,0], [l,w,0], [0,w,0], [0,w,h], [l,w,h]],
              faces=[[0,1,2,3],[5,4,3,2],[0,4,5,1],[0,3,4],[5,2,1]]
              );
}

union(){
    difference(){
        cube([45, 80, 10]);
        // main groove
        translate([10, -1, 2]) {
            cube([wedge_width, 82, 15]);
        }
        // rails
        translate([10-rail_width, -1, 2]) {
            cube([rail_width+0.2, 82, rail_height]);
        }
        translate([10+wedge_width-0.1, -1, 2]) {
            cube([rail_width+0.1, 82, rail_height]);
        }
    }
    translate([10, 50, 2]){
        // static wedge
        prism(25, 25, 25);
        translate([0, 25, 0]) {
            cube([25, 5, 25]);
        }
        // ridge
        translate([(wedge_width-ridge_width)/2, -25, 0]) {            
            difference(){
                cube([ridge_width, 50, 25]);
                // bottom cutout
                translate([-0.1, -0.1, 0]){
                    cube([ridge_width+0.2, 20+0.1, ridge_cutout_height]);
                }                
                // m4 screw hole
                translate([ridge_width/2, 60, 25/2]) {
                    rotate([90, 0, 0]) {
                        cylinder(d=4, h=70, $fn=100);
                    }
                }
                // nut hole
                translate([(ridge_width-nut_width)/2, 2.5, 2.5]) {
                    cube([nut_width, nut_height, 25]);
                }            
            }
        }        
    }
}






