include <BOSL2/std.scad>

mk = 2;

diff()
cuboid([95, 15, 4], rounding=1, edges = "Z", $fn=300, anchor=BOTTOM) {
    up(0) tag("remove") cuboid([80, 4, 4], rounding=1, edges = "Z", $fn=300, anchor=BOTTOM);
}