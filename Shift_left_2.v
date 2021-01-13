`include "def.v"
//`define INTERNAL_BITS 32
//`define DATA_BITS 32
module Shift_left_2(
	in,
	out
);

	input [`INTERNAL_BITS-1:0] in;
	output [`INTERNAL_BITS-1:0] out;

 assign out=in<<2;//左移兩位(乘四)

endmodule
