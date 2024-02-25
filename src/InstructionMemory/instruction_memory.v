module InstructionMemory #(parameter l = 16)(
	input [lv:0] address,
	output reg [lv:0] instruction
);

parameter lv = l-1;

always @(address) begin
	case (address)
		// This is the contents of the instruction memory
		00: instruction = 16'b0000000000000000;
		01: instruction = 16'b0000000000000001;
		02: instruction = 16'b0000000000000010;
		03: instruction = 16'b0000000000000011;
		04: instruction = 16'b0000000000000100;
		05: instruction = 16'b0000000000000101;
		06: instruction = 16'b0000000000000110;
		07: instruction = 16'b0000000000000111;
		08: instruction = 16'b0000000000001000;
		09: instruction = 16'b0000000000001001;
		10: instruction = 16'b0000000000001010;
		11: instruction = 16'b0000000000001011;
		12: instruction = 16'b0000000000001100;
		13: instruction = 16'b0000000000001101;
		14: instruction = 16'b0000000000001110;
		15: instruction = 16'b0000000000001111;
		16: instruction = 16'b0000000000010000;
		17: instruction = 16'b0000000000010001;
		18: instruction = 16'b0000000000010010;
		19: instruction = 16'b0000000000010011;
		20: instruction = 16'b0000000000010100;
		21: instruction = 16'b0000000000010101;
		22: instruction = 16'b0000000000010110;
		23: instruction = 16'b0000000000010111;
		24: instruction = 16'b0000000000011000;
		25: instruction = 16'b0000000000011001;
		26: instruction = 16'b0000000000011010;
		27: instruction = 16'b0000000000011011;
		28: instruction = 16'b0000000000011100;
		29: instruction = 16'b0000000000011101;
		30: instruction = 16'b0000000000011110;

		// Output zero for all other addresses
		default: instruction = 16'b0;
	endcase
end
	
endmodule //InstructionMemory
