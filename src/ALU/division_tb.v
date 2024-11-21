`include "./division.v"

module Division_Testbench ();

	reg [15:0] min, div;
	wire [15:0] quotient;
	wire HasRemainder;
	wire DivByZero;

	Division #(16) uut (
		.Min(min), 
		.Div(div),
		.Quotient(quotient),
		.HasRemainder(HasRemainder),
		.DivByZero(DivByZero)
	);
	
	initial begin
		$monitor("min=%d\ndiv=%d\nq=%d, r=%b, z=%b\n\n", min, div, quotient, HasRemainder, DivByZero);
		min = 16'd0;
		div = 16'd0;
		#10;
		min = 16'd7;
		div = 16'd0;
		#10;
		min = 16'd5;
		div = 16'd2;
		#10;
		min = 16'd18;
		div = 16'd3;
		#10;
		min = 16'd18;
		div = 16'd4;
		#10;
		min = 16'd18;
		div = 16'd5;
		#10;
	end
endmodule