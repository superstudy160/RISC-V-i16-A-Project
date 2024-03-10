module Adder (
	input X,
	input Y,
	input Cin,
	output S,
	output Cout
);

assign S = X ^ Y ^ Cin;
assign Cout = (X & Y) | ((X ^ Y) & Cin);

endmodule //Adder

module FullAdder #(parameter l = 16) (
	input [lv:0] X,
	input [lv:0] Y,
	input Cin,
	output [lv:0] S,
	output [lv:0] Cout
);

parameter lv = l-1;

wire [lv:0] Sum;
wire [l:0] Cout_temp;
assign Cout_temp[0] = Cin;

// Remaining bits
generate genvar i;
	for (i = 0; i <= lv; i = i + 1) begin
		Adder adder(X[i], Y[i], Cout_temp[i], Sum[i], Cout_temp[i+1]);
	end
endgenerate

assign S = Sum;
assign Cout[lv:0] = Cout_temp[l:1];

endmodule //FullAdder


/* https://teaching.idallen.com/dat2343/10f/notes/040_overflow.txt
In unsigned arithmetic, watch the carry flag to detect errors.
In unsigned arithmetic, the overflow flag tells you nothing interesting.

In signed arithmetic, watch the overflow flag to detect errors.
In signed arithmetic, the carry flag tells you nothing interesting.
*/
// This addition algorithm works both for signed and unsigned numbers (2's complement)
module FullAdderFlags #(parameter l = 16) (
	input [lv:0] X,
	input [lv:0] Y,
	output [lv:0] S,
	output Overflow,
	output Carry
);

parameter lv = l-1;

wire [lv:0] Cout;

FullAdder #(l) full_adder (
	.X(X), .Y(Y), .Cin(1'b0),
	.S(S), .Cout(Cout)
);

assign Overflow = Cout[lv-1] ^ Cout[lv];
assign Carry = Cout[lv];

endmodule // FullAdderFlags