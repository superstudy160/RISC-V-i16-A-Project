`include "./control_unit.v"

// This was generated using Copilot
module ControlUnit_Testbench ();

    parameter l = 5;
    parameter lv = l-1;
    parameter p = 0;
    parameter pv = p-1;
    parameter op_l = 3;
    parameter op_lv = op_l-1;

    reg [op_lv:0] Opcode;
    wire LoadUpperImmediate;
    wire [pv:0] ALUOpcode;
    wire UseImmediate;
    wire UpdateFlags;

    ControlUnit #(l, op_l, p) control_unit(
        .Opcode(Opcode),
        .LoadUpperImmediate(LoadUpperImmediate),
        .ALUOpcode(ALUOpcode),
        .UseImmediate(UseImmediate),
        .UpdateFlags(UpdateFlags)
    );

    initial begin
        $monitor("LoadUpperImmediate=%d\nALUOpcode=%d\nUseImmediate=%d\nUpdateFlags=%d\n\n", LoadUpperImmediate, ALUOpcode, UseImmediate, UpdateFlags);
        
        $display("MUL:");
        Opcode = 3'b111;
        #10;

        $display("DIV:");
        Opcode = 3'b000;
        #10;
        
        $display("MULi:");
        Opcode = 3'b001;
        #10;

        $display("DIVi:");
        Opcode = 3'b010;
        #10;

        $display("LUI:");
        Opcode = 3'b011;
        #10;
    end
endmodule