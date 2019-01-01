`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/01/2018 10:25:24 AM
// Design Name: 
// Module Name: ring_counter
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


module ring_counter(P, reset, clk);
output [3:0] P;
input reset, clk;

wire [1:0] Q;
wire D;
reg [3:0] P;

N_bit_counter #(2) counter (Q, 2'b00, D, reset, clk, 1'b1);

and (D, Q[0], Q[1]);

always @(posedge reset or posedge clk)
if (reset == 1'b1) P = 0;
else begin
case (Q)
2'b00: P = 4'b1110;
2'b01: P = 4'b1101;
2'b10: P = 4'b1011;
2'b11: P = 4'b0111;
default: P = 0;
endcase
end
endmodule
