`timescale 1ns / 1ps
`include "./riscv.v"

module RISCV_Testbench ();

	parameter DebugDataWidth = 16 * 8;
	parameter dv = DebugDataWidth - 1;

	reg Clk;
	wire signed [15:0] reg0;
	wire signed [15:0] reg1;
	wire signed [15:0] reg2;
	wire signed [15:0] reg3;
	wire signed [15:0] reg4;
	wire signed [15:0] reg5;
	wire signed [15:0] reg6;
	wire signed [15:0] reg7;

	RISCV uut (
		.Clk(Clk), 
		.DebugData(
			{reg7, reg6, reg5, reg4, reg3, reg2, reg1, reg0}
		)
	);
	
	// always #5 Clk = ~Clk;
	
	integer i;

	initial begin
		$dumpfile("wave.vcd");
		$dumpvars(0, RISCV_Testbench);
		$monitor(
			"PC: %d\n000: %d\n001: %d\n010: %d\n011: %d\n100: %d\n101: %d\n110: %d\n111: %b\n",
			uut.PC,
			reg0, reg1, reg2, reg3, reg4, reg5, reg6, reg7
		);
		
		for(i = 0; i < 8; i = i + 1) begin
			Clk = 0;
			#5;
			Clk = 1;
			#5;
		end
	end
endmodule