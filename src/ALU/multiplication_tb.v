`include "./multiplication.v"
`include "./addition.v"

// This was generated using Copilot
module Multiplication_Testbench ();

	reg [16:0] A;
	reg [16:0] B;
	wire [16:0] R1;
	wire Overflow;

	// Controls the size of the registers (to more easily see the overflow)
	// Can be set back to 16 to see how the actual module would behave
	parameter l = 3;
	Multiplication #(l) multiplication(
		.A(A[l-1:0]),
		.B(B[l-1:0]),
		.R1(R1[l-1:0]),
		.Overflow(Overflow)
	);
	assign R1[16:l] = 0;

	initial begin
		$monitor("A=%d,\nB=%d\nR1=%d, O=%b\n", A, B, R1, Overflow);
		A = 16'd2;
		B = 16'd3;
		#10;
		A = 16'd3;
		B = 16'd4;
		#10;
		A = 16'd4;
		B = 16'd5;
		#10;
		A = 16'd7;
		B = 16'd7;
		#10;
		A = 16'd3;
		B = 16'd7;
		#10;
	end

endmodule
