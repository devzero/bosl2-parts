include <BOSL2/std.scad>
$fn=100;

GF_TOLERANCE=0.5;
GF_SIZE=42.0;
GF_HUNIT=7.0;

module gridfinity_bin(
    x, //width in units of the bin, non-integers are an extra piece
    y, //depth in units of the bin
    h, //height in units of the bin
    extra_piece_direction=CENTER, //if there are fractional pieces which direction is it put, CENTER==None
    magnets="none", //magnets configuration: "none", "normal", "corners"
    lip="normal", //how the lip on top works: "none", "normal" 
    middle="normal", //how the center is, "normal", "solid", "label", "label_scoop"
    wall_thickness=0.95, //the thickness of walls
    center, //attachable param
    anchor,
    spin=0,
    orient=UP
) {
    bin_size = [ x*GF_SIZE-GF_TOLERANCE , y*GF_SIZE-GF_TOLERANCE ];
    attachable(anchor=anchor, spin=spin, orient=orient, size=[bin_size[0], bin_size[1], GF_HUNIT]){
        gridfinity_bin_bottom_connects(x,y,anchor=BOTTOM)
        position(TOP)
        gridfinity_bin_bottom_plate(x,y, orient=UP, anchor=BOTTOM)
        position(TOP)
        gridfinity_bin_middle(x,y,h, lip=lip, middle=middle, orient=UP, anchor=BOTTOM)
        position(TOP)
        gridfinity_bin_lip(x,y,h, orient=UP, anchor=BOTTOM);
        children();
    }
};
module gridfinity_bin_bottom_plate(
    x,
    y,
    h=1,
    center,
    anchor,
    spin=0,
    orient=UP
){
    bottom_plate_size = [ x*GF_SIZE-GF_TOLERANCE , y*GF_SIZE-GF_TOLERANCE ];
    bottom_plate_h = h*GF_HUNIT - ( 0.8 + 1.8 + 2.15 );
    attachable(anchor=anchor, spin=spin, orient=orient, size=[bottom_plate_size[0], bottom_plate_size[1], bottom_plate_h]){
        zmove(-bottom_plate_h/2)
        prismoid(size1=bottom_plate_size, size2=bottom_plate_size,  h=bottom_plate_h, rounding=4, anchor=BOTTOM);
        children();
    };
    
}

module gridfinity_bin_bottom_connects(
    x,
    y,
    magnets_style="none",
    center,
    anchor,
    spin=0,
    orient=UP
){
    bin_size = [ x*GF_SIZE-GF_TOLERANCE , y*GF_SIZE-GF_TOLERANCE ];
    bottom_connects = 0.8 + 1.8 + 2.15;
    attachable(anchor=anchor, spin=spin, orient=orient, size=[bin_size[0], bin_size[1], bottom_connects]){
        zmove(-bottom_connects/2)
        grid_copies(spacing=GF_SIZE, n=[x,y])
        gridfinity_bin_bottom_connect(anchor=BOTTOM);
        children();
    }
}

module gridfinity_bin_bottom_connect(
    magnets_layout=[false, false, false, false],
    magnets_r=6.0,
    magnets_h=2.0,
    screw_layout=[false, false, false, false],
    screw_r=3.0,
    screw_h=3.0,
    center,
    anchor,
    spin=0,
    orient=UP
  ){
    size1s = [ 35.6, 37.2, 37.2 ];
    size2s = [ 37.2, 37.2, 41.5 ];
    hs = [ 0.8, 1.8, 2.15 ];
    r1s = [ 1.15, 1.85, 1.85 ];
    r2s = [ 1.85, undef, 4.0 ];
    bottom_connect_h = hs[0] + hs[1] + hs[2]; 
    attachable(anchor=anchor, spin=spin, orient=orient, size=[size2s[2], size2s[2], bottom_connect_h]){
        zmove(-(bottom_connect_h/2))
        prismoid(size1=[size1s[0], size1s[0]], size2=[size2s[0], size2s[0]], h=hs[0], rounding1=r1s[0], rounding2=r2s[0])
        position(TOP)
        prismoid(size1=[size1s[1], size1s[1]], size2=[size2s[1], size2s[1]], h=hs[1], rounding=r1s[1])
        position(TOP)
        prismoid(size1=[size1s[2], size1s[2]], size2=[size2s[2], size2s[2]], h=hs[2], rounding1=r1s[2], rounding2=r2s[2]);
        children();
    };
}

module gridfinity_bin_middle(
    x,
    y,
    h,
    lip="normal", //TODO
    middle="normal",
    wall_thickness=0.95,
    center,
    anchor,
    spin=0,
    orient=UP
) {
    bin_size = [ x*GF_SIZE-GF_TOLERANCE , y*GF_SIZE-GF_TOLERANCE ];
    lip_thick = 5.2/2;
    wtv = [2*wall_thickness, 2*wall_thickness];
    wtvp = [2*lip_thick, 2*lip_thick];
    deltav = [0.001, 0.001];
    middle_h = (h-1)*GF_HUNIT;
    attachable(anchor=anchor, spin=spin, orient=orient, size=[bin_size[0], bin_size[1], middle_h]){
        zmove(-middle_h/2)
        //main walls
        if (middle=="normal") {
            rect_tube(size=bin_size, wall=wall_thickness, height = middle_h, rounding=4, anchor=BOTTOM)
            if (lip=="normal") {
                position(TOP)
                rect_tube(size1=bin_size-wtv, size2=bin_size-wtv, isize1=bin_size-wtvp, isize2=bin_size-wtv-deltav, h=lip_thick-wall_thickness, rounding=4, irounding2=4, irounding1=1.85, anchor=BOTTOM, orient=DOWN);
            };
        } else if (middle=="solid"){
            prismoid(size1=bin_size, size2=bin_size, height=middle_h, rounding=4, anchor=BOTTOM);
        }
        children();
    }
};

module gridfinity_bin_lip(
    x,
    y,
    h,
    lip="normal",
    center,
    anchor,
    spin=0,
    orient=UP
  ){
    bin_size = [ x*GF_SIZE-GF_TOLERANCE , y*GF_SIZE-GF_TOLERANCE ];
    isize1s = [ -5.2, -3.8, -3.8 ];
    isize2s = [ -3.8, undef, -0.01 ];
    hs = [ 0.7, 1.8, 1.9];
    lip_h = 4.4;
    r1s = [ 1.15, 1.85, 1.85 ];
    r2s = [ 1.85, undef, 4.0 ];
    bottom_connect_h = hs[0] + hs[1] + hs[2]; 
    attachable(anchor=anchor, spin=spin, orient=orient, size=[bin_size[0], bin_size[1], lip_h]){
        zmove(-lip_h/2)
        rect_tube(size1=bin_size, size2=bin_size, isize1=bin_size+[isize1s[0], isize1s[0]], isize2=bin_size+[isize2s[0],isize2s[0]], h=hs[0], rounding=4, irounding1=r1s[0], irounding2=r2s[0], anchor=BOTTOM)
        position(TOP)
        rect_tube(size=bin_size, isize=bin_size+[isize1s[1],isize1s[1]], h=hs[1], rounding=4, irounding=r1s[1], anchor=BOTTOM)
        position(TOP)
        rect_tube(size1=bin_size, size2=bin_size, isize1=bin_size+[isize1s[2], isize1s[2]], isize2=bin_size+[isize2s[2],isize2s[2]], h=hs[2], rounding=4, irounding1=r1s[2], irounding2=r2s[2], anchor=BOTTOM);
        children();
    };
  }

gridfinity_bin(2,2,15, middle="normal");
