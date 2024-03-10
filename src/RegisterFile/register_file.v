`timescale 1ns / 1ps
module RegisterFile (
	input Clk,

	input [2:0] AddrA,
	input [2:0] AddrB,
	input [2:0] AddrC,

	input [15:0] InDataA,
	input [15:0] InNewFlags,
	input UpdateFlags,

	output [15:0] OutDataB,
	output [15:0] OutDataC,
	output [15:0] OutFlags,

	output [16 * 8 - 1:0] DebugData
);

	parameter FlagsAddress = 7;

	reg [15:0] Data [7:0];

	// Setting the initial values of the registers to be zero
	integer j;
	initial begin
		for(j = 0; j < 8; j = j + 1)
			Data[j[2:0]] = 0;
	end

	// Doing reading always
	assign OutDataB = Data[AddrB];
	assign OutDataC = Data[AddrC];
	assign OutFlags = Data[FlagsAddress[2:0]];

	// We are doing writing only on posedge
	always @ (posedge Clk) begin
		// All instructions write to register A, so we always update it
		Data[AddrA] = InDataA;

		// Not always we update the flags, for that reason we write to it only if the UpdateFlags signal is set
		if (UpdateFlags)
			Data[FlagsAddress[2:0]] = InNewFlags;
	end

	// We also always read from the registeres, to display their values in the testbench
	generate
		genvar i;
		for (i = 0; i < 8; i = i + 1) begin
			assign DebugData[i * 16 +: 16] = Data[i[2:0]];
		end
	endgenerate

endmodule