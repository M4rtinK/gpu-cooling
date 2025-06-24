include <BOSL2/std.scad>
include <BOSL2/screws.scad>
include <BOSL2/walls.scad>

mk = 1;

fn = 100;

holder_thickness = 5;
holder_width = 145;
holder_height = 84;
top_cutout_height= 42;
top_cutout_depth= 35;

diff()
    cuboid([holder_thickness, holder_width, holder_height], rounding=2, anchor=BOTTOM,
            edges=[TOP+FRONT,TOP+BACK,FRONT+BOTTOM, BACK+BOTTOM],
            $fn=fn) {
        // cut out part of the upper front and back for easy access to the KVM switch
        tag("remove") 
            align(FRONT, TOP, inside=true, shiftout=0.01) 
                cuboid([holder_thickness+2, top_cutout_depth, top_cutout_height], 
                       rounding=2, edges=[BACK+BOTTOM], $fn=fn);
        tag("remove")
            align(BACK, TOP, inside=true, shiftout=0.01) 
                cuboid([holder_thickness+2, top_cutout_depth, top_cutout_height], 
                       rounding=2, edges=[FRONT+BOTTOM], $fn=fn);
        // KVM switch attachment holes (M3)       
        tag("remove") align(TOP, inside=true) fwd(22.5) right(5) down(20) yrot(90) screw_hole("M3", length=10, $fn=fn);
        tag("remove") align(TOP, inside=true) back(22.5) right(5) down(20) yrot(90) screw_hole("M3", length=10, $fn=fn);        
        // cut out extra material        
        tag("remove")
            down(top_cutout_height/2)                 
                    cuboid([holder_thickness+2, holder_width-21, top_cutout_height/2], 
                            rounding=2, edges=[TOP+FRONT, TOP+BACK, BOTTOM+FRONT, BOTTOM+BACK], $fn=fn);
        
        
        // round the remaining corners
        tag("remove")                     
        align(FRONT, inside=true, shiftout=0.02)         
            down(1-0.01)
                yrot(90)
                    rounding_edge_mask(l=7, r=2, $fn=fn);      
        tag("remove") 
            align(BACK, shiftout=0.01) down(1-0.01)      
                    yrot(90) xrot(180)
                        rounding_edge_mask(l=7, r=2, $fn=fn);                                                    
        tag("remove")
            align(FRONT, TOP, CENTER, shiftout=0.01)
                back(top_cutout_depth) 
                    down(1-0.01) 
                        left(-3.5)
                            yrot(90)                 
                                rounding_edge_mask(l=7, r=2, $fn=fn);     
        tag("remove")
            align(BACK, TOP, shiftout=0.01)
                fwd(top_cutout_depth) down(1-0.01) left(3.5)
                yrot(90) xrot(180)                
                    rounding_edge_mask(l=7, r=2, $fn=fn);
        // print model metadata
        tag("remove")
            right(3.5) up(7) 
                xrot(90) yrot(90)
                    text3d(str("kvm holder mk", mk), h=3, size=6.5, anchor=CENTER);
    };

            
            
            

            


            
            
            
