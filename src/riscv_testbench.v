`timescale 1ns / 1ps
`include "./riscv.v"

module RISCV_Testbench ();

	parameter DebugDataWidth = 16 * 8;
	parameter dv = DebugDataWidth - 1;

	reg Clk;
	wire [dv:0] DebugData;

	RISCV uut (
		.Clk(Clk), 
		.DebugData(DebugData)
	);
	
	// always #5 Clk = ~Clk;
	
	integer i;

	initial begin
		$dumpfile("wave.vcd");
		$dumpvars(0, RISCV_Testbench);
		$monitor(
			"PC: %d\n000: %d\n001: %d\n010: %d\n011: %d\n100: %d\n101: %d\n110: %d\n111: %b\n",
			uut.PC,
			DebugData[0*16 +: 16],
			DebugData[1*16 +: 16],
			DebugData[2*16 +: 16],
			DebugData[3*16 +: 16],
			DebugData[4*16 +: 16],
			DebugData[5*16 +: 16],
			DebugData[6*16 +: 16],
			DebugData[7*16 +: 16]
		);
		
		for(i = 0; i < 8; i = i + 1) begin
			Clk = 0;
			#5;
			Clk = 1;
			#5;
		end
	end
endmodule