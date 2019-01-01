`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/18/2018 06:18:47 AM
// Design Name: 
// Module Name: PipeImpl
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


module PipeImpl(clock,clk,reset,selector,cathode, anode,pc);
input clock, reset,clk, pc;
input [4:0] selector;
output [6:0] cathode;
output [3:0] anode;
wire clk_500;
reg [3:0] Q_ones, Q_tens,Q_hun,Q_th;
wire [6:0] ssd_ones, ssd_tens, ssd_hun, ssd_th;
wire [31:0] pcOut, aluResult,inst;
wire [31:0]t0,t1,t2,t3,t4,t5,t6,t7,s0,s1,s2,s3,s4,s5,s6,s7,t8,t9;

PipeCPU P1 (clock,reset,pcOut, aluResult,inst,
  t0,t1,t2,t3,t4,t5,t6,t7,s0,s1,s2,s3,s4,s5,s6,s7,t8,t9);

N_clock_divider #(18, 200000) NCD_500 (clk_500, clk, reset);
ring_counter RC1 (anode, reset, clk_500);


SSD SDTh (Q_th, ssd_th);
SSD SDH (Q_hun, ssd_hun);
SSD SDT (Q_tens, ssd_tens);
SSD SDO (Q_ones, ssd_ones);

tri_state_buff #(7) TSB1 (cathode, ssd_th, anode[0]);
tri_state_buff #(7) TSB2 (cathode, ssd_hun, anode[1]);
tri_state_buff #(7) TSB3 (cathode, ssd_tens, anode[2]);
tri_state_buff #(7) TSB4 (cathode, ssd_ones, anode[3]);

always @(*) begin
if (pc) 
    {Q_th,Q_hun,Q_tens,Q_ones} <= pcOut;
else begin
case (selector) 
    5'd8:  {Q_th,Q_hun,Q_tens,Q_ones} <= t0;
    5'd9:  {Q_th,Q_hun,Q_tens,Q_ones} <= t1;
    5'd10:  {Q_th,Q_hun,Q_tens,Q_ones} <= t2;
    5'd11:  {Q_th,Q_hun,Q_tens,Q_ones} <= t3;
    5'd12:  {Q_th,Q_hun,Q_tens,Q_ones} <= t4;
    5'd13:  {Q_th,Q_hun,Q_tens,Q_ones} <= t5;
    5'd14:  {Q_th,Q_hun,Q_tens,Q_ones} <= t6;
    5'd15:  {Q_th,Q_hun,Q_tens,Q_ones} <= t7;
    5'd16:  {Q_th,Q_hun,Q_tens,Q_ones} <= s0;
    5'd17:  {Q_th,Q_hun,Q_tens,Q_ones} <= s1;
    5'd18:  {Q_th,Q_hun,Q_tens,Q_ones} <= s2;
    5'd19:  {Q_th,Q_hun,Q_tens,Q_ones} <= s3;
    5'd20:  {Q_th,Q_hun,Q_tens,Q_ones} <= s4;
    5'd21:  {Q_th,Q_hun,Q_tens,Q_ones} <= s5;
    5'd22:  {Q_th,Q_hun,Q_tens,Q_ones} <= s6;
    5'd23:  {Q_th,Q_hun,Q_tens,Q_ones} <= s7;
    5'd24:  {Q_th,Q_hun,Q_tens,Q_ones} <= t8;
    5'd25:  {Q_th,Q_hun,Q_tens,Q_ones} <= t9;
    default:  {Q_th,Q_hun,Q_tens,Q_ones} <= 0;
endcase
end
end


endmodule
