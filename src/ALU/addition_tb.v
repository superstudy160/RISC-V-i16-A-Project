`include "./addition.v"

// This was generated using Copilot
module FullAdderSigned_Testbench #(parameter l=16) ();

    parameter lv = l-1;

    reg [lv:0] a, b;
    wire [lv:0] sum;
    wire overflow, carry;

    FullAdderFlags #(l) uut (
        .A(a), 
        .B(b),
        .S(sum),
        .Overflow(overflow),
        .Carry(carry)
    );
    
    initial begin
        $monitor("  a=%b\n  b=%b\nsum=%b, o=%b, c=%b\n\n", a, b, sum, overflow, carry);
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
