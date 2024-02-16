module Adder (
    input A,
    input B,
    input Cin,
    output S,
    output Cout
);

assign S = A ^ B ^ Cin;
assign Cout = (A & B) | ((A ^ B) & Cin);

endmodule //Adder

module FullAdder #(parameter l = 16) (
    input [lv:0] A,
    input [lv:0] B,
    input Cin,
    output [lv:0] S,
    output [lv:0] Cout
);

parameter lv = l-1;

wire [lv:0] Sum;
wire [l:0] Cout_temp;
assign Cout_temp[0] = Cin;

// Remaining bits
genvar i;
generate
    //                                     |-> Why you do this?
    for (i = 0; i <= lv; i = i + 1) begin : gen_adders
        Adder adder(A[i], B[i], Cout_temp[i], Sum[i], Cout_temp[i+1]);
    end
endgenerate

assign S = Sum;
assign Cout[lv:0] = Cout_temp[l:1];

endmodule //FullAdder

module FullAdderSigned #(parameter l = 16) (
    input [lv:0] A,
    input [lv:0] B,
    output [lv:0] S,
    output Overflow
);

parameter lv = l-1;

wire [lv:0] Cout;

FullAdder #(l) full_adder (
    .A(A), .B(B), .Cin(1'b0),
    .S(S), .Cout(Cout)
);

assign Overflow = Cout[lv-1] ^ Cout[lv]; // this code works somehow, at least the possibilities I have tested

endmodule