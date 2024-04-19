/*
   OpenSCAD enclosure for FluxEngine_Hat
   Brian K. White - b.kenyon.w@gmail.com
   https://github.com/bkw777/FluxEngine_Hat
*/

// -------------------------------------------------------------------------
// UNITS: mm

pcb_stl = "FluxEngine_PCB.stl";

// arc smoothness
$fn = $preview ? 18 : 36;

// fitment clearance
fc = 0.3;

// overcut/overlap/overextend
o = 0.1;

pcb_w = 83.312; // hat pcb long dim
pcb_d = 24.13;  // hat pcb short dim
pcb_h = 1.6;    // pcb thickness
pcb_t = 0.8;    // hat pcb top surface below inner top wall

fpga_xlen = 67.894; // fpga pcb long dim

fpga_xpos = 3.5;  // fpga pcb center x-axis offset from hat pcb

// interior cavity height ends up setting the overall height
// TODO this is really derived from the board & connector stackup
// and the dimensions of the usb socket height above the pcb and the usb plug body thickness
ich = 12;   // interior cavity height

// this extends the shell on the back end just enough so the programmer socket doesn't stick out
el = 2;  // extra length, interior cavity longer than hat pcb length

wt = 1;  //  wall thickness

rl = 1.27; // top retaining lip overhang

post_w = wt; // support post xlen
post_d = 5;  // support post ylen

r = 2; // inside radii

uh = 7.46; // usb plug thickness
ud = 13;   // usb plug width

// pcb z=0 to body z=0
// (bottom surface of hat pcb to center of body)
pbz = ich/2-pcb_h-pcb_t;

// TODO derive from component stackup
pwh = 5; // programmer wall height
uz = pbz-2.54-2-1.33; // usb plug zpos

// ===============================================================

include <handy.scad>;

if ($preview) %import(pcb_stl);

// translate z depending on preview vs render
trz = $preview ? -pbz : ich/2+wt;


translate ([0,0,trz]) union() {

 difference() {

  // main body shell
  icw = fc+pcb_w+fc+el+r; // interior cavity long dim
  translate([-el/2,0,0])
   rounded_cube(w=icw,d=fc+pcb_d+fc,h=ich,rh=r,rv=r,t=wt);

  // cutouts
  union() {
   cw = 20; // cut width
   cd = pcb_d-rl*2; // cut depth
   ch = ich*2; // cut height
   // main top cutout
   translate([-el/2-r*2,0,ch/2-ich/2+pwh])
    #rounded_cube(w=wt+r+icw+r+wt,d=cd,h=ch,rh=r,rv=r,t=0);
   // usb port
   translate([cw/2+fpga_xlen/2,0,uz])
    rounded_cube(w=cw,d=ud,h=uh,rh=r,rv=r,t=0);
  }

 }

 // support & registration posts
 mirror_copy([0,1,0])
  translate([-fpga_xpos,-pcb_d/2-o,0])
   mirror_copy([1,0,0])
    translate([fpga_xlen/2+fc,0,-ich/2-fc])
     cube([post_w,post_d,ich/2+pbz]);

}

