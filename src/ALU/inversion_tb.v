`include "./inversion.v"
`include "./addition.v"

module Inverter_Testbench ();

parameter l = 4;
reg signed [l-1:0] A;

wire signed [l-1:0] R_inv;
wire Overflow_inv;
Inverter #(l) inverter(
    .A(A), .R(R_inv),
    .Overflow(Overflow_inv)
);

wire [l-1:0] R_abs;
AbsoluteValue #(l) absolute_value(
    .A(A), .R(R_abs)
);

reg Sign;
reg [l-1:0] A_sign;
wire signed [l-1:0] R_sign;
wire Overflow_sign;
GiveSign #(l) give_sign(
    .Sign(Sign),
    .A(A_sign), .R(R_sign),
    .Overflow(Overflow_sign)
);

initial begin
    $display("Testing inverter:");
    $monitor("A=%d\nR=%d  O=%b\n", A, R_inv, Overflow_inv);
    A = -4'sd1;
    #10;
    A = -4'sd8;
    #10;
    A = 4'sd7;
    #10;
    A = 4'sd5;
    #10;

    $display("Testing absolute value:");
    $monitor("A=%d R=%d\n", A, R_abs);
    A = -4'sd1;
    #10;
    A = -4'sd8;
    #10;
    A = 4'sd7;
    #10;
    A = -4'sd5;
    #10;

    $display("Testing sign setting:");
    $monitor("Sign=%d\nA=%d R=%d  O=%b\n", Sign, A_sign, R_sign, Overflow_sign);
    Sign = 1'b0;
    A_sign = 4'd5;
    #10;
    Sign = 1'b0;
    A_sign = 4'd8;
    #10;
    Sign = 1'b1;
    A_sign = 4'd8;
    #10;
    Sign = 1'b1;
    A_sign = 4'd5;
    #10;
end

endmodule