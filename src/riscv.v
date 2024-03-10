`timescale 1ns / 1ps
`include "./InstructionMemory/instruction_memory.v"
`include "./ControlUnit/control_unit.v"
`include "./RegisterFile/register_file.v"
`include "./ALU/alu.v"
`include "./ALU/multiplication.v"
`include "./ALU/division.v"
`include "./ALU/inversion.v"
`include "./ALU/addition.v"

module RISCV (
	input Clk,
	output [dv:0] DebugData
);

parameter a = 3;
parameter l = 16;
parameter lv = l - 1;
parameter DebugDataWidth = l * (1 << a);
parameter dv = DebugDataWidth - 1;
parameter p = 0;
parameter op_l = 3;

// Program counter
reg [lv:0] PC;
wire [lv:0] NextPC;
wire [lv:0] ignore_pc_incrementor;
FullAdder #(l) pc_incrementor(
	.X(PC), .Y({{l-2{1'b0}}, 2'b10}),
	.Cin(1'b0),

	.S(NextPC),
	.Cout(ignore_pc_incrementor)
);

always @(posedge Clk) begin
	PC = NextPC;
end

initial PC = 0;

// Instruction memory
wire [lv:0] Instruction;
InstructionMemory #(l) instruction_memory(
	.Address(PC),
	.Instruction(Instruction)
);

// Control unit
wire LoadUpperImmediate;
wire [p:0] ALUOpcode;
wire UseImmediate;
wire UpdateFlags;
ControlUnit #(l, op_l, p) control_unit(
	.Opcode(Instruction[15:13]),

	.LoadUpperImmediate(LoadUpperImmediate),
	.ALUOpcode(ALUOpcode),
	.UseImmediate(UseImmediate),
	.UpdateFlags(UpdateFlags)
);

// Register file
wire [lv:0] OutDataB;
wire [lv:0] OutDataC;
wire [lv:0] OldFlags;
RegisterFile register_file(
	.Clk(Clk),

	.AddrA(Instruction[12:10]),
	.AddrB(Instruction[9:7]),
	.AddrC(Instruction[2:0]),

	.InDataA(
		LoadUpperImmediate ? {6'b0, Instruction[9:0]} : ALUResult
	),
	.InNewFlags(ALUNewFlags),
	.UpdateFlags(UpdateFlags),

	.OutDataB(OutDataB),
	.OutDataC(OutDataC),
	.OutFlags(OldFlags),

	.DebugData(DebugData)
);

// ALU
wire [lv:0] ALUResult;
wire [lv:0] ALUNewFlags;
ALU #(l, p) alu(
	.Operation(ALUOpcode),
	.B(OutDataB),
	.C(UseImmediate ? 
		{{10{Instruction[6]}}, Instruction[5:0]} :  // signed ImmediateExtend
		OutDataC
	),
	.FlagsIn(OldFlags),

	.Res(ALUResult),
	.FlagsOut(ALUNewFlags)
);
	
endmodule //RISCV
