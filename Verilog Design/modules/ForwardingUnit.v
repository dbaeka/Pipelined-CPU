`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/04/2018 06:41:01 PM
// Design Name: 
// Module Name: ForwardingUnit
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



module ForwardingUnit_ID(ForwardA, ForwardB, Branch, EX_MEM_RegWrite, IF_ID_rs, IF_ID_rt, EX_MEM_rd, ID_EX_rd,ID_EX_RegWrite);
input Branch, EX_MEM_RegWrite,ID_EX_RegWrite;
input [4:0] IF_ID_rs, IF_ID_rt, EX_MEM_rd,ID_EX_rd;
output [1:0] ForwardA, ForwardB;
    
reg [1:0] conditionA, conditionB;
    
always @(*) begin
conditionA = 2'b00;
conditionB = 2'b00;
        
if (Branch) begin
    if ((EX_MEM_RegWrite && EX_MEM_rd != 5'd0) && (EX_MEM_rd == IF_ID_rs)) //EX Hazard
		conditionA = 2'b10;
	else if ((ID_EX_RegWrite && ID_EX_rd != 5'd0) && (ID_EX_rd == IF_ID_rs))  //ID Hazard
		conditionA = 2'b01;
	
	if ((EX_MEM_RegWrite && EX_MEM_rd != 5'd0) && (EX_MEM_rd == IF_ID_rt)) //EX Hazard
		conditionB = 2'b10;
	else if ((ID_EX_RegWrite && ID_EX_rd != 5'd0) && (ID_EX_rd == IF_ID_rt)) //ID Hazard
		conditionB = 2'b01;   

end
end

assign ForwardA = conditionA;
assign ForwardB = conditionB;

endmodule


module ForwardingUnit_EX(ForwardA, ForwardB,ID_EX_rs, ID_EX_rt, EX_MEM_rd, MEM_WB_rd,EX_MEM_RegWrite, MEM_WB_RegWrite);
input EX_MEM_RegWrite, MEM_WB_RegWrite;
input [4:0] ID_EX_rs, ID_EX_rt, EX_MEM_rd, MEM_WB_rd;
output [1:0] ForwardA, ForwardB;

reg[1:0] conditionA, conditionB;

always @(*) begin
conditionA = 2'b00;
conditionB = 2'b00;

if ((EX_MEM_RegWrite && EX_MEM_rd != 5'd0) && (EX_MEM_rd == ID_EX_rs)) //EX Hazard
	conditionA = 2'b10;
else if ((MEM_WB_RegWrite && MEM_WB_rd != 5'd0) && ((MEM_WB_rd == ID_EX_rs)))  //MEM Hazard
	conditionA = 2'b01;
	
if ((EX_MEM_RegWrite && EX_MEM_rd != 5'd0) && (EX_MEM_rd == ID_EX_rt)) //EX Hazard
	conditionB = 2'b10;
else if ((MEM_WB_RegWrite && MEM_WB_rd != 5'd0) && (MEM_WB_rd == ID_EX_rt)) //MEM Hazard
	conditionB = 2'b01;
end

assign ForwardA = conditionA;
assign ForwardB = conditionB;
endmodule
