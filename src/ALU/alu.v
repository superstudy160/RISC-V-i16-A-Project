// p - describes the depth of amount of operations
module ALU #(parameter l=16, parameter p=0) (
	input [p:0] Operation,
	input [lv:0] B,
	input [lv:0] C,
	input [lv:0] FlagsIn,
	output [lv:0] Res,
	output reg [lv:0] FlagsOut
);

parameter lv = l-1;
parameter MulOverIdx = 0;
parameter DivHasRemIdx = 1;
parameter DivByZeroIdx = 2;
parameter DivOverIdx = 3;
parameter NoFlagsIdx = 4;

wire [lv:0] AbsB;
AbsoluteValue #(l) abs_b(
	.Input(B), .Result(AbsB)
);
wire [lv:0] AbsC;
AbsoluteValue #(l) abs_c(
	.Input(C), .Result(AbsC)
);

wire DivHasRem;
wire DivByZero;
wire [lv:0] DivisionR;
Division #(l) divider(
	.Min(AbsB), .Div(AbsC),
	.Quotient(DivisionR),
	.HasRemainder(DivHasRem),
	.DivByZero(DivByZero)
);

wire MulOver;
wire [lv:0] MultiplicationR;
Multiplication #(l) multiplier(
	.X(AbsB), .Y(AbsC),
	.R1(MultiplicationR),
	.Overflow(MulOver)
);

reg [lv:0] UnsignedR;
wire SignOverflow;
GiveSign #(l) give_sign(
	.Sign(B[lv] ^ C[lv]),
	.Input(UnsignedR),
	.Result(Res),
	.Overflow(SignOverflow)
);

always @(*) begin
	case (Operation)
		0: begin
			// Division
			UnsignedR = DivisionR;
			FlagsOut[DivHasRemIdx[lv:0]] = DivHasRem;
			FlagsOut[DivByZeroIdx[lv:0]] = DivByZero;
			FlagsOut[DivOverIdx[lv:0]] = SignOverflow;
			FlagsOut[MulOverIdx[lv:0]] = FlagsIn[MulOverIdx[lv:0]];
		end

		1: begin
			// Multiplication
			UnsignedR = MultiplicationR;
			FlagsOut[MulOverIdx[lv:0]] = MulOver | SignOverflow;
			FlagsOut[DivHasRemIdx[lv:0]] = FlagsIn[DivHasRemIdx[lv:0]];
			FlagsOut[DivByZeroIdx[lv:0]] = FlagsIn[DivByZeroIdx[lv:0]];
			FlagsOut[DivOverIdx[lv:0]] = FlagsIn[DivOverIdx[lv:0]];
		end

		default: begin
			UnsignedR = 0;
			FlagsOut[NoFlagsIdx[lv:0]-1:0] = FlagsIn[NoFlagsIdx[lv:0]-1:0];
		end
	endcase

	FlagsOut[lv:NoFlagsIdx[lv:0]] = FlagsIn[lv:NoFlagsIdx[lv:0]];
end

endmodule //ALU

