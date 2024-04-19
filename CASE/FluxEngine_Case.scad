/*
   OpenSCAD enclosure for FluxEngine_Hat
   Brian K. White - b.kenyon.w@gmail.com
   https://github.com/bkw777/FluxEngine_Hat
   v007
*/

// -------------------------------------------------------------------------
// UNITS: mm

type = "full"; // "slim" or "full"

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
pcb_t = fc*2;      // hat pcb top surface to ceiling

fpga_xlen = 67.894; // fpga pcb long dim

fpga_xpos = 3.5;  // fpga pcb center x-axis offset from hat pcb

// this extends the shell on the back end just enough so the programmer socket doesn't stick out
el = 2.5;      // extra length, interior cavity longer than hat pcb length

wt = 1;      //  wall thickness

rl = 1.27;   // top retaining lip overhang

post_w = wt; // support post xlen
post_d = 5;  // support post ylen

r = 2;       // inside radii

pin_ins_h = 2.54; // pin header insulator height
fpga_pcb_h = 2;   // fpga pcb thickness (not 1.6)
usb_plug_h = 6.5; // usb cable plug thickness
usb_plug_d = 11;  // usb cable plug width
usb_jack_h = 2.6; // usb jack thickness, not counting funnel
prog_h = 2.54;    // programmer socket thickness

// bottom stack
//bs = 2.54 + 2 + 1.33;

// interior cavity height ends up setting the overall height
// TODO derive from the board & connector stackup & usb plug position & thickness
//slim_ich = 9.8;
//full_ich = 12;
//ich = (type=="slim") ? slim_ich : full_ich; // interior cavity height

tih = pcb_t + pcb_h; // top interior height
teh = tih + fc + wt; // top exterior height

// bottom interior height
bih = (type=="slim")
        ? pin_ins_h + fpga_pcb_h + usb_jack_h + fc
        : pin_ins_h + fpga_pcb_h + usb_jack_h/2 + usb_plug_h/2 + fc; 

beh = bih + fc + wt; // bottom exterior height
ih = tih + bih; // total interior height

// ===============================================================

include <handy.scad>;

if ($preview) #import(pcb_stl);

// translate z depending on preview vs render
trz = $preview ? 0 : beh;

translate ([0,0,trz]) union() {

 difference() {

  // main body shell
  iw = fc+pcb_w+fc+el; // interior cavity long dim
  translate([-el/2,0,-ih/2+tih])
   rounded_cube(w=iw,d=fc+pcb_d+fc,h=ih,rh=r,rv=r,t=wt);

  // cutouts
  union() {
   cw = 20;    // cut width
   ch = ih*2; // cut height
   // main top cutout
   translate([-el/2-r,0,ch/2-prog_h-1])
    rounded_cube(w=iw+r*2,d=pcb_d-rl*2,h=ch,rh=r,rv=r,t=0);
   // usb port
   translate([cw/2+fpga_xlen/2-fpga_xpos,0,-pin_ins_h-fpga_pcb_h-usb_jack_h/2])
    rounded_cube(w=cw,d=fc+usb_plug_d+fc,h=fc+usb_plug_h+fc,rh=r,rv=r,t=0);
  }

 }

 // support & registration posts
 mirror_copy([0,1,0])
  translate([-fpga_xpos,-pcb_d/2-o,0])
   mirror_copy([1,0,0])
    translate([fpga_xlen/2+fc,0,-bih-fc])
     cube([post_w,post_d,bih]);

}

