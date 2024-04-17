/*
   OpenSCAD enclosure for FluxEngine_Hat
   Brian K. White - b.kenyon.w@gmail.com
   https://github.com/bkw777/FluxEngine_Hat
*/

// -------------------------------------------------------------------------
// UNITS: mm

// arc smoothness
$fn = $preview ? 18 : 36;

// fitment clearance
fc = 0.2;

// overcut/overlap/overextend
o = 0.1;

pcb_w = 83.82;  // hat pcb long dim
pcb_d = 24.13;  // hat pcb short dim
pcb_h = 1.6;    // pcb thickness
pcb_r = 1.905;  // hat pcb corner radius
pcb_t = 0.8;    // hat pcb top surface below inner top wall

fpga_xlen = 68;    // fpga pcb long dim
fpga_xpos = -3.5;  // fpga pcb center x-axis offset from hat pcb

// interior cavity height ends up setting the overall height
// make it tall enough so that when a usb cable is plugged in
// the cable end plug body is slightly recessed in the bottom surface
ich = 10.5;       // interior cavity height

// this extends the shell on the back end so the programmer socket is recessed
el = 4;    // extra length, interior cavity longer than hat pcb length

// at 1mm the 4 support posts just barely poke out the outside surface
wt = 1.05; //  wall thickness

rl = 1.27; // retainer lip

// this rib behind the usb port is just to balance
// the back end wall under the programmer port
// so both ends have about the same resistance to spreading
rib_height = 2.5;
rib_xpos = 1.27+2.54*9; // land exactly between pins in J1 & J2

post_w = wt; // support post xlen
post_d = 5;  // support post ylen

include <handy.scad>;

// ===============================================================

pcb_e = ich/2-pcb_t;    // hat pcb top surface elevation from body center

if ($preview) %import("FluxEngine_PCB.stl");

union() {

 translate([-el/4,0,pcb_e]) difference() {

  // main body shell
  rounded_cube(w=fc+pcb_w+fc+el,d=pcb_d+fc,h=ich,rh=pcb_r+fc,rv=pcb_r+fc,t=wt);

  // top, prog, & usb cut outs
  union() {
   cw = 20;
   cd = pcb_d-rl*2;
   ucd = pcb_d-post_d*2;
   translate([-4,0,-pcb_e])
    rounded_cube(w=o+wt+fc+pcb_w+fc+wt+el+o,d=cd,h=wt+ich+wt,rh=pcb_r+fc,rv=pcb_r+fc,t=0);
   translate([cw/2+fpga_xlen/2+fpga_xpos,0,ich/2])
    rounded_cube(w=cw,d=ucd,h=10,rh=3,rv=1,t=0);
   translate([cw/2+fpga_xlen/2,0,-ich/2])
    rounded_cube(w=20,d=cd,h=ich*2,rh=3,rv=3,t=0);
  }
 }

// support & registration posts
 mirror_copy([0,1,0])
  translate([fpga_xpos,-pcb_d/2-o,0])
   mirror_copy([1,0,0])
    translate([fpga_xlen/2+fc,0,pcb_h+fc])
     cube([post_w,post_d,pcb_e+ich/2-pcb_h]);

// rib
 translate([rib_xpos,0,0]) difference() {
  r = pcb_r+fc+o;
  translate([0,0,pcb_e]) hull() mirror_copy([0,0,1]) translate([0,0,ich/2-r]) mirror_copy([0,1,0]) translate([0,pcb_d/2-r+fc+o,0]) rotate([0,90,0]) cylinder(h=wt,r=r,center=true);
  translate([0,0,pcb_e-rib_height]) hull() mirror_copy([0,0,1]) translate([0,0,ich/2-r]) mirror_copy([0,1,0]) translate([0,pcb_d/2-r+fc+o,0]) rotate([0,90,0]) cylinder(h=wt+o,r=r,center=true);
 }

}