`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 11/01/2018 11:34:30 PM
// Design Name:
// Module Name: Memory
//////////////////////////////////////////////////////////////////////////////////


module IM(R_data, R_addr);
localparam width = 32;
localparam addr_width = 32;
localparam number = 2**(addr_width - 26);

output wire [31:0] R_data;
input [addr_width-1:0]  R_addr;

reg [width-1:0] memory [0:number-1];

initial begin
$readmemb("demo.mem", memory);
//$readmemh("bubblesort.mem", memory);

end
assign R_data =  memory[R_addr >> 2];
endmodule
