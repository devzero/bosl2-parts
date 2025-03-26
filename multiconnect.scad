include <BOSL2/std.scad>

module coin(
    center,
    anchor,
    spin=0,
    orient=UP
  ){
    anchor = get_anchor(anchor, center);
    attachable(anchor, spin, orient, r=10.15, h=5) {
        zmove(-2.5)
        cylinder(r=10.15, h=1.2121)
            position(TOP)
            cylinder(r1=10.15, r2=7.65, h=(3.712-1.2121), orient=TOP)
            position(TOP)
            cylinder(r=7.65, h=(5-3.712), orient=TOP);
        children();
     }
}

module slot(
    units=1,
    unitDistance=28,
    holes=true,
    hole_gap=1,
    center,
    anchor,
    spin=0,
    orient=UP
  ){
    rs=[10.15, 7.65];
    hs=[1.2121, 2.5, 1.288];
    ds=2*rs;
    hfull=hs[0]+hs[1]+hs[2];
    uh=units*unitDistance;
    anchor = get_anchor(anchor, center=CENTER);
    attachable(
        anchor, 
        spin, 
        orient, 
        size=[ds[0], uh+rs[0], hfull],
        anchors=[named_anchor("hole", [0,0,0], BACK, 0)]
    ) {
        //center object
        move([0, (rs[0]-uh)/2, -hfull/2])
        //top coin
        coin(anchor=BOTTOM)
        //bottom layer of slot
         position(BOTTOM)
       cube([ds[0],uh, hs[0]], anchor=BOTTOM+FRONT)
         //middle layer of slot
        position(TOP+FRONT)
        prismoid(
            size1=[ds[0], uh],
            size2=[ds[1], uh],
            h=hs[1],
            anchor=FRONT+BOTTOM
        )
        //top layer of slow
        position(TOP+FRONT)
        cube([ds[1], uh, hs[2]],
            anchor=FRONT+BOTTOM
        ) 
        if (holes) {
            position(TOP+CENTER+BACK)
            ycopies(unitDistance*hole_gap, units/hole_gap, sp=[0,-uh+unitDistance/2,0])
            cylinder(r=rs[0], h=hfull, orient=DOWN);
        } ;
        children();
    }
}

