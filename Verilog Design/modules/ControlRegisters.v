`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/04/2018 11:38:26 PM
// Design Name: 
// Module Name: ControlRegisters
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments: Control pipeline registers
// 
//////////////////////////////////////////////////////////////////////////////////


module WBControlReg(WB_MemtoReg, WB_RegWrite, MemtoReg, RegWrite, W_en, reset, clock);
input W_en, reset, clock, RegWrite;
input [1:0] MemtoReg;
output  WB_RegWrite;
output [1:0] WB_MemtoReg;
reg [2:0] mem;

assign WB_MemtoReg = {mem[2],mem[1]};
assign WB_RegWrite = mem[0];
always @(posedge clock or posedge reset) begin
if (reset)
    mem <= 2'd0;
else begin
    if(W_en)
       mem <= {MemtoReg, RegWrite};
end
end
endmodule

module MEMControlReg(MEM_MemWrite, MEM_MemRead,  MemWrite, MemRead, W_en, reset, clock);
input W_en, reset, clock,MemWrite, MemRead;
output MEM_MemWrite, MEM_MemRead;
reg [1:0] mem;

assign MEM_MemWrite = mem[1];
assign MEM_MemRead = mem[0];

always @(posedge clock or posedge reset) begin
if (reset)
    mem <= 2'd0;
else begin
    if(W_en)
       mem <= {MemWrite, MemRead};
end
end
endmodule


module EXControlReg(EX_ALUSrc, EX_RegDest, EX_ALUOp,ALUSrc, RegDest, ALUOp, W_en, reset, clock);
input W_en, reset, clock,ALUSrc;
input [1:0] ALUOp,RegDest;
output EX_ALUSrc;
output [1:0] EX_ALUOp,EX_RegDest;
reg [4:0] mem;

assign EX_ALUSrc = mem[4];
assign EX_RegDest = {mem[3],mem[2]};
assign EX_ALUOp = {mem[1], mem[0]};

always @(posedge clock or posedge reset) begin
if (reset)
    mem <= 5'd0;
else begin
    if(W_en)
       mem <= {ALUSrc, RegDest[1:0], ALUOp[1:0]};
end
end
endmodule