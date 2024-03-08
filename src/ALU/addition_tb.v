`include "./addition.v"

// This was generated using Copilot
module FullAdderSigned_Testbench #(parameter l=16) ();

	parameter lv = l-1;

	reg [lv:0] x, y;
	wire [lv:0] sum;
	wire overflow, carry;

	FullAdderFlags #(l) uut (
		.X(x), 
		.Y(y),
		.S(sum),
		.Overflow(overflow),
		.Carry(carry)
	);
	
	initial begin
		$monitor("  x=%b\n  y=%b\nsum=%b, o=%b, c=%b\n\n", x, y, sum, overflow, carry);
		x = 16'b0000000000000000;
		y = 16'b0000000000000000;
		#10;
		x = 16'b0000000000000001;
		y = 16'b0000000000000001;
		#10;
		x = 16'b1000000000110000;
		y = 16'b1000000011100000;
		#10;
		x = 16'b1000000000000000;
		y = 16'b0000010000000000;
		#10;
		x = 16'b0100000000000001;
		y = 16'b0100000000000011;
		#10;
		x = 16'b0111111111111111;
		y = 16'b0000000000000001;
		#10;
		x = 16'b1111111111111111;
		y = 16'b0000000000000001;
	end

endmodule
