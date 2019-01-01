`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/01/2018 08:54:59 AM
// Design Name: 
// Module Name: N_bit_counter
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


module N_bit_counter(Q, load, D, reset, clk, CE);
parameter N = 3;
output [N-1:0] Q;
input [N-1:0] D;
input load, reset, clk, CE;

reg [N-1:0] Q;

always @(posedge reset or posedge clk)
if (reset == 1'b1) Q <= 0;
else if (load == 1'b1) Q <= D;
else if (CE == 1'b1) Q <= Q + 1;
else Q <= Q;

endmodule
