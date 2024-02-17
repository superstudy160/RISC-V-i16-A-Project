`include "./inversion.v"

module Inverter_Testbench ();

parameter l = 4;
reg signed [l-1:0] A;
wire signed [l-1:0] R;

Inverter #(l) inverter(
    .A(A), .R(R)
);

initial begin
    $monitor("A=%d\nR=%d\n", A, R);
    #10;
    A = -4'sd1;
    #10;
    A = -4'sd8; // TODO: for this testcase the output is 0, and I am not sure what is it actually supposed to be
    #10;
    A = 4'sd7;
    #10;
    A = 4'sd5;
    #10;
end

endmodule