`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Delmwin Baeka
// Module Name: rfile
//////////////////////////////////////////////////////////////////////////////////


module Register(R_data1,R_data2, W_data, R_addr1, R_addr2, W_addr, W_en, clock,reset,
  r8,r9,r10,r11,r12,r13,r14,r15,r16,r17,
  r18,r19,r20,r21,r22,r23,r24,r25);
  parameter width = 32;
  parameter addr_width = 5;
  parameter number = 2**addr_width;

  output [width-1:0] R_data1, R_data2;
  input [width-1:0] W_data;
  input W_en, clock, reset;
  input [addr_width-1:0]  R_addr1,R_addr2,W_addr;
  output [31:0]r8,r9,r10,r11,r12,r13,r14,r15,r16,r17,
  r18,r19,r20,r21,r22,r23,r24,r25;

  reg [width-1:0] memory [number-1:0];

  assign R_data1 = (R_addr1 == 0) ? 32'd0: memory[R_addr1];
  assign R_data2 = (R_addr2 == 0) ? 32'd0: memory[R_addr2];


  assign r8=memory[8];
  assign r9=memory[9];
  assign r10=memory[10];
  assign r11=memory[11];
  assign r12=memory[12];
  assign r13=memory[13];
  assign r14=memory[14];
  assign r15=memory[15];
  assign r16=memory[16];
  assign r17=memory[17];
  assign r18=memory[18];
  assign r19=memory[19];
  assign r20=memory[20];
  assign r21=memory[21];
  assign r22=memory[22];
  assign r23=memory[23];
  assign r24=memory[24];
  assign r25=memory[25];



  reg[addr_width:0] i;
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
  memory[W_addr] <= W_data;
  end
  end

endmodule
