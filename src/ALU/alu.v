// p - describes the depth of amount of operations
module ALU #(parameter l=16, parameter p=0) (
	input [p:0] Operation,
	input [lv:0] A,
	input [lv:0] B,
	input [lv:0] FlagsIn,
	output [lv:0] R,
	output [lv:0] FlagsOut
);

parameter lv = l-1;

// TODO: implement ALU

endmodule //ALU