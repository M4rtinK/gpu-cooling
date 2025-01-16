//$fa = 1;
//$fs = 0.5;


thickness=23;
inner_diameter=93;
hole_diameter=73;
difference(){
    union(){
        cylinder(thickness, d=inner_diameter, center=true);
            translate([0,0,-thickness/2.0]) {
                cube([inner_diameter/2.0, inner_diameter/2.0, thickness]);
        };
    };
    difference(){
        union(){
            // middle cut
            translate([0,0,-12]) {
                //sphere(d=hole_diameter);
                cylinder(100, d=hole_diameter);
            }
            translate([0,-10,-12]) {        
                cube([80, 80, 100]);
            }
            translate([0,-10,-10]) {        
                cube([80, 80, 100]);
            }
            // sides cut
            union(){
                rotate(40){
                    translate([0,6,-12]) {
                        cube([30,30,60]);
                    }
                };
                rotate(15){
                    translate([0,-36,-12]) {
                        cube([50,30,60]);
                    }
                }
            }                                               
        }
        
        // ramp
        rotate([0,20,25]){
            translate([-45,-50,-42]) {
                cube([80,100,40]);
            }
}        
        
    }    
}

/*
union(){
    cylinder(h=23, d1=40, d2=20, center=true);
    translate([0, 0, 11]) {
        sphere(d=20);
    }
}*/
