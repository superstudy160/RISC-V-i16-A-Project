`include "./multiplication.v"
`include "./division.v"
`include "./inversion.v"
`include "./addition.v"

// p - describes the depth of amount of operations
module ALU #(parameter l=16, parameter p=0) (
	input [p:0] Operation,
	input [lv:0] A,
	input [lv:0] B,
	input [lv:0] FlagsIn,
	output [lv:0] R,
	output reg [lv:0] FlagsOut
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

wire DivisionHasRemainder;
wire DivisionDivByZero;
wire [lv:0] DivisionR;
Division #(l) divider(
	.A(AbsA), .B(AbsB),
	.Quotient(DivisionR),
	.HasRemainder(DivisionHasRemainder),
	.DivByZero(DivisionDivByZero)
);

wire MultiplicationOverflow;
wire [lv:0] MultiplicationR;
Multiplication #(l) multiplier(
	.A(AbsA), .B(AbsB),
	.R1(MultiplicationR),
	.Overflow(MultiplicationOverflow)
);

reg [lv:0] UnsignedR;
wire SignOverflow;
GiveSign #(l) give_sign(
	.Sign(A[lv] ^ B[lv]),
	.A(UnsignedR),
	.R(R),
	.Overflow(SignOverflow)
);

always @(*) begin
	case (Operation)
		0: begin
			// Division
			UnsignedR = DivisionR;
			FlagsOut[DivisionHasRemainderIdx[lv:0]] = DivisionHasRemainder;
			FlagsOut[DivisionByZeroIdx[lv:0]] = DivisionDivByZero;
			FlagsOut[DivisionOverflowIdx[lv:0]] = SignOverflow;
			FlagsOut[MultiplicationOverflowIdx[lv:0]] = FlagsIn[MultiplicationOverflowIdx[lv:0]];
		end

		1: begin
			// Multiplication
			UnsignedR = MultiplicationR;
			FlagsOut[MultiplicationOverflowIdx[lv:0]] = MultiplicationOverflow | SignOverflow;
			FlagsOut[DivisionHasRemainderIdx[lv:0]] = FlagsIn[DivisionHasRemainderIdx[lv:0]];
			FlagsOut[DivisionByZeroIdx[lv:0]] = FlagsIn[DivisionByZeroIdx[lv:0]];
			FlagsOut[DivisionOverflowIdx[lv:0]] = FlagsIn[DivisionOverflowIdx[lv:0]];
		end

		default: begin
			UnsignedR = 0;
			FlagsOut[NoFlagsIdx[lv:0]-1:0] = FlagsIn[NoFlagsIdx[lv:0]-1:0];
		end
	endcase

	FlagsOut[lv:NoFlagsIdx[lv:0]] = FlagsIn[lv:NoFlagsIdx[lv:0]];
end

endmodule //ALU