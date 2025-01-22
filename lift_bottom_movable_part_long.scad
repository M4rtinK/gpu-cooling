
ridge_width = 9.8;
ridge_cutout_height = 5.1;
wedge_width = 25;
rail_guide_width = 4.5;
rail_guide_height = 4.5;

// m4 nut
nut_width = 7.2;
nut_height = 3.6;

module prism(l, w, h){
      polyhedron(//pt 0        1        2        3        4        5
              points=[[0,0,0], [l,0,0], [l,w,0], [0,w,0], [0,w,h], [l,w,h]],
              faces=[[0,1,2,3],[5,4,3,2],[0,4,5,1],[0,3,4],[5,2,1]]
              );
}
      
// wing notches to slide in rails
translate([-rail_guide_width, 0, 0]){
    cube([rail_guide_width, 30, rail_guide_height]);
}
translate([25, 0, 0]){
    cube([rail_guide_width, 30, rail_guide_height]);
}       


difference(){
    union(){
        // wedge
        prism(25, 25, 25);
        translate([0, 25, 0]) {
            cube([25, 5, 25]);
        }  

        // ridge
        translate([(wedge_width-ridge_width)/2, -25, 0]) {            
            difference(){
                cube([ridge_width, 50, 25]);
                // bottom cutout
                translate([-0.1, -0.1, -1]){
                    cube([ridge_width+0.2, 20+0.1, ridge_cutout_height+1]);
                }                
                // m4 nut hole
                translate([-2, 3, 25/2-nut_width/2]) {
                    rotate([0, 0, 0]){
                        cube([25, nut_height, nut_width]);
                    }
                }
            }
        }
    }
    // m4 screw hole
    translate([25/2, 60, 25/2]) {
        rotate([90, 0, 0]) {
            cylinder(d=4, h=150, $fn=100);
        }
    }            
}



