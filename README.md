# 32-BIT PIPELINED MIPS PROCESSOR
## BEFORE YOU BEGIN
Welcome to this repository! In this repository is a uniquely designed 32 bit MIPS pipelined processor. The base design is based on the Patterson design but  with modified control to ensure faster and less stalls, thus **improving the Clocks Per Instruction (CPI)**.  Only a few instruction sets were implemented, enough to run any sorting algorithm you commonly know. The bubble sort MIPS example is attached in [examples/bubblesort.mem](Examples/bubblesort.mem). The design language is **Verilog**, and is both behavioral using the test bench attached and synthesisable on an FPGA. The uploaded code was tested on *Xilinx’s Basys 3 Board*. 
- - - -
The instructions supported are:
* The memory-reference instructions *load word (lw)* and *store word (saw)*
*  The arithmetic-logical instructions *add, addi, sub, and, andi, or*, and *slt*
* The jumping instructions *branch equal (beq), branch not equal (bne), jump register (jr), jump and link (jal)*, and *jump (j)*

## RTL DESIGN
![](Pipeline%20CPU%20RTL.png)


