// https://www.geeksforgeeks.org/full-subtractor-in-digital-logic/
module Subtract(
    input A, // Minuend
    input B, // Subtrahend
    input Bin, // Borrow in
    output D, // Difference
    output Bout // Borrow out
);

assign D = A ^ B ^ Bin;
assign Bout = (~A & B) | ((~(A ^ B)) & Bin);
    
endmodule //Subtract

// A - B
module ControlledSubtract(
    input A, // Minuend
    input B, // Subtrahend
    input Bin, // Borrow in
    input Selection, // 0 for subtraction, 1 to skip
    output D, // Difference
    output Bout // Borrow out
);

wire d_buff;

Subtract subtractor(
    .A(A), .B(B), .Bin(Bin),
    .D(d_buff), .Bout(Bout)
);

assign D = Selection ? A : d_buff;

endmodule //ControlledSubtract

module Division #(parameter l=16) (
    input [lv:0] A,
    input [lv:0] B,
    output [lv:0] Quotient,
    output [l:0] Remainder,
    output DivByZero
);

parameter lv = l-1;

wire [l:0] Difference [lv:0];
wire [l:0] Borrow [lv:0];

generate
genvar i, j;

for (i = 0; i < l; i = i + 1) begin // <- depth of the division
    //            |-> We are doing one more cycle to put down next bit
    for(j = 0; j <= l; j = j + 1) begin
        ControlledSubtract controlled_subtractor(
            .A(
                (j == 0) ? A[lv-i] :  // Putting down the next bit
                (i > 0) ? Difference[i-1][j-1] : // Propagating the previous bits
                1'b0 // Zero padding otheriwse
            ),
            .B(j < l ? B[j] : 1'b0), // Last bit without substractend (needed for borrow)
            .Bin(j == 0 ? 1'b0 : Borrow[i][j-1]), // First borrow is always 0
            .Selection(Borrow[i][l]), // Don't need to borrow => do subtraction

            .D(Difference[i][j]),
            .Bout(Borrow[i][j])
        );
    end
end

for (i = 0; i < l; i = i + 1)
    assign Quotient[i] = ~Borrow[i][lv-i];

assign Remainder = Difference[lv];

endgenerate
    
endmodule //Division
