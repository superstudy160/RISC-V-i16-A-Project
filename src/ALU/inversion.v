/* This module would work in both directions:
General formula: -a = ~a + 1
Consider --a = -(~a + 1) = ~(~a + 1) + 1 = 
	= ~(~a + 1) + ~a + 1 - ~a = 
	= ~x + x - ~a = 
	= M + (~~a + 1) = 
	= M + 1 + a =
	= a.
Where M is all ones.
*/
module Inverter #(parameter l=16) (
	input [lv:0] A,
	output [lv:0] R
);

parameter lv = l-1;

wire [lv:0] ignore;
FullAdder #(l) full_adder(
	.A(~A[lv:0]),
	.B({l{1'b0}}),
	.Cin(1'b1),

	.S(R[lv:0]),
	.Cout(ignore)
);

endmodule


// Given input of size 4, the maximum output is 1000
module AbsoluteValue #(parameter l=16) (
	input [lv:0] A,
	output [lv:0] R
);

parameter lv = l-1;

wire [lv:0] inv;
Inverter #(l) inverter(
	.A(A), .R(inv)
);

assign R = A[lv] ? inv : A;

endmodule


module GiveSign #(parameter l=16) (
	input Sign, // 1 for negative, 0 for positive
	input [lv:0] A,
	output [lv:0] R
);

parameter lv = l-1;

wire [lv:0] inv;
Inverter #(l) inverter(
	.A(A), .R(inv)
);

assign R = Sign ? inv : A;

endmodule