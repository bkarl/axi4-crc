# CRC32-Generator for AXI4
This project contains a CRC-32 generator for AXI4 busses with a data width of 32 bits. It has an AXI4-Lite interface to read the calculated CRC and to control the core.
The backend used for the CRC calculation was generated automatically by [this website of the company EASICS](https://www.easics.com/webtools/crctool).
The generator polynom used is x^32 + x^26 + x^23 + x^22 + x^16 + x^12 + x^11 + x^10 + x^8 + x^7 + x^5 + x^4 + x^2 + x^1 + 1 (CRC-32).
## Hardware Integration
The block can be used in Xilinx Vivado block designs. The *packaged_ip* directory contains an *axi4-crc* folder which can be pasted into the Vivado ip repository.  It was packaged using Vivado 2019.1.
The AXI4 interface has the monitor property with all signals beeing declared as inputs so it can be attached to any existing AXI4 interface with a data width of 32 bits without any need to split up connections.

![IP in blockdesign](img/crc_in_blockdesign.PNG?raw=true "IP in blockdesign")

## Software Integration
The core has two registers which can be read using AXI4-Lite from a soft- or hardware processor.

| Address | Description | Default Value |
| ------ | ------ | ------ |
| 0x0000 | Generated CRC-32 | 0 |
| 0x0004 | Core control (write a 1 to reset the core and start a new calculation - this bit does not reset itself!) | 0 |
| 0x0008 | Number of valid word transactions seen on the bus  | 0 |
### Example
The following example reads a file from the flash attached to the FPGA and reads back the generated CRC and number of words afterwards.
```C
read_flash(buffer, FILE_SIZE, FILE_ADDRESS); //read FILE_SIZE bytes from FLASH_ADDRESS to buffer
uint32_t crc = Xil_In32(XPAR_AXI4_CRC_0_BASEADDR); //read the generated CRC
uint32_t words_seen = Xil_In32(XPAR_AXI4_CRC_0_BASEADDR+8); //check the number of words (4 bytes) the CRC generator has seen 
//reset the generation logic so the core is ready for the next calculation tasks
Xil_Out32(XPAR_AXI4_CRC_0_BASEADDR+4,1);
Xil_Out32(XPAR_AXI4_CRC_0_BASEADDR+4,0);
```
## Remarks
Because the bus width is fixed to 32 bit the data transfers have to be size aligned to 4 bytes and padded with zeros in case they are unaligned.
To test the core in hardware I flashed a PDF file to a Digilent Arty board with an original size of 2054591 bytes. To meet the alignment criterium i needed to append 1 byte to the file before flashing.
![IP in blockdesign](img/crc_test.PNG?raw=true "Title")

## Packaging/Retargeting
When packaging the core (Tools->Create and package new IP) make sure to select the interface mode *monitor* in the properties for the *s_axi* interface in the *Ports and Interfaces* tab.
![IP in blockdesign](img/interface_mode.PNG?raw=true "Title")

## Ressource utilization
The module uses 256 LUTs and 397 FFs in 7Series technology.