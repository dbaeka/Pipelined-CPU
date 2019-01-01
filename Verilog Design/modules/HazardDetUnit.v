`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 11/04/2018 07:16:11 PM
// Design Name:
// Module Name: HazardDetUnit
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


module HazardDetUnit1(PCWrite, IF_ID_WriteEn, stall_flush, IF_ID_Instr, ID_EX_MemRead, ID_EX_rt);
output PCWrite, IF_ID_WriteEn, stall_flush;
input [31:0] IF_ID_Instr;
input [4:0] ID_EX_rt;
input ID_EX_MemRead;
wire cond, instrMatch, rtMatch;

 assign rtMatch = ((ID_EX_rt == IF_ID_Instr[20:16]) && instrMatch);
 assign instrMatch = (IF_ID_Instr[31:26] == 6'h0 || IF_ID_Instr[31:26] == 6'h2 || IF_ID_Instr[31:26] == 6'h3 || IF_ID_Instr[31:26] == 6'h4 || IF_ID_Instr[31:26] == 6'h5);
 assign cond = (ID_EX_MemRead) && ((ID_EX_rt == IF_ID_Instr[25:21])  || rtMatch);




assign PCWrite = cond ? 1'b0 : 1'b1;
assign IF_ID_WriteEn = cond ? 1'b0 : 1'b1;
assign stall_flush= cond ? 1'b1 : 1'b0;
endmodule

//Hazard detection to account for delay in WB especially after flushing which makes it impossible for other detectors to work with previous code
//without stalling
//Fix is to push the data from previous WB twice when hazard detected, kind of like forwarding
module HazardDetUnit2 (MEM_WB_RegWrite, IF_ID_rs, IF_ID_rt, MEM_WB_rd,RSout,RTout, WB_Rdata, RSFlushedOut,RTFlushedOut);
    input MEM_WB_RegWrite;
    input [31:0] WB_Rdata, RSout, RTout;
    input [4:0] IF_ID_rs, IF_ID_rt,MEM_WB_rd;
    output[31:0]  RSFlushedOut,RTFlushedOut;
    
    assign RSFlushedOut = ((MEM_WB_RegWrite && MEM_WB_rd != 5'd0) && ((MEM_WB_rd == IF_ID_rs ))) ? WB_Rdata : RSout; 
    assign RTFlushedOut = ((MEM_WB_RegWrite && MEM_WB_rd != 5'd0) && ((MEM_WB_rd == IF_ID_rt))) ? WB_Rdata : RTout; 
endmodule

