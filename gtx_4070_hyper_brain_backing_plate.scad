// backing blate for the RTX 4070 hyper brain
//
// Protects the back of the card from being damaged by zip ties when attaching
// the fan funnel.

card_width = 98;
pcb_ridge_width = 16+3+8;
pcb_ridge_height = 2.2;
low_area_width = 97-3;
backing_plate_width = pcb_ridge_width + low_area_width;
backing_plate_thickness = 9;

difference(){
    // backing plate
    cube([backing_plate_width, card_width, backing_plate_thickness]);
    // pcb ridge cutout
    translate([backing_plate_width-pcb_ridge_width, -10, -1]){
        cube([pcb_ridge_width+1, 150, pcb_ridge_height+1]);
    }
    // 12V connection cutout
    translate([backing_plate_width-pcb_ridge_width+7, card_width-36-18, pcb_ridge_height-1]){
        cube([9+1+20, 36, 2+1]);
    }
    // PCB components cutout
    translate([backing_plate_width-pcb_ridge_width+20, -5, pcb_ridge_height-1]){
        cube([9+1+20, 150, 2+1]);
    }
    // use less material cutout
    translate([50, 50, -20]){
        cylinder(d=70, h=100, $fn=600);
    }   
    // ziptie guides - right
    translate([16, -5, backing_plate_thickness-2]){
        cube([15, 120, 3]);
    }
    // ziptie guides - left
    translate([(backing_plate_width-15)-3, -5, backing_plate_thickness-2]){
        cube([15, 120, 3]);
    }
}
