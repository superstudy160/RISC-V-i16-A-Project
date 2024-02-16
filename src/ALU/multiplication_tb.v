`include "./multiplication.v"

// This was generated using Copilot
module Multiplication_Testbench #(parameter l=16) ();

    parameter lv = l-1;

    reg [lv:0] a, b;
    wire [lv:0] R;
    wire overflow;

    multiplication #(l) uut (
        .A(a), 
        .B(b),
        .S(R),
        .Overflow(overflow)
    );
    
    initial begin
        $monitor("  a=%b\n  b=%b\nR=%b, o=%b\n\n", a, b, R, overflow);
        a = 16'b0000000000000000;
        b = 16'b0000000000000000;
        #10;
        a = 16'b0000000000000001;
        b = 16'b0000000000000001;
        #10;
        a = 16'b1000000000110000;
        b = 16'b1000000011100000;
        #10;
        a = 16'b1000000000000000;
        b = 16'b0000010000000000;
        #10;
        a = 16'b0100000000000001;
        b = 16'b0100000000000011;
        #10;
        a = 16'b0111111111111111;
        b = 16'b0000000000000001;
        #10;
        a = 16'b1111111111111111;
        b = 16'b0000000000000001;
    end

endmodule
