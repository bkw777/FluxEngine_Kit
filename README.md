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

This is an adapter PCB and printable snap cover to build a nice version of [FluxEngine](http://cowlark.com/fluxengine/)

I am not the creator of FluxEngine itself, just this connector PCB and printable cover.

Most people probably do not need this pcb. It's really just to provide convenient support for 8-inch drives.

If you don't need to support 8-inch drives, then you don't need any adapter pcb like this.  
The FluxEngine pinout is already designed so that you can just solder a 34-pin connector directly to the CY8CKIT-059 fpga board.  
You could skip the pcb and the printed cover, use the same BOM link below and remove the 50-pin connector and pin headers, and just keep the fpga board and the 34-pin connector.

## PARTS
[BOM from DigiKey](https://www.digikey.com/short/r214w4b0)  
[PCB and Cover from PCBWAY](https://www.pcbway.com/project/shareproject/FluxEngine_Hat_e3000eb5.html)

If you don't already have a convenient way to power the floppy drive(s) externally:  
[Molex power supply](https://amazon.com/dp/B000MGG6SC)  
[Molex to Berg splitter](https://amazon.com/dp/B0002J1KW6)  
[Molex to Molex splitter](https://amazon.com/dp/B00007JO36)  
[Floppy drive cable](https://amazon.com/dp/B07KDJTMGP)  

## Enclosure

There is a printable [cover](CASE/out/FluxEngine_Case.stl) in the CASE directory, designed in OpenSCAD.

![](CASE/out/FluxEngine_Case.jpg)

## Fabrication

The cover prints easily with any common FDM printer with PLA.

The PCBWAY link above can provide both the PCB and the cover. The buy link to the right is for the pcb. To get the cover scroll down the page to the FluxEngine_Case.stl file and it has it's own buy link.

You can also get both the pcb and the cover at the same time on the same order from Elecrow for about $13 including shipping.  
Get the gerber.zip and STL from [releases](../../releases).
Choose high strength nylon for the 3d printing to get a strong black part.

## Configuration

The jumpers only affect the 50-pin connector for 8-inch drives.  

### FD2S
NOT a jumper! Do Not Short!

The pin closer to the connector is pin 10 on the 50-pin, the other pin is GND.

This is a signal from the drive to tell the host that the drive has detected a 2-sided disk.

FluxEngine currently does not have any input for this signal, and doesn't really need it, and most drives do not generate it, and so the pin should probably just not exist on the PCB to avoid confusion and accidents. But if you had a drive that outputs this signal, you could perhaps connect an LED and see the signal. On = SS disk, Off = DS disk.

### DSKCH / READY
Connects one of two possible outputs DSKCHG or /READY from the drive, to the /READY input on the host.  

Install a single jumper on one of these, not both, not neither.

DSKCHG behaves the same as modern PC drive /READY, so install the jumper on DSKCH by default.

### DLOCK / HLD
Connects the MOTEB/DS4 (motor-on) output from the host to either the DOOR-LOCK/IN-USE input on the drive, or the HEAD-LOAD input on the drive, or neither, or both.

Usually not needed, but if needed, you may need one or the other or both.

Don't short either position by default, but do stow an inactive jumper in both places.

