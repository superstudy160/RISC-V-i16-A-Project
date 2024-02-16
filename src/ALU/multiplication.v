// Suggestions for this stuff:
// https://en.wikipedia.org/wiki/Booth%27s_multiplication_algorithm
// http://vlsiip.com/download/booth.pdf
// The comparisson of different hardware multipliers:
// https://en.wikipedia.org/wiki/Binary_multiplier#Hardware_implementation
// Fast multiplication:
// https://watermark.silverchair.com/020085_1_online.pdfhttps://pubs.aip.org/aip/acp/article-pdf/doi/10.1063/1.5080898/14172964/020085_1_online.pdf
// https://ietresearch.onlinelibrary.wiley.com/doi/full/10.1049/iet-cds.2019.0537

module Multiplication #(parameter l=16) (
    input [lv:0] A,
    input [lv:0] B,
    output [lv:0] R,
    output Overflow
);

parameter lv = l-1;
parameter N = lv-1


// TODO: Implement the multiplication
generate genvar i
    for ( i = 0; i <;= N; i = i + 1) begin: gen_i
            FullAdderSigned full_adder_signed(
                .A(A[i][15:i]), .B(B[i]), S(R), .Overflow(Overflow)
            );
        end
  
endgenerate
endmodule