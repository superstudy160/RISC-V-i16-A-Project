`include "./addition.v"

// This was generated using Copilot
module FullAdderSigned16bit_Testbench();

    // Inputs
    reg [15:0] a, b;
    wire [15:0] sum;
    wire cout;

    // Instantiate the Unit Under Test (UUT)
    FullAdderSigned16bit uut (
        .A(a), 
        .B(b),
        .Cin(1'b0),
        .S(sum),
        .Cout(cout)
    );
    
    initial begin
        $monitor("  a=%b\n  b=%b\nsum=%b, cout=%b\n\n", a, b, sum, cout);
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
