module ContolUnit #(parameter l = 16, parameter op_l = 3, parameter p = 1)(
	input [op_lv:0] Opcode,
    output reg LoadUpperImmediate,
    output reg [pv:0] ALUOpcode,
    output reg UseImmediate
);

parameter lv = l-1;
parameter op_lv = op_l-1;
parameter pv = p-1;

always @(Opcode) begin
	case (Opcode)
        // MUL
        3'b111: begin
            ALUOpcode = 1;
            UseImmediate = 0;
            LoadUpperImmediate = 0;
        end
        // DIV
        3'b000: begin
            ALUOpcode = 0;
            UseImmediate = 0;
            LoadUpperImmediate = 0;
        end
        // MULi
        3'b001: begin
            ALUOpcode = 1;
            UseImmediate = 1;
            LoadUpperImmediate = 0;
        end
        // DIVi
        3'b010: begin
            ALUOpcode = 0;
            UseImmediate = 1;
            LoadUpperImmediate = 0;
        end
        // LUI
        3'b011: begin
            ALUOpcode = 0;
            UseImmediate = 0;
            LoadUpperImmediate = 1;
        end

        default: begin
            ALUOpcode = 0;
            UseImmediate = 0;
            LoadUpperImmediate = 0;
        end
	endcase
end
	
endmodule //ControlUnit
