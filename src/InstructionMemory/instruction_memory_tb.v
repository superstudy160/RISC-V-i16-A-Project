`include "./instruction_memory.v"

// This was generated using Copilot
module InstructionMemory_Testbench #(parameter l = 16) ();

parameter lv = l-1;

reg [lv:0] Address;
wire [lv:0] Instruction;

InstructionMemory u_InstructionMemory(
	.Address     	( Address      ),
	.Instruction 	( Instruction  )
);

initial begin
	$monitor("address=%d, instruction=%b\n", Address, Instruction);
	for (Address = 0; Address < 40; Address = Address + 1) begin
		#10;
	end
end

endmodule //InstructionMemory_Testbench();
