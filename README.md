# FluxEngine Kit

![](PCB/out/FluxEngine_Hat.jpg)
![](PCB/out/FluxEngine_Hat_2.jpg)
![](PCB/out/FluxEngine_Hat_3.jpg)
![](PCB/out/FluxEngine_Hat_4.jpg)
![](PCB/out/FluxEngine_Hat.top.jpg)
![](PCB/out/FluxEngine_Hat.bottom.jpg)
![](PCB/out/FluxEngine_Hat.svg)

All of the pieces to assemble a [FluxEngine](http://cowlark.com/fluxengine/)

I am not the creator of FluxEngine, this is just an adapter PCB to provide 34 and 50 pin connectors, and eventually maybe a 3d-printable case, and some directions and links to parts.

The PCB is based on the [user-submitted PCB](http://cowlark.com/fluxengine/doc/building.html#if-you-want-to-use-a-pcb) on the FluxEngine site.

Differences:  
* Re-drawn in KiCAD instead of Eagle.
* no connect on the fpga board TX & RX pins (J1 9 & 10)
* no connect on 34-pin 3,4,5,6
* physically remove pin 5 from the 34-pin 
* flipped over so the fpga board can be soldered close to the pcb and yet still be able to use the usb port


This PCB isn't needed for the most common use-case.  
The most practical way to assemble a FluxEngine is to just solder the even row of the 34-pin connector directly to J1 pins 8-24 on the fpga board.  
Before soldering, pull out pin 5 and discard it. After soldering, solder a 3 inch long bare wire to J1 pin 25 labelled GND, then lay that along the odd row pins of the connector and solder the wire to all the odd row pins.  
That's it. That's a complete FluxEngine ready to go for 99% of use cases with typical 360k, 720k, 1.2M, 1.44M, 3.5 and 5.25 inch floppy drives.

This PCB is just to supply a 50 pin connector for 8-inch drives as well as the normal 34-pin connector for 3.5 and 5.25 inch drives.

It also provides a convenient way to make the floppy connectors removable with pin headers and sockets, so you can still use the fpga board for other things.  
Just solder male pins to the bottom of the fpga board the same way you would any other mcu dev board so that you can plug it in to a bread board with the usb and button facing up.  
And solder pin sockets to the Hat on the side opposite the  connectors.  
Now the fpga board can be moved between a breadboard or the Hat at will.  

## PARTS
[BOM from DigiKey](https://www.digikey.com/short/r214w4b0)  

If you don't already have a convenient way to power the floppy drive(s):  
[Molex power supply](https://amazon.com/dp/B000MGG6SC)  
[Molex to Berg splitter](https://amazon.com/dp/B0002J1KW6)  
[Molex to Molex splitter](https://amazon.com/dp/B00007JO36)  
[Floppy drive cable](https://amazon.com/dp/B07KDJTMGP)  

## Enclosure

There is a simple snap on cover in the CASE directory. Untested.
