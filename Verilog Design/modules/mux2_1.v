`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Delmwin Baeka
// Module Name: mux2_1
//////////////////////////////////////////////////////////////////////////////////


module Mux2_1(sel,A,B,F);
parameter N = 32;
input sel;
input [N-1:0] A,B;
output [N-1:0] F;
reg [N-1:0] F;
always @(A,B,sel) begin
case (sel)
   1'b0:F<=A;
   1'b1:F<=B;
endcase
end
endmodule

