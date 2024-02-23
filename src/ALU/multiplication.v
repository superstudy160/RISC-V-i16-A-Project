`include "./addition.v"

// Suggestions for this stuff:
// https://en.wikipedia.org/wiki/Booth%27s_multiplication_algorithm
// http://vlsiip.com/download/booth.pdf
// The comparisson of different hardware multipliers:
// https://en.wikipedia.org/wiki/Binary_multiplier#Hardware_implementation
// Fast multiplication:
// https://watermark.silverchair.com/020085_1_online.pdfhttps://pubs.aip.org/aip/acp/article-pdf/doi/10.1063/1.5080898/14172964/020085_1_online.pdf
// https://ietresearch.onlinelibrary.wiley.com/doi/full/10.1049/iet-cds.2019.0537

module ControlledAdder(
	input A,
	input B,
	input Cin,
	input Selection, // 1 for addition, 0 to skip
	output Sum,
	output Cout
);

wire b_buff;
assign b_buff = Selection & B;

Adder adder(
	.A(A), .B(b_buff), .Cin(Cin),
	.S(Sum), .Cout(Cout)
);
	
endmodule //ControlledAdder


module ControlledFullAdder #(parameter l=16) (
	input [lv:0] A,
	input [lv:0] B,
	input [lv:0] Cin,
	input Selection, // 1 for addition, 0 to skip
	output [lv:0] Sum,
	output [lv:0] Cout
);

parameter lv = l-1;

generate
genvar i;

for (i = 0; i < l; i = i + 1)
	ControlledAdder controlled_adder(
		.A(A[i]), .B(B[i]), .Cin(Cin[i]),
		.Selection(Selection), .Sum(Sum[i]),
		.Cout(Cout[i]) // This carry would go to the next ControlledFullAdder
	);

endgenerate
endmodule //ControlledFullAdder



// Source:
// https://coertvonk.com/hw/building-math-circuits/faster-parameterized-multiplier-in-verilog-30774
// Furher improvement, if there is time:
// https://coertvonk.com/hw/building-math-circuits/faster-parameterized-multiplier-in-verilog-30774#:~:text=The%20Wallace%20Multiplier,nanoseconds%20%5Bref%5D.
// https://zipcpu.com/zipcpu/2021/07/03/slowmpy.html
// https://github.com/SubZer0811/VLSI/blob/master/verilog/32bit-wallace-multiplier/wallace.v
module Multiplication #(parameter l=16) (
	input [lv:0] A,
	input [lv:0] B,
	output [lv:0] R1,
	output Overflow
);

parameter lv = l-1;

wire [lv:0] Carry [l:0];
assign Carry[0] = {l{1'b0}};

wire [lv:0] Sum [l:0];
assign Sum[0] = {l{1'b0}};

wire [lv:0] carry_aggregate;
assign carry_aggregate[0] = 0;

generate
genvar i;

for (i = 0; i < l; i = i + 1) begin
	// We are adding A to 0 B times
	ControlledFullAdder #(l-i) controlled_full_adder(
		.A(Sum[i][lv:i]), // The previous sum (at index i)
		.B(A[lv-i:0]),
		.Cin(Carry[i][lv-i:0]), // The previous carry (at index i)
		.Selection(B[i]), // For each bit of B, we add currently shifted A only if that bit is 1
		
		.Sum(Sum[i+1][lv:i]), // Current sum value (at index i+1)
		.Cout(Carry[i+1][lv-i:0]) // Current carry value (at index i+1)
	);
	assign R1[i] = Sum[i+1][i]; // At this point, the last bit of the sum would never change afterwards
								//   , thus can already be put in the output

	if (i >= 1) // Checking if any of the carries are 1
		assign carry_aggregate[i] = carry_aggregate[i-1] | Carry[i+1][lv-i];
end
endgenerate

assign Overflow = carry_aggregate[lv];

endmodule


module SignedMultiplication #(parameter l=16) (
	input [lv:0] A,
	input [lv:0] B,
	output [lv:0] R1,
	output [lv:0] R2
);

parameter lv = l-1;

// TODO: Implement the signed multiplication
// (just handle the sign bit and then call the unsigned multiplication)
	
endmodule //SignedMultiplication