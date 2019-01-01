`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/02/2018 09:26:51 AM
// Design Name: 
// Module Name: JRControl
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


module JRControl(Control, ALUOp, FunctCode);
input [1:0] ALUOp;
input [5:0] FunctCode;
output Control;

assign Control = ({ALUOp,FunctCode} == 8'b10001000) ? 1'b1 : 1'b0;
endmodule
