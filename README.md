# FluxEngine Kit

![](PCB/out/FluxEngine_Hat.jpg)
![](PCB/out/FluxEngine_Hat.2.jpg)
![](PCB/out/FluxEngine_Hat.3.jpg)
![](PCB/out/FluxEngine_Hat.4.jpg)
![](PCB/out/FluxEngine_Hat.5.jpg)
![](PCB/out/FluxEngine_Hat.6.jpg)
![](PCB/out/FluxEngine_Hat.top.jpg)
![](PCB/out/FluxEngine_Hat.bottom.jpg)
![](PCB/out/FluxEngine_Hat.svg)

THESE PCBs ARE NOT TESTED YET

This is a set of adapter PCBs and printable snap covers to build a nice version of [FluxEngine](http://cowlark.com/fluxengine/)

I am not the creator of FluxEngine itself, just this adapter PCB and printable cover.

Most people probably do not need any of these pcbs. They are really just to provide convenient support for 8-inch drives.

If you're not trying to use 8-inch drives, then you don't need any adapter pcb like this.  
The FluxEngine pinout is already designed so that you can just solder a 34-pin connector directly to the CY8CKIT-059 fpga board.  
You can use the BOM link below and delete everything but the CY8CKIT-059 and the 34-pin connector, no pcb, no printed cover.

The PCBs are designed to NOT need to be soldered. You can connect and remove and reconnect the fpga board without, and without needing to install actual sockets.
You CAN still solder them normally if you want to make a permanent FluxEngine, you just don't have to.

It means you can swap the same fpga board between all 3 (so far) hat versions, and then still also use the fpga board on a breadboard when not using it for FluxEngine.

What you do is solder pins to the bottom of the fpga board the same as if you were using it on a breadboard. And that's it. You can install actual matching sockets on the hat PCBs, but you don't have to. The zig/zag pin row layout on the hat PCBs makes solid electrical contact with the pins without needing a socket.

For the sake of the solderless pin connections, I suggest getting the PCBs made with ENIG finish (gold plating on the copper).  
It's not required though. Honestly the way the square edges of the pins bite into the via walls it probably will never make any difference.  
Some fabricators charge more than others for ENIG. OSHPark is always ENIG no matter what, so that's easy. But between PCBWAY, JLCPCB, and Elecrow, Elecrow charges a lot less for ENIG.

The cover (both styles) prints easily with any basic home FDM printer with PLA. I actually use a $150 Monoprice from 6 years ago.  

But also these days most of the PCB shops also offer 3d printing, so you can get the pcb and the cover printed professionally in sintered nylon from the same place on the same order.  
The link below is to PCBWAY only because it's the most convenient where you can just click "buy" on something already pre-loaded, but actually if you go to Elecrow and just upload the gerber zip and cover stl, it's just as simple and significantly cheaper, especially with ENIG.

## Parts
[BOM from DigiKey](https://www.digikey.com/short/q5zh79n9)  
[PCB and Cover from PCBWAY](https://www.pcbway.com/project/shareproject/FluxEngine_Hat_e3000eb5.html)

Power supply and cables:  
[Molex power supply](https://amazon.com/dp/B000MGG6SC)  
[Molex to Berg splitter](https://amazon.com/dp/B0002J1KW6)  
[Molex to Molex splitter](https://amazon.com/dp/B00007JO36)  
[Floppy drive cable](https://amazon.com/dp/B07KDJTMGP)  

## Cover

There are a few versions of printable cover in releases, all generated from the same OpenSCAD source.  
Two main styles, simple and fancy, in three sizes each, lowprofile, default, and one for if you have full pin sockets installed.  

## Configuration

The jumpers only affect the 50-pin connector for 8-inch drives.  

### DSKCHG / READY
Connects either the /DSKCHG or /READY output from the drive to the /DSKCHG input on the FluxEngine.  

Install jumper on DSKCHG by default.

### INUSE
Connects the /MOTB (motor-B-on) output from the FluxEngine to the /IN-USE aka /DOOR-LOCK input on the drive.

Not connected by default, but stow a jumper on one pin.

### HLD
Connects the /MOTB (motor-B-on) output from the FluxEngine to the /HEAD-LOAD input on the drive.

Not connected by default, but stow a jumper on one pin.

INUSE/HLD is not either-or. You may need either, or neither, or both.

# Control Data / Magnetic Peripherals / Honeywell 8-inch drives

Some CDC 8-inch drives like the 9404 and 9406-4 lines are Shugart compatible, and so for those just use the SA850 hat like any other Shugart interface drive.

Others have compatible signals but different pinouts.

The two tables below come from two CDC manuals covering many similar drive models spanning several years.  
Left: [CDC FDD FSM ('79)](PCB/datasheets/CDC_77834769_Y__FDD_FSM.pdf)  
Right: [CDC 9406 FSM ('82)](PCB/datasheets/CDC_77614903_AM__9406_FSM.pdf)  

![](PCB/datasheets/CDC_FDD_pinouts.png)

There are two hats that cover the most common CDC pinouts.

The "CDC-daisychain" hat supports all the green highlighted models.

The "CDC-standard" hat supports the blue and purple highlighted models.

"standard" is mis-named because what CDC called "standard interface" in the manuals was several different pinouts and interfaces.  
But of the several pinouts they called "standard", 2 are actually the same except for STEP+DIRECTION vs STEP_IN/STEP_OUT, and most models that don't have the "daisychain" interface seem to have one of these two versions of "standard".  
So the '''CDC-standard''' hat includes logic to optionally convert the STEP+DIRECTION signals from the FluxEngine to STEP_IN/STEP_OUT signals for the drive if needed.

For drives that need STEP_IN/STEP_OUT, install the 2 jumpers on STEP_IN and STEP_OUT. (earlier and less common drives)  
![](PCB/out/FluxEngine_Hat_CDC-standard.old.jpg)

For drives that need STEP+DIRECTION, install the 2 jumpers on DIR and STEP. (default, later and more common drives)  
![](PCB/out/FluxEngine_Hat_CDC-standard.new.jpg)

If you don't need the STEP_IN/STEP_OUT option, you don't need to populate C1 or U1 or the jumper pins. Just use solder or wire in place of the STEP & DIR jumpers and leave the U1 and C1 footprints empty.  
![](PCB/out/FluxEngine_Hat_CDC-standard.new-only.jpg)


NONE OF THESE ARE TESTED YET  

![](PCB/out/FluxEngine_Hat_CDC-daisychain.svg)
![](PCB/out/FluxEngine_Hat_CDC-daisychain.top.jpg)
![](PCB/out/FluxEngine_Hat_CDC-daisychain.bottom.jpg)

![](PCB/out/FluxEngine_Hat_CDC-standard.svg)
![](PCB/out/FluxEngine_Hat_CDC-standard.jpg)
![](PCB/out/FluxEngine_Hat_CDC-standard.top.jpg)
![](PCB/out/FluxEngine_Hat_CDC-standard.bottom.jpg)

CDC-daisychain BOM:  
Standard BOM, delete the jumpers.  

CDC-standard BOM:  
Standard BOM, add these:  
[screw terminal header](https://www.digikey.com/en/products/detail/phoenix-contact/5452094/5186805)  
[screw terminal plug](https://www.digikey.com/en/products/detail/phoenix-contact/5452178/5187210)  
[74LVC1G19 1to2 decoder](https://www.digikey.com/en/products/detail/nexperia-usa-inc/74LVC1G19GW-125/1231453)  
[C 0.1u 0805](https://www.digikey.com/en/products/detail/kyocera-avx/KGM21NR71E104KT/1116281)  

### More 8-inch info

The AC & DC power connectors were the same on many drives.  
These are the cable-side connector housings and female pins needed to make proper cables to connect to most drives.

3-pin AC power:  
Housing: [AMP/TE 1-480700-0](https://www.digikey.com/en/products/detail/te-connectivity-amp-connectors/1-480700-0/29339)  
Female pins: [AMP/TE 350536-1](https://www.digikey.com/en/products/detail/te-connectivity-amp-connectors/350536-1/287712)

6-pin DC power:  
Housing: [AMP/TE 1-480270-0](https://www.digikey.com/en/products/detail/te-connectivity-amp-connectors/1-480270-0/15668)  
Female pins: [AMP/TE 61117-1](https://www.digikey.com/en/products/detail/te-connectivity-amp-connectors/61117-1/290254)

They do make dual-output power supplies that output both 5v and 24v, but it's actually cheaper to buy seperate supplies.  
A typical drive draws about 1.0A-1.5A from either DC rail while working.  
Here are a couple of supplies just for convenience & reference:  
[5V 3A Meanwell](https://www.digikey.com/en/products/detail/mean-well-usa-inc/RS-15-5/7706168)  
[24V 3.2A Meanwell](https://www.digikey.com/en/products/detail/mean-well-usa-inc/RS-15-5/7706168)

### Probably CDC-specific

The CDC manuals do not say this anywhere, but many drives have a variant of the 50-pin IDC header with two polarity key slots instead of one in the center. The drawings and actual part numbers in the service manuals only show the normal single-notch type.  
A normal IDC plug with polarity key does not fit. Non-polarized plugs fit, but here are a couple of fully polarity-keyed female IDC plugs that fit:  
[Omron XG4M-5031-T](https://www.digikey.com/en/products/detail/omron-electronics-inc-emc-div/XG4M-5031-T/1829402)  
[Hirose HIF3BA-50D-2.54R](https://www.digikey.com/en/products/detail/hirose-electric-co-ltd/HIF3BA-50D-2-54R-63/12758574)

Connector housing & contacts to fit the 7-pin power connection on CDC drives.  
The pins are .156" pitch, and have a .031"x.062" flat blade shape not square.  
The pin and housing series is called "AMPMODU MOD I", and you want specifically the high pressure version of the receptacles for power vs merely signal usage.  
Only the 4 middle pins are connected, so you could uses as little as a 5-position housing, but ideally you still want a housing with all 7 (or more) positions, and receptacles installed for all 6 pins, because the extra 2 pins provide both strain relief and extra retention friction.  
[TE 87159-7 - AMPMODU MOD I receptacle housing, 7-pin, non-locking, keyed](https://mou.sr/4bhcBrf) (cut the key bumps off)  
[TE 102100-2 - AMPMODU MOD I pin receptacle, non-locking high-pressure 18-22awg gold-30uin](https://mou.sr/44tt5K6) (need 6)  
[TE 87116-2 - AMPMODU MOD I keying plug](https://us.rs-online.com/product/te-connectivity/87116-2/70287356/) (need 1)  
