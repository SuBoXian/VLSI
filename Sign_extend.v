`include "def.v"
//`define INTERNAL_BITS 32
//`define DATA_BITS 32
//`define RTYPE_SHAMT 10:6
module Sign_extend(
	in,
	out
);

	input [15:0] in;//輸入[15:0]INTERNAL_BITS
	output [`INTERNAL_BITS-1:0] out;//輸出shamt並擴充至32bits

	assign out = {27'b0,in[`RTYPE_SHAMT]};//補27個零在5 bits的shamt前面

endmodule
