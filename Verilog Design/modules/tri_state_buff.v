`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/01/2018 10:45:31 AM
// Design Name: 
// Module Name: tri_state_buff
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


module tri_state_buff(out, in, switch);
parameter N = 4;
output [N-1:0] out;
input [N-1:0] in;
input switch;
reg [N-1:0] out = 0;

always @(switch)
if (switch == 1'b1) out <= 'bZ;
else out <= in;
endmodule
