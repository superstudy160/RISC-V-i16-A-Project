`timescale 1ns / 1ps
module RegisterFile #(parameter l=16, parameter a=3) (
	input Clk,

	input [av:0] AddrA,
	input [av:0] AddrB,
	input [av:0] AddrC,

	input [lv:0] InDataA,
	input [lv:0] InNewFlags,
	input UpdateFlags,

	output [lv:0] OutDataB,
	output [lv:0] OutDataC,
	output [lv:0] OutFlags,

	output [dv:0] DebugData
);

	parameter av = a - 1; // Maximum address bit index
  	parameter r = 1 << a; // Number of registers
  	parameter rv = r - 1; // Maximum register index
  	parameter lv = l - 1; // Maximum register bit index
	parameter DebugDataWidth = l * r;
	parameter dv = DebugDataWidth - 1; // Maximum debug data index

	parameter FlagsRegisterAddr = rv;

	reg [lv:0] Data [rv:0];

	integer j;
	initial begin
		for(j = 0; j < r; j = j + 1)
			Data[j[av:0]] = 0;
	end

	assign OutDataB = Data[AddrB];
	assign OutDataC = Data[AddrC];
	assign OutFlags = Data[FlagsRegisterAddr[av:0]];

	always @ (posedge Clk) begin
		Data[AddrA] <= InDataA;
		if (UpdateFlags)
			Data[FlagsRegisterAddr[av:0]] <= InNewFlags;
	end

	generate
		genvar i;
		for (i = 0; i < r; i = i + 1) begin
			assign DebugData[i * l +: l] = Data[i[av:0]];
		end
	endgenerate

endmodule