/*
   OpenSCAD enclosure for FluxEngine_Hat
   Brian K. White - b.kenyon.w@gmail.com
   https://github.com/bkw777/FluxEngine_Hat
*/

// -------------------------------------------------------------------------
// UNITS: mm

// Temporarily comment out $fn $fs $fa and save for importing into freecad.
// Otherwise freecad only imports the mesh facets, not the source geometry.

// arc smoothness
$fn = 18;

// Fitment Clearance
fc = 0.1;

// min allowed wall thickness
min_wall = 0.7;

// overlap/overextend - extend cut shapes this far beyond the outside surfaces they cut from,
// and embed union shapes this far beyond the surfaces into the shapes they join to
// to prevent zero-thickness planes and other noise in renders and mesh exports.
o = 0.2;  // enough to see clearly in preview

pcb_w = 83.82;
pcb_d = 24.13;
pcb_h = 1.6;
pcb_r = 1.905;

fpga_w = 68;
fpga_o = -3.5;

ich = 12;
pcb_e = 5;

post_w = 3;
post_d = post_w;

el = 4; // extra length

wt = 2; //  wall thickness

rl = 1.27; // retainer lip

include <handy.scad>;

// ===============================================================

%import("FluxEngine.stl");

union() {

translate([-el/4,0,pcb_e])
 difference() {
  rounded_cube(w=fc+pcb_w+fc+el,d=pcb_d+fc,h=ich,rh=pcb_r+fc,rv=pcb_r+fc,t=wt);
  union() {
   cw = 20;
   cd = pcb_d-rl*2;
   ucd = pcb_d-post_d*2;
   translate([-4,0,-pcb_e])
    rounded_cube(w=o+wt+fc+pcb_w+fc+wt+el+o,d=cd,h=wt+ich+wt,rh=pcb_r+fc,rv=pcb_r+fc,t=0);
   translate([cw/2+fpga_w/2+fpga_o,0,ich/2])
    rounded_cube(w=cw,d=ucd,h=10,rh=3,rv=1,t=0);
   translate([cw/2+fpga_w/2,0,-ich/2+fc])
    rounded_cube(w=20,d=cd,h=ich*2,rh=3,rv=3,t=0);
  }
 }

mirror_copy([0,1,0])
 translate([fpga_o,-pcb_d/2-o,0])
  mirror_copy([1,0,0])
   translate([fpga_w/2+fc,0,pcb_h+fc])
    cube([post_w,post_d,pcb_e+ich/2-pcb_h]);

translate([22,0,0])
 difference() {
 r = pcb_r+fc+1;
 hull() mirror_copy([0,1,0]) translate([0,pcb_d/2-r+fc+o,pcb_e+r]) rotate([0,90,0]) cylinder(h=wt,r=r,center=true);
 hull() mirror_copy([0,1,0]) translate([0,pcb_d/2-r+fc+o,pcb_e]) rotate([0,90,0]) cylinder(h=wt+o,r=r,center=true);
 }


}