# FluxEngine Kit

![](PCB/out/FluxEngine_Hat.jpg)
![](PCB/out/FluxEngine_Hat.2.jpg)
![](PCB/out/FluxEngine_Hat.3.jpg)
![](PCB/out/FluxEngine_Hat.4.jpg)
![](PCB/out/FluxEngine_Hat.5.jpg)
![](PCB/out/FluxEngine_Hat.6.jpg)
![](PCB/out/SimpleCover_front.jpg)
![](PCB/out/SimpleCover_back.jpg)
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

## Parts
[BOM from DigiKey](https://www.digikey.com/short/q5zh79n9)  
[PCB and Cover from PCBWAY](https://www.pcbway.com/project/shareproject/FluxEngine_Hat_e3000eb5.html)

If you don't already have a convenient way to power the floppy drive(s) externally:  
[Molex power supply](https://amazon.com/dp/B000MGG6SC)  
[Molex to Berg splitter](https://amazon.com/dp/B0002J1KW6)  
[Molex to Molex splitter](https://amazon.com/dp/B00007JO36)  
[Floppy drive cable](https://amazon.com/dp/B07KDJTMGP)  

## Cover

There are several versions of printable cover in the CASE directory.

[FluxEngine_FancyCover.stl](CASE/out/FluxEngine_FancyCover.stl)

![](CASE/out/FancyCover.jpg)

[FluxEngine_SimpleCover.stl](CASE/out/FluxEngine_SimpleCover.stl) - soldered and flush-cut pins  
[FluxEngine_SimpleCover_solderless.stl](CASE/out/FluxEngine_SimpleCover_solderless.stl) - dry-fit full length pins   
[FluxEngine_SimpleCover_sockets.stl](CASE/out/FluxEngine_SimpleCover_sockets.stl) - square pin sockets  

![](CASE/out/SimpleCover.jpg)  
![](PCB/out/SimpleCover_styles.jpg)

## Fabrication

The cover prints easily with any common FDM printer with PLA.

The PCBWAY link above can provide both the PCB and the cover. The buy link to the right is for the pcb. To get the cover scroll down the page to the STL file and it has it's own buy link.

You can also get both the pcb and the cover at the same time on the same order from Elecrow for about $13 including shipping.  
Get the gerber.zip and STL from [releases](../../releases).
Choose high strength nylon for the 3d printing to get a strong black part. It doesn't really need the strength of nylon, but resin will probably be too fragile.

## Configuration

The jumpers only affect the 50-pin connector for 8-inch drives.  

### DC / RDY
Connects either /DSKCHG or /READY output from the drive to the /DSKCHG input on the host.  

Install jumper on DC by default.

### DLK / HLD
Connects the /MOTA (motor-A-on) output from the host to either the /DOOR-LOCK aka /IN-USE or /HEAD-LOAD input on the drive, or neither, or both.

Usually not needed, but if needed, you may need one or the other or both.

Don't short either position by default, but do stow two inactive jumpers.

# Control Data Corporation / Magnetic Peripherals Inc / Honeywell 8-inch drives

CDC drives seem to have been pretty common. The same drives appear under a few different names because of the way they were [OEMed by MPI to CDC and Honeywell](https://en.wikipedia.org/wiki/Control_Data_Corporation#Magnetic_Peripherals_Inc.), and then CDC also sold them to yet others like [Centurion](https://www.youtube.com/watch?v=GmuDJC1gJOo).

CDC drives have a totally different pinout than Shugart. They actually have several different configurations and some are completely custom and incompatible, but most models seem to have used slight variations on one pinout. So I'll call that pinout "CDC standard".

----

EDIT: I got this backwards. Both manuals say:
```
3.4.2  DC POWER CONNECTION  
DC power (user-supplied) for standard FDD models is transmitted from the controller  
via the I/O cable through the interface connector (J1) on the printed-circuit board.  
Daisy-chain FDD models receive DC power (user-supplied) through a power cable which  
interfaces with its mating connector (J4) on the printed-circuit board.
```
So the pinout I called ALT1 should be called "Standard"  
and the pinout I called STD should be called "DaisyChain"

----

The two tables below come from two CDC manuals covering many similar drive models spanning a few years.  
Left: [CDC FDD FSM ('79)](PCB/datasheets/CDC_77834769_Y__FDD_FSM.pdf)  
Right: [CDC 9406 FSM ('82)](PCB/datasheets/CDC_77614903_AM__9406_FSM.pdf)  

![](PCB/datasheets/CDC_FDD_pinouts.png)

There is a special hat for CDC which should work for all the green highlighted drives, and (I'm guessing) probably covers most CDC/MPI/Honeywell drives.

There is also a hat version for "CDC ALT1", the purple highlight, simply because at least that pinout has the necessary signals that it's possible.  
I have no idea if those models are common, or if the power really needs to be on the data cable or if the drives still have a simple way to provide the DC power directly. The hat includes the power connections simply because it was possible without even increasing the size of the pcb. The drive draws less than 1.5A on either rail, and both the screw terminals and the traces are good for over 5A. So although I don't really *recommend* powering a drive that way if there is any other option, it should be fully safe to do so.

One of the other pinouts, the 4th column on the left table, under 75892150, is almost identical to "ALT1" with the only differences being it has STEP_IN + STEP_OUT instead of STEP + DIRECTION, but using the same 2 pins, and there is no READY signal. So maybe those drives could eventually be supported also by the same ALT1 hat with only software or firmware changes. Worst case I could probably add a tiny bit of logic to the board (probably a few gates in a single 74xx series) to optionally convert the STEP signals. I don't know about the lack of READY though.

THESE ARE NOT TESTED YET  
I have a BR8A8A aka 77618019 drive on the way. That will be a test of the "CDC standard" hat.

![](PCB/out/FluxEngine_Hat_CDC.svg)
![](PCB/out/FluxEngine_Hat_CDC.top.jpg)
![](PCB/out/FluxEngine_Hat_CDC.bottom.jpg)

![](PCB/out/FluxEngine_Hat_CDC_ALT1.svg)
![](PCB/out/FluxEngine_Hat_CDC_ALT1.jpg)
![](PCB/out/FluxEngine_Hat_CDC_ALT1.top.jpg)
![](PCB/out/FluxEngine_Hat_CDC_ALT1.bottom.jpg)
The screw terminal can be anything that fits the 3.5mm pin pitch footprint.
The renders show a vertical style which is ideal because it allows the printed cover to be installed without bending the wires, and the cover ends up covering up the exposed screw heads too.
A pluggable/unpluggable style would be even better but for now just for reference here is a link to the exact type in the render:  
[2-pin 3.5mm pitch top-entry screw terminal](https://www.digikey.com/en/products/detail/on-shore-technology-inc/OSTTF020161/614572)

### More 8-inch info

The AC & DC power connectors were the same on many drives, both Shugart compatible and CDC even though the CDC data bus pinout is totally different.

These are the cable-side connector housings and female pins needed to make proper cables to connect to a drive.

3-pin AC power:  
Housing: [AMP/TE 1-480700-0](https://www.digikey.com/en/products/detail/te-connectivity-amp-connectors/1-480700-0/29339)  
Female pins: [AMP/TE 350536-1](https://www.digikey.com/en/products/detail/te-connectivity-amp-connectors/350536-1/287712)

6-pin DC power:  
Housing: [AMP/TE 1-480270-0](https://www.digikey.com/en/products/detail/te-connectivity-amp-connectors/1-480270-0/15668)  
Female pins: [AMP/TE 61117-1](https://www.digikey.com/en/products/detail/te-connectivity-amp-connectors/61117-1/290254)

They do make dual-output power supplies that output both 5v and 24v, but it's actually cheaper to buy seperate supplies.  
A typical drive draws about 1.0A-1.5A from either DC rails while working.  
Here are a couple of supplies just for convenience & reference:  
[5V 3A Meanwell](https://www.digikey.com/en/products/detail/mean-well-usa-inc/RS-15-5/7706168)  
[24V 3.2A Meanwell](https://www.digikey.com/en/products/detail/mean-well-usa-inc/RS-15-5/7706168)

