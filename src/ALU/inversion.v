`include "./addition.v"

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

wire [lv-1:0] ignore;
FullAdder #(l-1) full_adder(
	.A(~A[lv-1:0]),
	.B({l-1{1'b0}}),
	.Cin(1'b1),

	.S(R[lv-1:0]),
	.Cout(ignore)
);

assign R[lv] = ~A[lv];

endmodule

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