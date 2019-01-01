`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 11/02/2018 07:05:39 AM
// Design Name:
// Module Name: CPUTest
// Project Name:
// Target Devices:
// Tool Versions:
// Description:
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
//////////////////////////////////////////////////////////////////////////////////


module CPUTest;
parameter HALF_CLOCK = 20;
reg clock, reset;
wire [31:0] pcOut, aluResult,inst;
wire [31:0]t0,t1,t2,t3,t4,t5,t6,t7,s0,s1,s2,s3,s4,s5,s6,s7,t8,t9;

//SCycleCPU S1 (clock,reset,pcOut, aluResult,inst, t0,t1,t2,t3,t4,t5,t6,t7,s0,s1,s2,s3,s4,s5,s6,s7,t8,t9);

PipeCPU P1 (clock,reset,pcOut, aluResult,inst,t0,t1,t2,t3,t4,t5,t6,t7,s0,s1,s2,s3,s4,s5,s6,s7,t8,t9);
initial begin
$display("==============================================================");
#0 reset = 1; clock = 0;
#6 reset = 0;
#1200 $display("==============================================================");
$finish;
end

initial
 begin
    $dumpfile("CPUTest.vcd");
    $dumpvars(0,CPUTest);
 end

always #HALF_CLOCK clock = ~clock;

always @(clock) begin
   printResult();
end

task printResult;
    begin
    $display("Time: %t, CLK = %d, PC = 0x%h", $time,clock, pcOut);
    $display("[$s0] = 0x%h, [$s1] = 0x%h, [$s2] = 0x%h", s0,s1,s2);
    $display("[$s3] = 0x%h, [$s4] = 0x%h, [$s5] = 0x%h", s3,s4,s5);
    $display("[$s6] = 0x%h, [$s7] = 0x%h, [$t0] = 0x%h", s6,s7,t0);
    $display("[$t1] = 0x%h, [$t2] = 0x%h, [$t3] = 0x%h", t1,t2,t3);
    $display("[$t4] = 0x%h, [$t5] = 0x%h, [$t6] = 0x%h", t4,t5,t6);
    $display("[$t7] = 0x%h, [$t8] = 0x%h, [$t9] = 0x%h", t7,t8,t9);
    end
endtask
endmodule
