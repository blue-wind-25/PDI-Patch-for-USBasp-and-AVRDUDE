# PDI Patch for USBasp and AVRDUDE

The original PDI patches for USBasp and AVRDUDE are old and contain bugs.

**This repository contains the fixed patches.**

---
---

### Links to Web Pages Containing Informations about the Original Source Code and Patches

Playing with AtXmega16e5 breakout - Converting USBASP to support PDI<br>
https://morf.lv/playing-with-atxmega16e5-breakout<br>

ATxmega programmer for $0.50<br>
https://szulat.blogspot.com/2012/08/atxmega-programmer-for-050.html<br>
    USBASP Firmware supporting PDI<br>
        http://www.fischl.de/usbasp/usbasp.2011-05-28.tar.gz<br>
        http://sz.toyspring.com/usbasp-pdi-usbaspfirmware-20120816.diff<br>
    AVRDUDE supporting USBASP with PDI (5.11svn)<br>
        http://sz.toyspring.com/usbasp-pdi-avrdude2091-20120816.diff<br>
        svn co svn://svn.sv.gnu.org/avrdude/trunk -r 1092<br>

Как прошить XMEGA при помощи USBASP программатора<br>
How to flash XMEGA using USBASP programmer<br>
https://service4u.narod.ru/html/atxmega_avrdude.html<br>
https://service4u.narod.ru/assets/xmega/usbasp_pdi_atmega8_20120816.hex<br>
https://service4u.narod.ru/assets/xmega/avrdude-r1092-usbasp-pdi.zip<br>

USBASP-PDI<br>
Modified USBASP to work as a PDI Programmer<br>
https://github.com/nieldk/USBASP-PDI<br>
https://github.com/nieldk/USBASP-PDI/tree/master/bin/firmware<br>

AVRDUDE 6.3 for USBASP-PDI<br>
https://github.com/nieldk/avrdude<br>

---

It is recommended to use AVRDUDE r1092 (5.11svn) instead of 6.3 because the patched ***avrdude.conf*** for version 6.3 contains a bug for the \'.xmega\' common part definition (missing ***chip_erase_delay = 40000***).

It is possible to use AVRDUDE 6.3 with the ***avrdude.conf*** from r1092 (5.11svn), or, edit the file and add the missing ***chip_erase_delay = 40000*** to the ***.xmega*** common part definition; without the chip erase delay, programming will always fail.

---

There is also a bug in the USBasp patch that will cause programming using TPI to always fail. To fix it, after applying the patch, edit \***firmware/main.c\*** and add the following lines:
```C
    } else if (data[1] == USBASP_FUNC_TPI_WRITEBLOCK) {
        prog_address = (data[3] << 8) | data[2];
        prog_nbytes = (data[7] << 8) | data[6];
        prog_state = PROG_STATE_TPI_WRITE;
        len = 0xff; /* multiple out */
```
before the line that contains:
```C
        } else if (data[1] == USBASP_FUNC_GETCAPABILITIES) {
```
(the patch removed those lines).
