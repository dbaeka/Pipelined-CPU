`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/01/2018 08:02:29 PM
// Design Name: 
// Module Name: ALUControl
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


module ALUControl(Control, ALUOp, FunctCode);
input [1:0] ALUOp;
input [5:0] FunctCode;
output reg[3:0] Control;
wire [7:0] alufunc;
assign alufunc = {ALUOp, FunctCode};
always @(alufunc) begin
    casez (alufunc) 
        8'b00??????: Control <= 2;
        8'b01??????: Control <= 6;
        8'b11??????: Control <= 0;
        8'b10100000: Control <= 2;
        8'b10100010: Control <= 6;
        8'b10100100: Control <= 0;
        8'b10100101: Control <= 1;
        8'b10101010: Control <= 7;
    endcase
end
endmodule
