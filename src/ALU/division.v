// https://www.geeksforgeeks.org/full-subtractor-in-digital-logic/
module Subtractor(
	input Min, // Minuend
	input Subtr, // Subtrahend
	input Bin, // Borrow in
	output Diff, // Difference
	output Bout // Borrow out
);

assign Diff = Min ^ Subtr ^ Bin;
assign Bout = (~Min & Subtr) | ((~(Min ^ Subtr)) & Bin);
	
endmodule //Subtractor


// A - B
module ControlledSubtractor(
	input Min, // Minuend
	input Subtr, // Subtrahend
	input Bin, // Borrow in
	input Selection, // 0 for subtraction, 1 to skip
	output Diff, // Difference
	output Bout // Borrow out
);

wire diff_buff;

Subtractor subtractor(
	.Min(Min), .Subtr(Subtr), .Bin(Bin),
	.Diff(diff_buff), .Bout(Bout)
);

assign Diff = Selection ? Min : diff_buff;

endmodule //ControlledSubtractor


// Source:
// https://coertvonk.com/hw/building-math-circuits/parameterized-divider-in-verilog-30776
// In theory, this article should describe the way to improve our algorithm
// https://citeseerx.ist.psu.edu/document?repid=rep1&type=pdf&doi=8145c053ed44bea2b2ce4a9f7051c7cde727cd3f
// https://www.researchgate.net/publication/4156467_A_hardware_algorithm_for_integer_division
// Another nice source:
// https://en.algorithmica.org/hpc/arithmetic/division/
// https://doc.lagout.org/security/Hackers%20Delight.pdf
module FullControlledSubtractor #(parameter l=16) (
	input [l:0] Min, // Last bit without substractend (needed for borrow)
	input [lv:0] Subtr,
	output [l:0] Diff,
	output Subtracted // 1 if the subtraction was done, 0 if it was skipped
);

parameter lv = l-1;

wire Borrow [l+1:0];
assign Borrow[0] = 1'b0; // First borrow is always 0
assign Subtracted = ~Borrow[l+1]; // Don't need to borrow => do subtraction

generate
genvar i;

for (i = 0; i <= l; i = i + 1) begin
	wire subtr_buff;
	if (i < l) assign subtr_buff = Subtr[i];
	else assign subtr_buff = 1'b0;

	wire diff_buff;
	if (i < l) assign Diff[i] = diff_buff;

	ControlledSubtractor subtractor(
		.Min(Min[i]), .Subtr(subtr_buff),
		.Bin(Borrow[i]),
		.Selection(~Subtracted),

		.Diff(diff_buff),
		.Bout(Borrow[i+1])
	);
end
endgenerate
endmodule //FullControlledSubtractor


// Quotient = Min / Div
module Division #(parameter l=16) (
	input [lv:0] Min,
	input [lv:0] Div,
	output [lv:0] Quotient,
	output HasRemainder,
	output DivByZero
);

parameter lv = l-1;

wire [lv:0] Difference [lv:0];
assign HasRemainder = |Difference[lv];
assign DivByZero = ~(|Div);

generate
genvar i;

for (i = 0; i < l; i = i + 1) begin
	wire [l:0] min_buff;
	assign min_buff[0] = Min[lv-i];
	if (i > 0) assign min_buff[l:1] = Difference[i-1];
	else assign min_buff[l:1] = {l{1'b0}};

	wire ignore;
	FullControlledSubtractor #(l) subtractor(
		.Min(min_buff), .Subtr(Div),
		.Diff({ignore, Difference[i]}),
		.Subtracted(Quotient[lv-i])
	);
end

endgenerate
endmodule //Division

// Signed versions of the oprations should be implemented in the ALU module
