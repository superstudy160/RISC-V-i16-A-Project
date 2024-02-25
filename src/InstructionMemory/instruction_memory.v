module InstructionMemory #(parameter l = 16)(
	input [lv:0] Address,
	output reg [lv:0] Instruction
);

parameter lv = l-1;

always @(Address) begin
	case (Address)
		// This is the contents of the instruction memory
		00: Instruction = { 3'b011, 3'b000, 10'sd2 };
		01: Instruction = { 3'b011, 3'b001, 10'sd3 }; // TODO: here have signed extension problem
		02: Instruction = { 3'b111, 3'b010, 3'b000, 4'b0, 3'b001 };
		03: Instruction = { 3'b010, 3'b011, 3'b010, 7'd4 };

		// Output zero for all other addresses
		default: Instruction = 16'b0;
	endcase
end
	
endmodule //InstructionMemory
