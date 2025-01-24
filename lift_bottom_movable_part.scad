module prism(l, w, h){
      polyhedron(//pt 0        1        2        3        4        5
              points=[[0,0,0], [l,0,0], [l,w,0], [0,w,0], [0,w,h], [l,w,h]],
              faces=[[0,1,2,3],[5,4,3,2],[0,4,5,1],[0,3,4],[5,2,1]]
              );
}
      
rail_guide_width = 4.5;
rail_guide_height = 4;
central_notch_width = 10.5;

// m4 screw
screw_width_free_rotation = 4.2;

// m4 nut
nut_width = 7.1;
nut_height = 3.5;

difference(){
    union(){
        // movable wedge
        prism(25, 25, 25);
        // backing cube
        translate([0, 25, 0]) {
            cube([25, 10, 25]);
        }
        // wing notches to slide in rails
        translate([-rail_guide_width, 0, 0]){
            cube([rail_guide_width, 35, rail_guide_height]);
        }
        translate([25, 0, 0]){
            cube([rail_guide_width, 35, rail_guide_height]);
        }
    }
    // cutout for oposite side
    translate([(25-central_notch_width)/2, 0, 5]){
        cube([central_notch_width, 25, 25]);
    }
    translate([(25-central_notch_width)/2, -20, -0.1]){
        cube([central_notch_width, 25, 25.1]);
    }
    // m4 screw hole - pull
    translate([25/2, 50, 25/2]) {
        rotate([90, 0, 0]) {
            cylinder(d=screw_width_free_rotation, h=50, $fn=100);
        }
    }
    // m4 screw hole - push
    translate([25/2, 50, 20]) {
        rotate([90, 0, 0]) {
            cylinder(d=screw_width_free_rotation, h=50, $fn=100);
        }
    }
    
    // m4 nut hole
    translate([25/2-nut_width/2, 28, -5]) {
        rotate([0, 0, 0]){
            cube([nut_width, nut_height, 50]);
        }
    }    

    
}


                