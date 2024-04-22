/*
   Fancy Cover for FluxEngine_Hat
   Brian K. White - b.kenyon.w@gmail.com
   https://github.com/bkw777/FluxEngine_Kit
   v012
*/

// -------------------------------------------------------------------------
// UNITS: mm

// "slim" generates the smallest possible shell
// "full" strain relieves the usb for less than 2mm taller
type = "full";

pcb_stl = "PCBs.stl";

$fn = 36;         // arc smoothness

wt = 1;           // wall thickness
fc = 0.4;         // fitment clearance
o = 0.1;          // overcut/overlap/overextend
r = 2.54;         // inside radii, 0.001 to (fc+usb_plug_h+fc)/2

pcb_w = 83.312;   // hat pcb long dim
pcb_d = 24.13;    // hat pcb short dim
pcb_h = 1.6;      // pcb thickness
pcb_t = r/2;      // hat pcb top surface to ceiling

fpga_xlen = 67.894; // fpga pcb long dim
fpga_xpos = 3.5;  // fpga pcb center x-axis offset from hat pcb
el = 2.5;         // extend shell to protect programmer socket

rl = 1.27;        // top retaining lip overhang

pin_ins_h = 2.54; // pin header insulator height
fpga_pcb_h = 2;   // fpga pcb thickness (not 1.6)
usb_plug_h = 7;   // usb cable plug thickness
usb_plug_d = 11;  // usb cable plug width
usb_jack_h = 2.6; // usb jack thickness, not counting funnel
prog_h = 2.54;    // programmer socket thickness
prog_d = 5*2.54;  // programmer socket long dim
prog_c = fc ; //fc; // clearance around programmer socket

tih = pcb_t + pcb_h; // top interior height
teh = tih + wt;      // top exterior height
// bottom interior height
bih =
        (type=="slim") ? pin_ins_h + fpga_pcb_h + usb_jack_h + fc :
        pin_ins_h + fpga_pcb_h + usb_jack_h/2 + usb_plug_h/2 + fc ;

beh = bih + fc + wt; // bottom exterior height
ih = tih + bih;      // total interior height
iw = fc+pcb_w+fc+el; // interior cavity long dim
id = fc+pcb_d+fc;    // interior cavity short dim

post_w = wt;         // support posts thickness

// ===============================================================

include <handy.scad>;

%import(pcb_stl);

// translate z depending on preview vs render
trz = $preview ? 0 : beh;

translate ([0,0,trz]) union() {

 difference() {

  // main body shell
  translate([el/2,0,-ih/2+tih])
   rounded_cube(w=iw,d=id,h=ih,rh=r,rv=r,t=wt);

  // cutouts
  union() {
   cw = 20;   // cut width
   ch = ih*2; // cut height
   // main top cutout
   translate([el/2+r+wt,0,ch/2-prog_h-prog_c])
    rounded_cube(w=iw+r*2+wt*2,d=pcb_d-rl*2,h=ch,rh=r,rv=r,t=0);
   // usb port
   translate([-cw/2-fpga_xlen/2+fpga_xpos,0,-pin_ins_h-fpga_pcb_h-usb_jack_h/2])
    rounded_cube(w=cw,d=fc+usb_plug_d+fc,h=fc+usb_plug_h+fc,rh=r,rv=r,t=0);
  }

 }

 // support & registration posts
  translate([fpga_xpos,0,-fc]) {
    mirror_copy([1,0,0]) {
      translate([fpga_xlen/2+post_w/2+fc,0,0]) {

        // slim version needs the fillets reduced
        // to stay out of the usb opening
        ec = (type=="slim") ? wt/2 : 0;

        difference () {
          translate([0,0,-bih/2])
            rotate([90,0,90])
              D(w=o+id+o,d=bih,h=post_w,r=r);
          translate([0,0,-bih/2+fc-ec/2])
            rotate([90,0,90])
              D(w=prog_d+prog_c*2,d=bih+ec,h=o+post_w+o,r=r);
        }

      }

    }
  }
}

