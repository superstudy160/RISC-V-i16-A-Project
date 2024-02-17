// https://www.geeksforgeeks.org/full-subtractor-in-digital-logic/
module Subtractor(
	input A, // Minuend
	input B, // Subtrahend
	input Bin, // Borrow in
	output D, // Difference
	output Bout // Borrow out
);

assign D = A ^ B ^ Bin;
assign Bout = (~A & B) | ((~(A ^ B)) & Bin);
	
endmodule //Subtractor


// A - B
module ControlledSubtractor(
	input A, // Minuend
	input B, // Subtrahend
	input Bin, // Borrow in
	input Selection, // 0 for subtraction, 1 to skip
	output D, // Difference
	output Bout // Borrow out
);

wire d_buff;

Subtractor subtractor(
	.A(A), .B(B), .Bin(Bin),
	.D(d_buff), .Bout(Bout)
);

assign D = Selection ? A : d_buff;

endmodule //ControlledSubtractor


// Source:
// https://coertvonk.com/hw/building-math-circuits/parameterized-divider-in-verilog-30776
module FullControlledSubtractor #(parameter l=16) (
	input [l:0] A, // Minuend (Last bit without substractend (needed for borrow))
	input [lv:0] B, // Subtrahend
	output [l:0] D, // Difference
	output Subtracted // 1 if the subtraction was done, 0 if it was skipped
);

parameter lv = l-1;

wire Borrow [l+1:0];
assign Borrow[0] = 1'b0; // First borrow is always 0
assign Subtracted = ~Borrow[l+1]; // Don't need to borrow => do subtraction

generate
genvar i;

for (i = 0; i <= l; i = i + 1) begin
	wire b_buff;
	if (i < l) assign b_buff = B[i];
	else assign b_buff = 1'b0;

	wire d_buff;
	if (i < l) assign D[i] = d_buff;

	ControlledSubtractor subtractor(
		.A(A[i]), .B(b_buff),
		.Bin(Borrow[i]),
		.Selection(~Subtracted),

		.D(d_buff),
		.Bout(Borrow[i+1])
	);
end
endgenerate
endmodule //FullControlledSubtractor


module Division #(parameter l=16) (
	input [lv:0] A,
	input [lv:0] B,
	output [lv:0] Quotient,
	output [lv:0] Remainder,
	output DivByZero
);

parameter lv = l-1;

wire [lv:0] Difference [lv:0];
assign Remainder = Difference[lv];

wire [l:0] is_zero;
assign is_zero[0] = 1'b0;

generate
genvar i;

for (i = 0; i < l; i = i + 1) begin
	wire [l:0] a_buff;
	assign a_buff[0] = A[lv-i];
	if (i > 0) assign a_buff[l:1] = Difference[i-1];
	else assign a_buff[l:1] = {l{1'b0}};

	wire ignore;
	FullControlledSubtractor #(l) subtractor(
		.A(a_buff), .B(B),
		.D({ignore, Difference[i]}),
		.Subtracted(Quotient[lv-i])
	);
end

for (i = 0; i < l; i = i + 1)
	assign is_zero[i+1] = is_zero[i] | B[i];
assign DivByZero = ~is_zero[l];

endgenerate
endmodule //Division


module SignedDivision #(parameter l=16)(
	input [lv:0] A,
	input [lv:0] B,
	output [lv:0] Quotient,
	output [lv:0] Remainder,
	output DivByZero
);

parameter lv = l-1;
	
// TODO: Implement the signed division

endmodule //SignedDivision 
