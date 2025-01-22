module prism(l, w, h){
      polyhedron(//pt 0        1        2        3        4        5
              points=[[0,0,0], [l,0,0], [l,w,0], [0,w,0], [0,w,h], [l,w,h]],
              faces=[[0,1,2,3],[5,4,3,2],[0,4,5,1],[0,3,4],[5,2,1]]
              );
}
      
rail_guide_width = 4.5;
rail_guide_height = 4.5;
central_notch_width = 10.5;

difference(){
    union(){
        // movable wedge
        prism(25, 25, 25);
        translate([0, 25, 0]) {
            cube([25, 5, 25]);
        }
        // wing notches to slide in rails
        translate([-rail_guide_width, 0, 0]){
            cube([rail_guide_width, 30, rail_guide_height]);
        }
        translate([25, 0, 0]){
            cube([rail_guide_width, 30, rail_guide_height]);
        }
    }
    // cutout for oposite side
    translate([(25-central_notch_width)/2, 0, 5]){
        cube([central_notch_width, 25, 25]);
    }
    translate([(25-central_notch_width)/2, -20, -0.1]){
        cube([central_notch_width, 25, 25.1]);
    }
    // m4 screw hole
    translate([25/2, 50, 25/2]) {
        rotate([90, 0, 0]) {
            cylinder(d=4, h=50, $fn=100);
        }
    }
}