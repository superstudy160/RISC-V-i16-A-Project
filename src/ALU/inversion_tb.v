`include "./inversion.v"
`include "./addition.v"

module Inverter_Testbench ();

parameter l = 4;
reg signed [l-1:0] Input;

wire signed [l-1:0] R_inv;
wire Overflow_inv;
Inverter #(l) inverter(
    .Input(Input), .Result(R_inv),
    .Overflow(Overflow_inv)
);

wire [l-1:0] R_abs;
AbsoluteValue #(l) absolute_value(
    .Input(Input), .Result(R_abs)
);

reg Sign;
reg [l-1:0] A_sign;
wire signed [l-1:0] R_sign;
wire Overflow_sign;
GiveSign #(l) give_sign(
    .Sign(Sign),
    .Input(A_sign), .Result(R_sign),
    .Overflow(Overflow_sign)
);

initial begin
    $display("Testing inverter:");
    $monitor("Input=%d\nResult=%d  O=%b\n", Input, R_inv, Overflow_inv);
    Input = -4'sd1;
    #10;
    Input = -4'sd8;
    #10;
    Input = 4'sd7;
    #10;
    Input = 4'sd5;
    #10;

    $display("Testing absolute value:");
    $monitor("Input=%d Result=%d\n", Input, R_abs);
    Input = -4'sd1;
    #10;
    Input = -4'sd8;
    #10;
    Input = 4'sd7;
    #10;
    Input = -4'sd5;
    #10;

    $display("Testing sign setting:");
    $monitor("Sign=%d\nInput=%d Result=%d  O=%b\n", Sign, A_sign, R_sign, Overflow_sign);
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