module inversion (
	input [0:15] A,
	input [0:15] B,
	output [0:15] A1,
	output [0:15] B1,
	output wire neg
);
reg [15:0] same = 16'b0;
reg [15:0] reverse = 16'b1;
always @(A) begin
	case(A)
	1'b0 : begin
		A1 = A ^ same;
		neg = 1'b0 ;
	end  
	1'b1 : begin
		A1 = A ^ reverse;
		neg = 1'b1 ;
	end  
	
end
always @(B) begin
	case(B)
	1'b0 : begin
		B1 = B ^ same;
		neg = 1'b0 ;
	end  
	 
	1'b1 : begin
		B1 = B ^ reverse;
		neg = 1'b0 ;
	end  
end
endmodule