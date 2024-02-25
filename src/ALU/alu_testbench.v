`include "./alu.v"

// This was generated using Copilot
module ALU_Testbench ();

    parameter l = 5;
    parameter lv = l-1;
    parameter p = 0;

    reg [p:0] Operation;
    reg signed [lv:0] A;
    reg signed [lv:0] B;
    reg [lv:0] Flags;
    wire signed [lv:0] R;
    wire [lv:0] FlagsOut;

    ALU #(l, p) alu(
        .Operation(Operation),
        .A(A), .B(B),
        .FlagsIn(Flags),

        .R(R),
        .FlagsOut(FlagsOut)
    );

    always @(FlagsOut) begin
        Flags = FlagsOut;
    end

    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0, ALU_Testbench);

        Flags = 16'd0;
        #20;

        $monitor("Operation=%d\nA=%d\nB=%d\nFlags=%b\nR=%d\n\n", Operation, A, B, Flags, R);
        
        $display("Testing division:");
        Operation = 1'd0;
        A = 16'sd6;
        B = 16'sd3;
        #10;

        Operation = 1'd0;
        A = 16'sd6;
        B = 16'sd4;
        #10;
        

        Operation = 1'd0;
        A = 16'sd6;
        B = 16'sd0;
        #10;

        Operation = 1'd0;
        A = -16'sd6;
        B = -16'sd3;
        #10;

        Operation = 1'd0;
        A = -16'sd6;
        B = 16'sd3;
        #10;

        Operation = 1'd0;
        A = -16'sd16;
        B = -16'sd1;
        #10;

        $display("Testing multiplication:");
        Operation = 1'd1;
        A = 16'sd2;
        B = 16'sd3;
        #10;

        Operation = 1'd1;
        A = 16'sd6;
        B = 16'sd6;
        #10;

        Operation = 1'd1;
        A = -16'sd16;
        B = 16'sd1;
        #10;

        Operation = 1'd1;
        A = -16'sd16;
        B = -16'sd1;
        #10;
    end
endmodule