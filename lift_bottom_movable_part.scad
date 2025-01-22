module prism(l, w, h){
      polyhedron(//pt 0        1        2        3        4        5
              points=[[0,0,0], [l,0,0], [l,w,0], [0,w,0], [0,w,h], [l,w,h]],
              faces=[[0,1,2,3],[5,4,3,2],[0,4,5,1],[0,3,4],[5,2,1]]
              );
}
      
  
difference(){
    union(){
        // movable wedge
        prism(25, 25, 25);
        translate([0, 25, 0]) {
            cube([25, 5, 25]);
        }
        // wing notches to slide in rails
        translate([-5, 0, 0]){
            cube([5, 30, 5]);
        }
        translate([25, 0, 0]){
            cube([5, 30, 5]);
        }
    }
    // cutout for oposite side
    translate([(25-10)/2, 0, 5]){
        cube([10, 25, 25]);
    }
    translate([(25-10)/2, -20, -0.1]){
        cube([10, 25, 25.1]);
    }
    // m4 screw hole
    translate([25/2, 50, 25/2]) {
        rotate([90, 0, 0]) {
            cylinder(d=4, h=50, $fn=100);
        }
    }
}