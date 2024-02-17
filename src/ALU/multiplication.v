`include "./addition.v"

// Suggestions for this stuff:
// https://en.wikipedia.org/wiki/Booth%27s_multiplication_algorithm
// http://vlsiip.com/download/booth.pdf
// The comparisson of different hardware multipliers:
// https://en.wikipedia.org/wiki/Binary_multiplier#Hardware_implementation
// Fast multiplication:
// https://watermark.silverchair.com/020085_1_online.pdfhttps://pubs.aip.org/aip/acp/article-pdf/doi/10.1063/1.5080898/14172964/020085_1_online.pdf
// https://ietresearch.onlinelibrary.wiley.com/doi/full/10.1049/iet-cds.2019.0537

module ControlledAdder(
    input A,
    input B,
    input Cin,
    input Selection, // 1 for addition, 0 to skip
    output Sum,
    output Cout
);

wire b_buff;
assign b_buff = Selection & B;

Adder adder(
    .A(A), .B(b_buff), .Cin(Cin),
    .S(Sum), .Cout(Cout)
);
    
endmodule //ControlledAdder


module ControlledFullAdder #(parameter l=16) (
    input [lv:0] A,
    input [lv:0] B,
    input [lv:0] Cin,
    input Selection,
    output [lv:0] Sum,
    output [lv:0] Cout
);

parameter lv = l-1;

generate
genvar i;

for (i = 0; i < l; i = i + 1)
    ControlledAdder controlled_adder(
        .A(A[i]), .B(B[i]), .Cin(Cin[i]),
        .Selection(Selection), .Sum(Sum[i]),
        .Cout(Cout[i]) // This carry would go to the next ControlledFullAdder
    );

endgenerate
endmodule //ControlledFullAdder



// Source:
// https://coertvonk.com/hw/building-math-circuits/faster-parameterized-multiplier-in-verilog-30774
module Multiplication #(parameter l=16) (
    input [lv:0] A,
    input [lv:0] B,
    output [lv:0] R1,
    output [lv:0] R2
);

parameter lv = l-1;

wire [lv:0] Carry [l:0];
assign Carry[0] = {l{1'b0}};

wire [lv:0] Sum [l:0];
assign Sum[0] = {l{1'b0}};

generate
genvar i;

for (i = 0; i < l; i = i + 1) begin
    ControlledFullAdder #(l) controlled_full_adder(
        .A({1'b0, Sum[i][lv:1]}),
        .B(A), // We selectively add A or not
        .Cin(Carry[i]),
        .Selection(B[i]),
        
        .Sum(Sum[i+1]),
        .Cout(Carry[i+1])
    );
    assign R1[i] = Sum[i+1][0];
end
endgenerate

// Resolving lefout carries
wire [lv:0] ignore;
FullAdder #(l) full_adder(
    .A({1'b0, Sum[l][lv:1]}),
    .B(Carry[l]), .Cin(1'b0),

    .S(R2), .Cout(ignore)
);

endmodule