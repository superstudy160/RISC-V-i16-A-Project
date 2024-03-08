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
	input [lv:0] Input,
	output [lv:0] Result,
	output Overflow
);

parameter lv = l-1;

wire ignore;
FullAdderFlags #(l) full_adder_flags(
	.X(~Input),
	.Y({{l-1{1'b0}}, 1'b1}),

	.S(Result),
	.Overflow(Overflow), // This would correspond to not changing the sign of A
	.Carry(ignore)
);

endmodule


// Given input of size 4, the maximum output is 1000
module AbsoluteValue #(parameter l=16) (
	input [lv:0] Input,
	output [lv:0] Result
);

parameter lv = l-1;

wire [lv:0] inv;
wire ignore;
Inverter #(l) inverter(
	.Input(Input), .Result(inv),
	.Overflow(ignore)
);

assign Result = Input[lv] ? inv : Input;

endmodule


module GiveSign #(parameter l=16) (
	input Sign, // 1 for negative, 0 for positive
	input [lv:0] Input,
	output [lv:0] Result,
	output Overflow
);

parameter lv = l-1;

wire [lv:0] inv;
wire ignore;
Inverter #(l) inverter(
	.Input(Input), .Result(inv),
	.Overflow(ignore)
);

assign Result = Sign ? inv : Input;
assign Overflow = !Sign & Input == {1'b1, {l-1{1'b0}}}; // E.g., if l=4, there is no way to represenet +8 in 2's complement

endmodule