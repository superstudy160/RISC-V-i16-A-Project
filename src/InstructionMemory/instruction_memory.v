module InstructionMemory #(parameter l = 16)(
	input [lv:0] Address,
	output reg [lv:0] Instruction
);

parameter lv = l-1;

always @(Address) begin
	case (Address)
		// This is the contents of the instruction memory
		00: Instruction = 16'b0000000000000000;
		01: Instruction = 16'b0000000000000001;
		02: Instruction = 16'b0000000000000010;
		03: Instruction = 16'b0000000000000011;
		04: Instruction = 16'b0000000000000100;
		05: Instruction = 16'b0000000000000101;
		06: Instruction = 16'b0000000000000110;
		07: Instruction = 16'b0000000000000111;
		08: Instruction = 16'b0000000000001000;
		09: Instruction = 16'b0000000000001001;
		10: Instruction = 16'b0000000000001010;
		11: Instruction = 16'b0000000000001011;
		12: Instruction = 16'b0000000000001100;
		13: Instruction = 16'b0000000000001101;
		14: Instruction = 16'b0000000000001110;
		15: Instruction = 16'b0000000000001111;
		16: Instruction = 16'b0000000000010000;
		17: Instruction = 16'b0000000000010001;
		18: Instruction = 16'b0000000000010010;
		19: Instruction = 16'b0000000000010011;
		20: Instruction = 16'b0000000000010100;
		21: Instruction = 16'b0000000000010101;
		22: Instruction = 16'b0000000000010110;
		23: Instruction = 16'b0000000000010111;
		24: Instruction = 16'b0000000000011000;
		25: Instruction = 16'b0000000000011001;
		26: Instruction = 16'b0000000000011010;
		27: Instruction = 16'b0000000000011011;
		28: Instruction = 16'b0000000000011100;
		29: Instruction = 16'b0000000000011101;
		30: Instruction = 16'b0000000000011110;

		// Output zero for all other addresses
		default: Instruction = 16'b0;
	endcase
end
	
endmodule //InstructionMemory
