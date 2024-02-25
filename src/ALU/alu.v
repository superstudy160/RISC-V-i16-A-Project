`include "./multiplication.v"
`include "./division.v"
`include "./inversion.v"

// p - describes the depth of amount of operations
module ALU #(parameter l=16, parameter p=0) (
	input [p:0] Operation,
	input [lv:0] A,
	input [lv:0] B,
	input [lv:0] FlagsIn,
	output [lv:0] R,
	output [lv:0] FlagsOut
);

parameter lv = l-1;
// https://stackoverflow.com/a/63209787
`include "../flags.vh"

wire [lv:0] AbsA;
AbsoluteValue #(l) abs_a(
	.A(A), .R(AbsA)
);
wire [lv:0] AbsB;
AbsoluteValue #(l) abs_b(
	.A(B), .R(AbsB)
);

wire [lv:0] UnsignedR;
GiveSign #(l) give_sign(
	.Sign(A[lv] ^ B[lv]),
	.A(UnsignedR),
	.R(R)
);

always @(*) begin
	case (Operation)
		0: begin
			// Division
			Division #(l) divider(
				.A(AbsA), .B(AbsB),
				.Quotient(UnsignedR),
				.HasRemainder(FlagsOut[DivisionHasRemainderIdx[lv:0]]),
				.DivByZero(FlagsOut[DivisionByZeroIdx[lv:0]])
			);
			FlagsOut[MultiplicationOverflowIdx[lv:0]] = FlagsIn[MultiplicationOverflowIdx[lv:0]];
		end
		1: begin
			// Multiplication
			Multiplication #(l) multiplier(
				.A(AbsA), .B(AbsB),
				.R1(UnsignedR),
				.Overflow(FlagsOut[MultiplicationOverflowIdx[lv:0]])
			);
			FlagsOut[DivisionHasRemainderIdx[lv:0]] = FlagsIn[DivisionHasRemainderIdx[lv:0]];
			FlagsOut[DivisionByZeroIdx[lv:0]] = FlagsIn[DivisionByZeroIdx[lv:0]];
		end
	endcase

	FlagsOut[lv:ZeroIdx[lv:0]] = FlagsIn[lv:ZeroIdx[lv:0]];
end

endmodule //ALU