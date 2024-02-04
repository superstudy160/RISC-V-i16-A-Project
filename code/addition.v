module FullAdderSigned16bit (
    input [15:0] A,
    input [15:0] B,
    input Cin,
    output [15:0] S,
    output Cout
);
wire [14:0] Sum;
wire [14:0] Cout_temp;

// First bit
assign Sum[0] = A[0] ^ B[0] ^ Cin;
assign Cout_temp[0] = (A[0] & B[0]) | ((A[0] ^ B[0]) & Cin);

// Remaining bits
genvar i;
generate
    for (i = 1; i < 15; i = i + 1) begin : gen_adders
        assign Sum[i] = A[i] ^ B[i] ^ Cout_temp[i-1];
        assign Cout_temp[i] = (A[i] & B[i]) | ((A[i] ^ B[i]) & Cout_temp[i-1]);
    end
endgenerate

assign S = Sum;
assign Cout = Cout_temp[14];

endmodule