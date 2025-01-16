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

