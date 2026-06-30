include <BOSL2/std.scad>
include <BOSL2/screws.scad>
include <BOSL2/walls.scad>

fn = 100;

mk = 3;

// we are using M3x6 screws and the Gridfinity Modular Baseplates
// https://www.printables.com/model/360046-gridfinity-modular-baseplates

// height of the grid
// the grid actually has tappered edges and we actually do make the spacer
// to fit between the inner edges - it is slightly thinner than the baselate as a result
gridfinity_modular_grid_height = 10.650;
// M3 screw diameter
screw_hole_diameter = 3.45;
screw_hole_depth = 7;
screw_head_hole_diameter = 5.7;
// spacing of the two screw holes in the modular baseplate
screw_hole_spacing = 4.713;
// how far are 2 sets of the double holes located from each other,
// measured between left & right hole in the pair
screw_hole_set_spacing = 30.387;
// offset from the bottom of the part
screw_hole_bottom_offset = 1.275;

// Dynamic options go here

// how much material material to add on both sides from the hole pairs
added_width = 10;
// how thick should the spacer be
spacer_thickness = 10;
spacer_width = 2* added_width +  4 * screw_hole_diameter + 2 * screw_hole_spacing + screw_hole_set_spacing;
spacer_height = gridfinity_modular_grid_height;

diff()
cuboid([spacer_width, spacer_thickness, spacer_height], anchor=FRONT+LEFT+BOT) {
    hole_shift_up = screw_hole_diameter/2 + screw_hole_bottom_offset;
    // screw holes
    down(spacer_height/2 + screw_hole_diameter/2 - screw_hole_diameter - screw_hole_bottom_offset) {
        fwd(spacer_thickness/2) {
            first_hole_x = - spacer_width/2 + screw_hole_diameter/2 + added_width;
            second_hole_x = first_hole_x + screw_hole_spacing + screw_hole_diameter;
            third_hole_x = second_hole_x + screw_hole_diameter + screw_hole_set_spacing;
            fourth_hole_x = third_hole_x + screw_hole_spacing + screw_hole_diameter;
            tag("remove") recolor("blue") right(first_hole_x) cylinder(d=screw_hole_diameter, h=50, orient=BACK, $fn=fn);
            tag("remove") recolor("blue") right(second_hole_x) cylinder(d=screw_hole_diameter, h=50, orient=BACK, $fn=fn);
            tag("remove") recolor("blue") right(third_hole_x) cylinder(d=screw_hole_diameter, h=50, orient=BACK, $fn=fn);
            tag("remove") recolor("blue") right(fourth_hole_x) cylinder(d=screw_hole_diameter, h=50, orient=BACK, $fn=fn);
        
            // screw head holes
            screw_head_hole_depth = spacer_thickness - screw_hole_depth;
            first_screw_head_hole_x = - spacer_width/2 + screw_hole_diameter/2 + added_width;
            second_screw_head_hole_x = first_screw_head_hole_x + screw_hole_spacing + screw_hole_diameter;
            third_screw_head_hole_x = second_screw_head_hole_x + screw_hole_diameter + screw_hole_set_spacing;
            fourth_screw_head_hole_x = third_screw_head_hole_x + screw_hole_spacing + screw_hole_diameter;
            tag("remove") recolor("red") right(first_screw_head_hole_x) cylinder(d=screw_head_hole_diameter, h=screw_head_hole_depth, orient=BACK, $fn=fn);
            tag("remove") recolor("red") right(second_screw_head_hole_x) cylinder(d=screw_head_hole_diameter, h=screw_head_hole_depth, orient=BACK, $fn=fn);
            tag("remove") recolor("red") right(third_screw_head_hole_x) cylinder(d=screw_head_hole_diameter, h=screw_head_hole_depth, orient=BACK, $fn=fn);
            tag("remove") recolor("red") right(fourth_screw_head_hole_x) cylinder(d=screw_head_hole_diameter, h=screw_head_hole_depth, orient=BACK, $fn=fn);
        }
    }
}
