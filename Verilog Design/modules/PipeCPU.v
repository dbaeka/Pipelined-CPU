`timescale 1ns / 1ps

// Create Date: 11/04/2018 05:32:51 AM
// Module Name: PipeCPU
//////////////////////////////////////////////////////////////////////////////////


module PipeCPU (clock,reset,pcOut,aluResult,inst,r8,r9,r10,r11,r12,r13,r14,r15,r16,r17,r18,r19,r20,r21,r22,r23,r24,r25);
input clock, reset;
output [31:0] pcOut, aluResult, inst;
output [31:0] r8,r9,r10,r11,r12,r13,r14,r15,r16,r17,
r18,r19,r20,r21,r22,r23,r24,r25;

wire [31:0] pc, ID_pc4, ID_instr, EX_pc4,WB_pc4, EX_rs, EX_rt, EX_immExt, EX_instr,MEM_pc4,
FBout, MEM_ALUResult, MEM_FBout, WB_ALUResult,WB_DMOut, Instr,RSout,RTout,WB_RDdata, SEOut,SL2Out,ALUResult, ALU_B, ALU_A, MEM_DMOut, MEM_FAout,jumpAddress,jShift;
wire signed[31:0] pcNext, pc4,BranchAddr;
wire EX_RegWrite,IF_ID_flush, PCWrite,IF_ID_WriteEn, WB_RegWrite,RegWrite, Jump, BranchType,
Branch, MemRead, MemWrite, ALUSrc, PCorBranch, Zero, jr, EX_MemWrite, EX_MemRead,EX_ALUSrc, MEM_RegWrite, MEM_MemWrite, MEM_MemRead,btypeOut,
stall_flush, Muxed_Jump,Muxed_BranchType, Muxed_Branch, Muxed_MemRead,  Muxed_MemWrite, Muxed_ALUSrc, Muxed_RegWrite,Muxed_jr;
wire [4:0] WB_WriteRegister,MEM_WriteRegister, RSin, RTin, EX_WriteRegister;
wire [3:0] ALUIn, EX_ALUIn;
wire [1:0] ALUOp, EX_ALUOp, ForwardA_EX, ForwardB_EX,  ForwardA_ID,ForwardB_ID, Muxed_ALUOp, RegDest,EX_RegDest,Muxed_RegDest,MemtoReg,
EX_MemtoReg,MEM_MemtoReg,Muxed_MemtoReg,WB_MemtoReg;
wire [31:0] dummy31,ZeroTestB,ZeroTestA,MEM_RDdata,RSFlushedOut,RTFlushedOut;
wire dummy1,ID_flush,Flush;
///////////////////////////////////////////////////
///////////////////////IF//////////////////////
//PC Update
simplereg PCReg (pc, pcNext, PCWrite, reset, clock);

//PC + 4
assign pc4 = pc + 32'd4;

//PC to Instruction Memory
IM instructionMemory (Instr, pc);

///////////////////////IF/ID///////////////////////

assign IF_ID_flush = (Muxed_jr || PCorBranch || Muxed_Jump);
assign Flush = ID_flush || reset;

simplereg IF_ID_pc4(ID_pc4, pc4, IF_ID_WriteEn, Flush, clock);
simplereg IF_ID_Instr(ID_instr, Instr, IF_ID_WriteEn, Flush, clock);
simplereg #(1) IF_ID_flushReg(ID_flush, IF_ID_flush, IF_ID_WriteEn, Flush, clock);
///////////////////////////////////////////////////
///////////////////////ID///////////////////////
//26 bit to 28 bit for Jump  //TODO:
ShiftLeft SL1 (jShift, {{6{ID_instr[25]}},ID_instr[25:0]});

//Assign jump address
assign jumpAddress = {ID_pc4[31:28],jShift};

//Control signals unit
Control ControlUnit (RegDest, Jump,BranchType, Branch, MemRead,MemtoReg, ALUOp, MemWrite, ALUSrc, RegWrite, ID_instr[31:26], reset);

//Forwarding unit in the ID stage
ForwardingUnit_ID FU_ID(ForwardA_ID, ForwardB_ID, Branch, MEM_RegWrite, RSin, RTin, MEM_WriteRegister,EX_WriteRegister, EX_RegWrite);

//Mux to select from forwarded data into Zero test ALU
Mux3_1  BranchCompSrcA (ForwardA_ID, RSout, ALUResult ,MEM_RDdata, ZeroTestA);
Mux3_1  BranchCompSrcB (ForwardB_ID, RTout, ALUResult ,MEM_RDdata, ZeroTestB);

//rs and rt into Register
assign RSin = ID_instr[25:21];
assign RTin = ID_instr[20:16];

//32 by 32 Register file
Register Rfile(RSout,RTout, WB_RDdata, RSin, RTin, WB_WriteRegister, WB_RegWrite, clock,reset,
  r8,r9,r10,r11,r12,r13,r14,r15,r16,r17,
r18,r19,r20,r21,r22,r23,r24,r25);

//Extend immediate value from 16 to 32 bit
SignExt SE (SEOut, ID_instr[15:0]);

//Test for beq and bne
ALU ZeroTest (dummy31, Zero, ALUIn, ZeroTestA, ZeroTestB);

//Control for jr instruction
JRControl jrControl (jr, ALUOp, ID_instr[5:0]);

//ALU Control unit
ALUControl ALUCUnit (ALUIn,ALUOp, ID_instr[5:0]);

//Mux to select control signals or zeros
Mux2_1 #(14) Nop_Control (stall_flush, {RegDest, Jump,BranchType, Branch, MemRead,MemtoReg, ALUOp, MemWrite, ALUSrc, RegWrite,jr}, 14'd0,
{Muxed_RegDest, Muxed_Jump,Muxed_BranchType,
Muxed_Branch, Muxed_MemRead,Muxed_MemtoReg,Muxed_ALUOp , Muxed_MemWrite, Muxed_ALUSrc, Muxed_RegWrite,Muxed_jr});

///////////////////////ID/EX///////////////////////
simplereg ID_EX_pc4(EX_pc4, ID_pc4, 1'b1, reset, clock);
simplereg ID_EX_rs(EX_rs, RSFlushedOut, 1'b1, reset, clock);
simplereg ID_EX_rt(EX_rt, RTFlushedOut, 1'b1, reset, clock);
simplereg #(4)ID_EX_ALUIn(EX_ALUIn, ALUIn, 1'b1, reset, clock);
simplereg ID_EX_immExt(EX_immExt, SEOut, 1'b1, reset, clock);
simplereg ID_EX_instr(EX_instr, ID_instr, 1'b1, reset, clock);
WBControlReg ID_EX_wb (EX_MemtoReg, EX_RegWrite, Muxed_MemtoReg, Muxed_RegWrite, 1'b1, reset, clock);
MEMControlReg ID_EX_mem (EX_MemWrite, EX_MemRead, Muxed_MemWrite, Muxed_MemRead, 1'b1, reset, clock);
EXControlReg ID_EX_ex (EX_ALUSrc, EX_RegDest, EX_ALUOp, Muxed_ALUSrc, Muxed_RegDest, Muxed_ALUOp, 1'b1, reset, clock);

///////////////////////////////////////////////////
///////////////////////EX//////////////////////
//Mux for rt(0) or rs(1)
Mux3_1 #(5) Rdest (EX_RegDest,EX_instr[20:16],EX_instr[15:11],5'd31,EX_WriteRegister);

//Forwarding Unit in EX stage
ForwardingUnit_EX FU_EX (ForwardA_EX, ForwardB_EX,EX_instr[25:21], EX_instr[20:16], MEM_WriteRegister, WB_WriteRegister, MEM_RegWrite, WB_RegWrite);

//Mux to select forwarded data in EX stage
Mux3_1 ALUsrcA (ForwardA_EX,EX_rs,WB_RDdata, MEM_ALUResult, ALU_A);
Mux3_1 FBSource (ForwardB_EX,EX_rt,WB_RDdata, MEM_ALUResult, FBout);

//Mux for forwarded B) or immediate(1) into ALU second input
Mux2_1 ALUSrcB (EX_ALUSrc,FBout,EX_immExt,ALU_B);
//Central ALU
ALU MainALU (ALUResult, dummy1, EX_ALUIn, ALU_A, ALU_B);

//Multiply immediate by 4 for relative address
ShiftLeft SL2 (SL2Out, SEOut);

//Add PC + 4 and Relative address
assign BranchAddr = ID_pc4 + SL2Out;



///////////////////////EX/MEM///////////////////////
simplereg EX_MEM_pc4(MEM_pc4, EX_pc4, 1'b1, reset, clock);
simplereg EX_MEM_ALUResult(MEM_ALUResult, ALUResult, 1'b1, reset, clock);
simplereg EX_MEM_ALUb(MEM_FBout, FBout, 1'b1, reset, clock);
simplereg EX_MEM_ALUa(MEM_FAout, ALU_A, 1'b1, reset, clock);
simplereg #(5) EX_MEM_WriteRegister(MEM_WriteRegister, EX_WriteRegister, 1'b1, reset, clock);
WBControlReg EX_MEM_wb (MEM_MemtoReg, MEM_RegWrite, EX_MemtoReg, EX_RegWrite, 1'b1, reset, clock);
MEMControlReg EX_MEM_mem (MEM_MemWrite, MEM_MemRead,EX_MemWrite, EX_MemRead, 1'b1, reset, clock);

///////////////////////////////////////////////////
///////////////////////MEM////////////////////////

//Data Memory
Memory DM(MEM_DMOut, MEM_FBout, MEM_ALUResult, MEM_MemWrite, MEM_MemRead,clock, reset);


///////////////////////MEM/WB///////////////////////
simplereg MEM_WB_ALUResult(WB_ALUResult, MEM_ALUResult, 1'b1, reset, clock);
simplereg MEM_WB_pc4(WB_pc4, MEM_pc4, 1'b1, reset, clock);
simplereg MEM_WB_DMOut(WB_DMOut, MEM_DMOut, 1'b1, reset, clock);
simplereg #(5) MEM_WB_WriteRegister(WB_WriteRegister, MEM_WriteRegister, 1'b1, reset, clock);
WBControlReg MEM_WB_wb (WB_MemtoReg, WB_RegWrite, MEM_MemtoReg, MEM_RegWrite, 1'b1, reset, clock);



///////////////////////////////////////////////////
///////////////////////WB/////////////////////////
//Mux for ALU result or memory out
Mux3_1 WBMtoR (WB_MemtoReg,WB_ALUResult,WB_DMOut,WB_pc4,WB_RDdata);
Mux3_1 MEMMtoR (MEM_MemtoReg,MEM_ALUResult,MEM_DMOut,MEM_pc4,MEM_RDdata);




//Hazard Detection for EX stage
HazardDetUnit1 HDU1 (PCWrite, IF_ID_WriteEn, stall_flush, ID_instr, EX_MemRead, EX_instr[20:16]);

//Hazard Detectopm for slow WB, so forward to EX stage that might need it early
HazardDetUnit2 HDU2 (WB_RegWrite, RSin, RTin, WB_WriteRegister, RSout,RTout, WB_RDdata, RSFlushedOut,RTFlushedOut);
//Mux to select beq or bne
Mux2_1 #(1) BeqOrBne (Muxed_BranchType, Zero, ~Zero, btypeOut);

//AND to produce branch signal if branch and Zero
and (PCorBranch, Muxed_Branch, btypeOut);


//PC Source Mux (4x1)
PCSrc_Mux PCSrc (pcNext, pc4,BranchAddr,jumpAddress, RSout,PCorBranch,Jump,jr);

assign pcOut = pc ;//<< 2;
assign aluResult = MEM_ALUResult;

assign inst = Instr;
endmodule
