module Adder (
	input A,
	input B,
	input Cin,
	output S,
	output Cout
);

assign S = A ^ B ^ Cin;
assign Cout = (A & B) | ((A ^ B) & Cin);

endmodule //Adder

module FullAdder #(parameter l = 16) (
	input [lv:0] A,
	input [lv:0] B,
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
	//                                     |-> Why you do this?
	for (i = 0; i <= lv; i = i + 1) begin : gen_adders
		Adder adder(A[i], B[i], Cout_temp[i], Sum[i], Cout_temp[i+1]);
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
 