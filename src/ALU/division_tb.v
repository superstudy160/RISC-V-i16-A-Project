`include "./division.v"

module Division_Testbench ();

	reg [15:0] a, b;
	wire [15:0] quotient, remainder;
	wire DivByZero;

	Division #(16) uut (
		.A(a), 
		.B(b),
		.Quotient(quotient),
		.Remainder(remainder),
		.DivByZero(DivByZero)
	);
	
	initial begin
		$monitor("a=%d\nb=%d\nq=%d, r=%d, z=%b\n\n", a, b, quotient, remainder, DivByZero);
		a = 16'd0;
		b = 16'd0;
		#10;
		a = 16'd5;
		b = 16'd2;
		#10;
		a = 16'd18;
		b = 16'd3;
		#10;
		a = 16'd18;
		b = 16'd4;
		#10;
		a = 16'd18;
		b = 16'd5;
		#10;
	end
endmodule