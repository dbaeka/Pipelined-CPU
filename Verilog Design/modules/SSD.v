`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/01/2018 11:09:36 AM
// Design Name: 
// Module Name: SSD
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

module SSD(
    input [3:0] bit_input,
    output reg [6:0] ssd
    );
      
    always @(*)
    begin
        case(bit_input)
        4'b0000: ssd = 7'b0000001; // "0"     
        4'b0001: ssd = 7'b1001111; // "1" 
        4'b0010: ssd = 7'b0010010; // "2" 
        4'b0011: ssd = 7'b0000110; // "3" 
        4'b0100: ssd = 7'b1001100; // "4" 
        4'b0101: ssd = 7'b0100100; // "5" 
        4'b0110: ssd = 7'b0100000; // "6" 
        4'b0111: ssd = 7'b0001111; // "7" 
        4'b1000: ssd = 7'b0000000; // "8"     
        4'b1001: ssd = 7'b0000100; // "9" 
        4'b1010: ssd = 7'b0001000; // "A"
        4'b1011: ssd = 7'b1100000; // "B"
        4'b1100: ssd = 7'b0110001; // "C"
        4'b1101: ssd = 7'b1000010; // "D"
        4'b1110: ssd = 7'b0110000; // "E"
        4'b1111: ssd = 7'b0111000; // "F"
        default: ssd = 7'b0000001; // "0"
        endcase
    end
 endmodule