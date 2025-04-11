include <BOSL2/std.scad>
	
tslot_profiles = [
	["mcmaster", "2020", [20, 20]],
	["tnutz", "2020", [20, 20]],
];

function tslot_profile_size(vendor,profile) = [
	for (prof_line = tslot_profiles)
	if ((prof_line[0] == vendor) && (prof_line[1] == profile))
	prof_line[2]
][0];
	
module mcmaster_2020_profile(center_hole=false){
	import("dxf/20-2020.dxf");
	if (!center_hole) {
		square(size=[5,5], center=true);
	}
}
module tnutz_2020_profile(center_hole=false){
	//CAD specs from:  https://www.tnutz.com/shop/wp-content/uploads/2016/02/EXM-2020-details.jpg
	difference() {
		rect(size=[20,20], rounding=1.5);
		union() {
			q=2.55-1.125;
			ymove(10) {
				rect([7.0, 0.5], anchor=UP); 
				rect([6.0, 1.5], anchor=UP);
				ymove(-1.5) rect([11.9, q], anchor=UP);
				ymove(-1.5-4.0) trapezoid(w1=11.9, spin=180, ang=45, h=(4.0-q), anchor=UP);
			}
			ymove(-10){
				rect([7.0, 0.5], anchor=DOWN); 
				rect([6.0, 1.5], anchor=DOWN);
				ymove(1.5) rect([11.9, q], anchor=DOWN);
				ymove(1.5+q) trapezoid(w1=11.9, spin=0, ang=45, h=(4.0-q), anchor=DOWN);
			};
			position(LEFT) {
				rect([0.5, 7.0], anchor=LEFT); 
				rect([1.5, 6.0], anchor=LEFT);
				xmove(1.5) rect([q, 11.9], anchor=LEFT);
				xmove(1.5+q) trapezoid(w1=11.9, spin=270, ang=45, h=(4.0-q), anchor=DOWN);
			};
			position(RIGHT) {
				rect([0.5, 7.0], anchor=RIGHT); 
				rect([1.5, 6.0], anchor=RIGHT);
				xmove(-1.5) rect([q, 11.9], anchor=RIGHT);
				xmove(-1.5-q) trapezoid(w1=11.9, spin=90, ang=45, h=(4.0-q), anchor=DOWN);
			};
		};
	};
}

module tslot(
	profile="2020", //[1010, 1515, 2020, 2040, 2060, 3030, 4040, 5050, 6060]
	vendor="mcmaster", //[mcmaster, tnutz, bosch, misumi, openbeam]
	length, //length of bar in mm
	tolerance=0, //additional tolerance for negative extrusions
	center_hole=false, //whether to include inner holes (not useful for negatives)
	anchor,
	spin,
	orient
){
	profile_size = tslot_profile_size(vendor, profile);
	echo(profile_size);
	size=[profile_size[0]+2*tolerance,profile_size[1]+2*tolerance];
	attachable(anchor, spin, orient, size=[size[0], size[1], length+2*tolerance]){
		minkowski() {
			linear_extrude(height=length, center=true, convexity=10) {
				if (vendor=="mcmaster") {
					if (profile=="2020") {
						mcmaster_2020_profile(center_hole=center_hole);
					} else {
						assert(true, "profile not yet implemented");
					};
				} else if (vendor=="tnutz") {
					if (profile=="2020") {
						tnutz_2020_profile(center_hole=center_hole);
					} else {
						assert(true, "profile not yet implemented");
					};
				} else {
						assert(true, "profile not yet implemented");
				};
			};
			sphere(r=tolerance);
		};
		children();
	}
}

