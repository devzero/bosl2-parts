include <BOSL2/std.scad>
$fn=100;

tolerance=0.5;

module gridfinity_bin(
    x,
    y,
    h,
    magnets=false,
    stacking_lip=true
) {};

module gridfinity_bin_lip(
    center,
    anchor,
    spin=0,
    orient=UP
  ){
    attachable(anchor=anchor, spin=spin, orient=orient, size=[41.5, 41.5, 4.4]){
        zmove(-2.2)
        rect_tube(size1=[41.5,41.5], size2=[41.5, 41.5], isize1=[36.3, 36.3], isize2=[37.7,37.7], h=0.7, rounding=4, irounding1=1.15, irounding2=1.85, anchor=BOTTOM)

        position(TOP)
        rect_tube(size=[41.5,41.5], isize=[37.7, 37.7], h=1.8, rounding=4, irounding=1.85, anchor=BOTTOM)
        position(TOP)
        rect_tube(size1=[41.5,41.5], size2=[41.5, 41.5], isize1=[37.7,37.7], isize2=[41.49, 41.49], h=1.9, rounding=4, irounding1=1.85, irounding2=4, anchor=BOTTOM)
        ;
        children();
    };
  }

module gridfinity_bin_bottom(
    magnets=false,
    center,
    anchor,
    spin=0,
    orient=UP
  ){
    attachable(anchor=anchor, spin=spin, orient=orient, size=[41.5, 41.5, 7.0]){
        zmove(-3.5)
        prismoid(size1=[35.6, 35.6], size2=[37.2, 37.2], h=0.8, rounding1=1.15, rounding2=1.85)
        position(TOP)
        prismoid(size1=[37.2, 37.2], size2=[37.2,37.2], h=1.8, rounding=1.85, anchor=BOTTOM)
        position(TOP)
        prismoid(size1=[37.2, 37.2], size2=[41.5, 41.5], h=2.15, rounding1=1.85, rounding2=4, anchor=BOTTOM)
        position(TOP)
        prismoid(size1=[41.5,41.5], size2=[41.5, 41.5], h=2.25, rounding=4, anchor=BOTTOM);
        children();
    };
}

gridfinity_bin_bottom(anchor=BOTTOM)
position(TOP)
rect_tube(size=41.5, wall=0.95, height = 7.0*1, rounding=4, anchor=BOTTOM)
position(TOP)
gridfinity_bin_lip(anchor=BOTTOM);

