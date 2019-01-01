`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/01/2018 11:36:51 PM
// Design Name: 
// Module Name: Control
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


module Control(RegDst, Jump,BranchType, Branch, MemRead,MemtoReg, ALUOp, MemWrite, ALUSrc, RegWrite, opcode, reset);
parameter LW = 6'h23, SW = 6'h2b, BEQ = 6'h4, RTYPE = 6'h0, ADDI = 6'h8, ANDI = 6'hc,
BNE = 6'h5, J = 6'h2, JAL = 6'h3;
output reg  Jump, Branch, MemRead, MemWrite, ALUSrc,RegWrite, BranchType;
output reg [1:0] ALUOp, MemtoReg, RegDst;
input [5:0] opcode;
input reset;

always @(*) begin
if(reset)
{RegDst[1:0],Jump,Branch,BranchType,MemRead,MemtoReg[1:0],MemWrite,ALUSrc,RegWrite,ALUOp[1:0]} <= 13'b000000000000;
else begin
    case(opcode) 
     LW: begin
            {RegDst[1:0],Jump,Branch,BranchType,MemRead,MemtoReg[1:0],MemWrite,ALUSrc,RegWrite,ALUOp[1:0]} <= 13'b0000010101100;
           end
     SW: begin
           {RegDst[1:0],Jump,Branch,BranchType,MemRead,MemtoReg[1:0],MemWrite,ALUSrc,RegWrite,ALUOp[1:0]} <= 13'b0000000011000;
            end
     BEQ: begin
           {RegDst[1:0],Jump,Branch,BranchType,MemRead,MemtoReg[1:0],MemWrite,ALUSrc,RegWrite,ALUOp[1:0]} <= 13'b0001000000001;
            end
     RTYPE: begin
           {RegDst[1:0],Jump,Branch,BranchType,MemRead,MemtoReg[1:0],MemWrite,ALUSrc,RegWrite,ALUOp[1:0]} <= 13'b0100000000110;
            end
     ADDI: begin
            {RegDst[1:0],Jump,Branch,BranchType,MemRead,MemtoReg[1:0],MemWrite,ALUSrc,RegWrite,ALUOp[1:0]} <= 13'b0000000001100;
            end
     ANDI: begin
            {RegDst[1:0],Jump,Branch,BranchType,MemRead,MemtoReg[1:0],MemWrite,ALUSrc,RegWrite,ALUOp[1:0]} <= 13'b0000000001111;
            end  
     BNE: begin
           {RegDst[1:0],Jump,Branch,BranchType,MemRead,MemtoReg[1:0],MemWrite,ALUSrc,RegWrite,ALUOp[1:0]} <= 13'b0001100000001;
            end
     J: begin
           {RegDst[1:0],Jump,Branch,BranchType,MemRead,MemtoReg[1:0],MemWrite,ALUSrc,RegWrite,ALUOp[1:0]} <= 13'b0010000000011;
            end    
      JAL: begin
               {RegDst[1:0],Jump,Branch,BranchType,MemRead,MemtoReg[1:0],MemWrite,ALUSrc,RegWrite,ALUOp[1:0]} <= 13'b1010001000111;
         end    
      default: begin
      {RegDst[1:0],Jump,Branch,BranchType,MemRead,MemtoReg[1:0],MemWrite,ALUSrc,RegWrite,ALUOp[1:0]} <= 13'b0000000000000;
      end                                                                                                                              
    endcase
end
end
endmodule
