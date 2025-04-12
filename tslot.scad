include <BOSL2/std.scad>
	
tslot_profiles = [
	["8020", "2020", [20, 20]],
	["tnutz", "2020", [20, 20]],
];

function tslot_profile_size(vendor,profile) = [
	for (prof_line = tslot_profiles)
	if ((prof_line[0] == vendor) && (prof_line[1] == profile))
	prof_line[2]
][0];
	
module tnutz_2020_profile(center_hole=false){
	//CAD specs from:  https://www.tnutz.com/shop/wp-content/uploads/2016/02/EXM-2020-details.jpg
		difference(){
			zrot_copies(n=4) {
				move([7.975,7.975]) rect(size=[4.05, 4.05], rounding=[1.5,0,0,0]);
				mirror_copy(RIGHT) move([9.25,4.75,0]) rect(size=[1.5,2.5]);
				mirror_copy(RIGHT) move([9,4.5,0]) rect(size=[1,3]);
				zrot(45) ymove(8) rect([1.5, 8]);
				rect(size=[9,9]);
			};
			zrot_copies(n=4) xmove(4.5+(0.83-0.61)) circle(r=0.83);
			if (center_hole==true){
				circle(d=5.48);
				zrot_copies(n=4) zrot(45) rect([6.93,1.59]);
			};
		}
};

module net8020_2020_profile(center_hole=false){
		//specs from: https://8020.net/media/catalog/product/cache/9208ae76a38c408ac391cef6ce87b454/8/0/8020_aluminum_t-slot_profile_20-2020_dimensions.jpg
		difference(){
			zrot_copies(n=4, sa=0) {
				move([8.0,8.0]) rect(size=[4, 4], rounding=[1.5,0,0,0]);
				mirror_copy(RIGHT) move([9.25,4.5,0]) rect(size=[1.5,3.74], rounding=[0, 0, 0.5,0.5]);
				mirror_copy(RIGHT) move([8.5,6,0]) zrot(180) mask2d_roundover(r=0.515);
				mirror_copy(RIGHT) move([6,7.05,0]) zrot(90) mask2d_roundover(r=0.6, mask_angle=135);
				mirror_copy(RIGHT) move([3.65, 2.6, 0]) zrot(-90) mask2d_roundover(r=0.6, mask_angle=135);
				zrot(45) ymove(8) rect([1.5, 8]);
				rect(size=[7.32,7.32]);
			};
			if (center_hole==true){
				circle(r=2.095);
				zrot_copies(n=4) move([1.64,1.64,0]) zrot(45) scale([0.9,1,1]) circle(r=0.91);
			};
		}
};


module tslot(
	profile="2020", //[1010, 1515, 2020, 2040, 2060, 3030, 4040, 5050, 6060]
	vendor="8020", //[8020, tnutz, bosch, misumi, openbeam]
	length, //length of bar in mm
	tolerance=0, //additional tolerance for negative extrusions
	center_hole=false, //whether to include inner holes (not useful for negatives)
	anchor,
	spin,
	orient
){
	profile_size = tslot_profile_size(vendor, profile);
	size=[profile_size[0]+2*tolerance,profile_size[1]+2*tolerance];
	attachable(anchor, spin, orient, size=[size[0], size[1], length+2*tolerance]){
		minkowski() {
			linear_extrude(height=length, center=true, convexity=10) {
				if (vendor=="8020") {
					if (profile=="2020") {
						net8020_2020_profile(center_hole=center_hole);
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
};

