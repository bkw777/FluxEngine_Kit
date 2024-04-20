/*
   OpenSCAD enclosure for FluxEngine_Hat
   Brian K. White - b.kenyon.w@gmail.com
   https://github.com/bkw777/FluxEngine_Hat
   v008
*/

// -------------------------------------------------------------------------
// UNITS: mm

type = "full"; // "slim" or "full"

pcb_stl = "FluxEngine_PCB.stl";

// arc smoothness
$fn = 36;

// fitment clearance
fc = 0.4;

// overcut/overlap/overextend
o = 0.1;

r = 2.54;          // inside radii

pcb_w = 83.312; // hat pcb long dim
pcb_d = 24.13;  // hat pcb short dim
pcb_h = 1.6;    // pcb thickness
pcb_t = r/2;    // hat pcb top surface to ceiling

fpga_xlen = 67.894; // fpga pcb long dim

fpga_xpos = 3.5;  // fpga pcb center x-axis offset from hat pcb

// this extends the shell on the back end just enough so the programmer socket doesn't stick out
el = 2.5;      // extra length, interior cavity longer than hat pcb length

wt = 1;      //  wall thickness

rl = 1.27;   // top retaining lip overhang

post_w = wt; // support post xlen
post_d = 5;  // support post ylen

pin_ins_h = 2.54; // pin header insulator height
fpga_pcb_h = 2;   // fpga pcb thickness (not 1.6)
usb_plug_h = 7; // usb cable plug thickness
usb_plug_d = 11;  // usb cable plug width
usb_jack_h = 2.6; // usb jack thickness, not counting funnel
prog_h = 2.54;    // programmer socket thickness
prog_d = 5*2.54;  // programmer socket lon dim

tih = pcb_t + pcb_h; // top interior height
teh = tih + wt;      // top exterior height
// bottom interior height
bih = (type=="slim")
        ? pin_ins_h + fpga_pcb_h + usb_jack_h + fc
        : pin_ins_h + fpga_pcb_h + usb_jack_h/2 + usb_plug_h/2 + fc; 
beh = bih + fc + wt; // bottom exterior height
ih = tih + bih;      // total interior height
iw = fc+pcb_w+fc+el; // interior cavity long dim
id = fc+pcb_d+fc;    // interior cavity short dim

// ===============================================================

include <handy.scad>;

%import(pcb_stl);

// translate z depending on preview vs render
trz = $preview ? 0 : beh;

translate ([0,0,trz]) union() {

 difference() {

  // main body shell
  translate([-el/2,0,-ih/2+tih])
   rounded_cube(w=iw,d=id,h=ih,rh=r,rv=r,t=wt);

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
  translate([-fpga_xpos,0,-fc]) {
    mirror_copy([1,0,0]) {
      translate([fpga_xlen/2+wt/2+fc,0,0]) {
        ch = bih-r-fc;
        cd = o+id+o;

        difference () {

          // add wall
          hull() {
            translate([0,0,-ch/2])
              cube([wt,cd,ch],center=true);

            mirror_copy([0,1,0])
              translate([0,cd/2-r,-ch-o])
                rotate([0,90,0])
                  cylinder(h=wt,r=r,center=true);
          }

          // cut out middle
          hull() {

            // slim version needs the fillets at the bases
            // cut back further because they poke out
            // into the usb cable opening
            ec = (type=="slim") ? wt/2 : 0;

            translate([0,0,-ch/2])
              cube([o+wt+o,1+prog_d+1,ch+o],center=true);
            mirror_copy([0,1,0])
              translate([0,prog_d/2-r+1,-ch-ec])
                rotate([0,-90,0])
                  cylinder(h=o+wt+o,r=r,center=true);
          }
        }
      }

    }
  }
}

