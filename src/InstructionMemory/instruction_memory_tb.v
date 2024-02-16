`include "./instruction_memory.v"

// This was generated using Copilot
module InstructionMemory_Testbench #(parameter l = 16) ();

parameter lv = l-1;

reg [lv:0] address;
wire [lv:0] instruction;

InstructionMemory u_InstructionMemory(
	.address     	( address      ),
	.instruction 	( instruction  )
);

initial begin
	$monitor("address=%d, instruction=%b\n", address, instruction);
	for (address = 0; address < 40; address = address + 1) begin
		#10;
	end
end

endmodule //InstructionMemory_Testbench();
