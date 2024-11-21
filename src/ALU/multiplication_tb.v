`include "./multiplication.v"
`include "./addition.v"

// This was generated using Copilot
module Multiplication_Testbench ();

	reg [16:0] X;
	reg [16:0] Y;
	wire [16:0] R1;
	wire Overflow;

	// Controls the size of the registers (to more easily see the overflow)
	// Can be set back to 16 to see how the actual module would behave
	parameter l = 3;
	Multiplication #(l) multiplication(
		.X(X[l-1:0]),
		.Y(Y[l-1:0]),
		.R1(R1[l-1:0]),
		.Overflow(Overflow)
	);
	assign R1[16:l] = 0;

	initial begin
		$dumpfile("wave.vcd");
		$dumpvars(0, Multiplication_Testbench);
		$monitor("X=%d,\nY=%d\nR1=%d, O=%b\n", X, Y, R1, Overflow);

		// Checking all the cases of overflow :
		// for (X = 0; X < 8; X = X + 1) begin
		// 	for (Y = 0; Y < 8; Y = Y + 1) begin
		// 		#10;
		// 	end
		// end

		X = 16'd2;
		Y = 16'd3;
		#10;
		X = 16'd3;
		Y = 16'd4;
		#10;
		X = 16'd4;
		Y = 16'd5;
		#10;
		X = 16'd7;
		Y = 16'd7;
		#10;
		X = 16'd3;
		Y = 16'd7;
		#10;
	end

endmodule
