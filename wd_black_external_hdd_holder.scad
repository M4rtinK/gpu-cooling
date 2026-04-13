include <BOSL2/std.scad>
include <BOSL2/screws.scad>
include <BOSL2/walls.scad>

mk = 1;

fn = 100;

holder_thickness = 14.5;
holder_width = 145;
holder_height = 35;
hdd_coutout_width = 42;
hdd_coutout_height = 25;

diff()
    cuboid([holder_thickness, holder_width, holder_height], rounding=2,
            edges=[TOP+FRONT,TOP+BACK,FRONT+BOTTOM, BACK+BOTTOM],
            $fn=fn) {      
        // cut out extra material        
        align(FRONT, TOP, CENTER, inside=true,shiftout=0.01) back((holder_width-hdd_coutout_width)/2)                 
                cuboid([holder_thickness+2, hdd_coutout_width, hdd_coutout_height], 
                        rounding=2, edges=[BOTTOM+FRONT, BOTTOM+BACK], 
                        $fn=fn);
        
        // print model metadata
        align(FRONT, inside=true,shiftout=0.01) right(8) back(25.75)            
            xrot(90) yrot(90)
                text3d(str("hdd holder mk", mk), h=3, size=5, anchor=CENTER);                            
    };

            
            
            

            


            
            
            
