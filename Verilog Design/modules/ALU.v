`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Delmwin Baeka
// Module Name: ALU
//////////////////////////////////////////////////////////////////////////////////


module ALU(Result, Zero, ALUControl, A, B);
input [31:0] A, B;
input [3:0] ALUControl;
output reg [31:0] Result;
output Zero;

assign Zero = (Result==0);
always @(ALUControl, A, B) begin
    case (ALUControl)
        0: Result <= A & B;
        1: Result <= A | B;
        2: Result <= A + B;
        6: Result <= A - B;
        7: Result <= A < B ? 31'd1: 31'd0;
        12: Result <= ~(A|B);
        default: Result <= 0;
    endcase
end
endmodule
