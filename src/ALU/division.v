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
    output [lv:0] Remainder,
    output DivByZero
);

parameter lv = l-1;

// TODO: Implement the division
    
endmodule //Division
