/*
   Fancy Cover for FluxEngine_Hat
   Brian K. White - b.kenyon.w@gmail.com
   https://github.com/bkw777/FluxEngine_Kit
   v013
*/

// -------------------------------------------------------------------------

style = "simple";   // "fancy" "simple"
lowprofile = false; // true false
sockets = false;    // true false

// -------------------------------------------------------------------------
// UNITS: mm

pcb_stl =
        (sockets) ? "PCBs_sockets.stl" :
        "PCBs.stl";

$fn = 36;         // arc smoothness

wt = (style=="fancy") ? 1 : 2; // wall thickness
fc = (style=="fancy") ? 0.4 : 0.2;  // fitment clearance
o = 0.1;          // overcut/overlap/overextend
r = 2.54;         // inside radii, 0.001 to (fc+usb_plug_h+fc)/2

pcb_w = 83.312;   // hat pcb long dim
pcb_d = 24.13;    // hat pcb short dim
pcb_h = 1.6;      // pcb thickness
pcb_t = r/2;      // hat pcb top surface to ceiling

fpga_xlen = 67.894; // fpga pcb long dim
fpga_xpos = 3.5;  // fpga pcb center x-axis offset from hat pcb
fpga_pcb_h = 2;   // fpga pcb thickness (it's not 1.6)

el = (style=="fancy") ? 2.5 : 4; // extend shell to protect programmer socket

rl = 1.27;        // top retaining lip overhang

sockets_height = (sockets) ? 8.5 : 0; // sockets add 8.5mm height between pcbs
pin_ins_h = 2.54 + sockets_height; // pin header insulator height
usb_plug_h = 7;   // usb cable plug thickness
usb_plug_d = 11;  // usb cable plug width
usb_jack_h = 2.6; // usb jack thickness, not counting funnel
prog_h = 2.54;    // programmer socket thickness
prog_d = 5*2.54;  // programmer socket long dim
prog_c = fc ; //fc; // clearance around programmer socket

tih = pcb_t + pcb_h; // top interior height

// bottom interior height
bih =
        (lowprofile) ? pin_ins_h + fpga_pcb_h + usb_jack_h + fc :
        pin_ins_h + fpga_pcb_h + usb_jack_h/2 + usb_plug_h/2 + fc ;

beh = bih + fc + wt; // bottom exterior height
ih = tih + bih;      // total interior height
iw = fc+pcb_w+fc+el; // interior cavity long dim
id = fc+pcb_d+fc;    // interior cavity short dim

post_w = wt;         // support posts thickness

mwt = 0.8;           // min wall thickness
ew = el + pcb_w + el; // exterior width (length really, the long dim)
ed = mwt + fc + pcb_d + fc + mwt; // exterior depth (width really, the short horiz dim)
exposed_pins_height = (lowprofile) ? 2 : 5;
assert(exposed_pins_height>1);
teh = (style=="fancy") ? tih + wt : pcb_h + exposed_pins_height; // top exterior height
eh = teh + beh; // exterior height
irmaj = 2;
rmaj = irmaj+wt;
rmin = wt;

// ===============================================================

include <handy.scad>;

%import(pcb_stl);



///////////////////////////////////////////////////////////////
// SIMPLE
///////////////////////////////////////////////////////////////

module simple_cover () {

  difference() {
  
    // add
    hull() {
      // top
      mirror_copy([0,1,0])
        translate([0,ed/2-wt,-rmaj+teh])
          rotate([90,0,0])
            rounded_cube(w=ew,d=rmaj*2,h=wt*2,rh=rmaj,rv=rmin,t=0);
      // bottom
      mirror_copy([1,0,0])
        translate([ew/2-wt,0,rmaj-beh])
          rotate([0,90,0])
            rounded_cube(w=rmaj*2,d=ed,h=wt*2,rh=rmaj,rv=rmin,t=0);
    }
  
    // remove
    union() {
      bh = beh + teh + wt + 1;
      translate([0,0,bh/2-beh+wt])
        rounded_cube(w=rmaj+ew+rmaj,d=ed-wt*2,h=bh,rh=irmaj,rv=irmaj);

      ch = fc+pcb_h+pin_ins_h+fpga_pcb_h+fc;
      hull() {
        mirror_copy([1,0,0])
          translate([pcb_w/2-r+fc,0,0])
            mirror_copy([0,1,0])
              translate([0,pcb_d/2-r,-ch/2+pcb_h+fc])
                cylinder(h=ch,r=r+fc,center=true);
      }
      
      if (lowprofile) {
        uch = wt*2;
        ucw = 20;
        ucd = usb_plug_d+2;
        translate([fpga_xpos-ucw/2-fpga_xlen/2,0,-bih-wt/2])
          rounded_cube(w=ucw,d=ucd,h=uch,rh=r,rv=0.01);
      }
    
    }
  
  }


}



///////////////////////////////////////////////////////////////
// FANCY
///////////////////////////////////////////////////////////////

module fancy_cover () {
  union() {
  
   difference() {
  
    // main body shell
    translate([el/2,0,-ih/2+tih])
     rounded_cube(w=iw,d=id,h=ih,rh=r,rv=r,t=wt);
  
    // cutouts
    union() {
     cw = 20;   // cut width
     ch = ih*2; // cut height
     // main top cutout
     translate([el/2+r+wt,0,ch/2-prog_h-prog_c-sockets_height])
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
  
          // lowprofile version needs the fillets reduced
          // to stay out of the usb opening
          ec = (lowprofile) ? wt*0.75 : 0;
  
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
}



///////////////////////////////////////////////////////////////
// RENDER
///////////////////////////////////////////////////////////////

//z = $preview ? 0 : beh;
//translate ([0,0,z]) {
  if (style=="fancy")
    fancy_cover();
  else
    simple_cover();
//}

// orient simple_cover for printing
/*
r = $preview ? 0 : 90;
z = $preview ? 0 : ew/2;
translate ([beh-eh/2,0,z])
  rotate([0,r,0])
    simple_cover();
*/
