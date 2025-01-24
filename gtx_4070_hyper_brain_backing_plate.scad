// backing blate for the RTX 4070 hyper brain
//
// Protects the back of the card from being damaged by zip ties when attaching
// the fan funnel.

card_width = 98;
pcb_ridge_width = 16;
pcb_ridge_height = 2.2;
low_area_width = 97;
backing_plate_width = pcb_ridge_width + low_area_width;
backing_plate_thickness = 8;

difference(){
    // backing plate
    cube([backing_plate_width, card_width, backing_plate_thickness]);
    // pcb ridge cutout
    translate([backing_plate_width-pcb_ridge_width, -10, -1]){
        cube([pcb_ridge_width+1, 150, pcb_ridge_height+1]);
    }
    // 12V connection cutout
    translate([backing_plate_width-pcb_ridge_width+7, card_width-36-18, pcb_ridge_height-1]){
        cube([9+1, 36, 2+1]);
    }
    // use less material cutout
    translate([60, 50, -20]){
        cylinder(d=60, h=100, $fn=600);
    }   
    // ziptie guides
    translate([18, -5, backing_plate_thickness-1]){
        cube([10, 120, 2]);
    }
    translate([(backing_plate_width-10)-2, -5, backing_plate_thickness-1]){
        cube([10, 120, 2]);
    }
}
