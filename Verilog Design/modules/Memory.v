`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 11/01/2018 11:34:30 PM
// Design Name:
// Module Name: Memory
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


module Memory(R_data, W_data, Addr, W_en,R_en, clock, reset);
parameter width = 32;
parameter addr_width = 32;
parameter number = 63;//2**(addr_width - 10);

output wire [width-1:0] R_data;
input [width-1:0] W_data;
input W_en,R_en, clock, reset;
input [addr_width-1:0]  Addr;

reg [width-1:0] memory [number-1:0];

reg[addr_width-1:0] i;
initial begin
 for (i = 0; i < number; i = i+1)
 	memory[i] <= 0;
end

always @(posedge clock or posedge reset) begin
if (reset)
for (i = 0; i < number; i = i+1)
  memory[i] <= 0;
else begin
if (W_en)
    memory[Addr] <= W_data;
end
end

assign R_data = (R_en) ? memory[Addr]: 32'd0;
endmodule
