# bosl2-libs

A [BOSL2](https://github.com/BelfrySCAD/BOSL2)-based OpenSCAD Library for common parts not covered in the original BOSL2 library


All modules produce attachable BOSL2 objects and take standard attachable parameters (anchor, spin, orient).  Instead of having many global variables, module constructors are the only inputs, with reasonable defaults, and hopefully simpler designs.

Current Features:

# gridfinity
## References
- [Gridfinity Website](https://gridfinity.xyz/)
- [PerplexingLabs Gridfinity Generators](https://gridfinity.perplexinglabs.com/)
- [Gridfinity Rebuilt](https://github.com/kennetek/gridfinity-rebuilt-openscad)

## Modules
```
module gridfinity_bin(
    x, //width in units of the bin, non-integers are an extra fractional piece
    y, //depth in units of the bin
    h, //height in units of the bin
    extra_piece_direction=CENTER, //if there are fractional pieces which direction is it put, CENTER==None
    magnets="none", //magnets configuration: "none", "default", "corners"
    lip="default", //how the lip on top works: "none", "default" 
    middle="default", //how the center is, "default", "solid", "label", "label_scoop"
    wall_thickness=0.95, //the thickness of walls
    center, //attachable param
    anchor,
    spin=0,
    orient=UP
) {
```
# multiconnect
## References
Created By David D
- [Printables](https://www.printables.com/model/1074671-multiconnect-generic-connector-for-multiboard-v2)

## Modules
```
module coin( // the top of a multi-connect connector
    center,
    anchor,
    spin=0,
    orient=UP
  )

module slot(
    units=1,
    unitDistance=28,
    holes=true,
    hole_gap=1,
    center,
    anchor,
    spin=0,
    orient=UP
  )
```

# tslot
## References
Extruded T-slot Alumnimum Rails

Vendors:
- [8020.net](https://www.8020.net/)
- [Tnutz](https://www.tnutz.com/)
- [McMaster-Carr](https://www.mcmaster.com/products/t-slotted-framing/t-slotted-framing-and-fittings~/t-slotted-framing-rails-4/)
- [Bosch Rexroth](https://www.boschrexroth.com/en/us/products/industrial-solutions/assembly-technology/aluminum-profile-kit/)
- [Misumi](https://us.misumi-ec.com/vona2/mech/M1500000000/M1501000000/M1501010000/)

Note that the extrusion profiles do vary slightly on some versions between vendors (for example 2020 is different between Tnutz, 8020.net, and McMaster-Car) So far only a few profiles have been implemented

## Modules
```
module tslot(
	profile="2020", //[1010, 1515, 2020, 2040, 2060, 3030, 4040, 5050, 6060]
	vendor="8020", //[8020, tnutz, bosch, misumi, openbeam]
	length, //length of bar in mm
	tolerance=0, //additional tolerance for negative extrusions
	center_hole=false, //whether to include inner holes (not useful for negatives)
	anchor,
	spin,
	orient
);
````
