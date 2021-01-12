`include "def.v"
//`define INTERNAL_BITS 32
//`define DATA_BITS 32
module Comparator(
	src1,
	src2,
	forward1,
	forward2,
	select,
	out
);

	input [`INTERNAL_BITS-1:0] src1,src2,forward1,forward2;
	input select;
	output [`INTERNAL_BITS-1:0] out;

	assign out=select?(src1==src2):(forward1==forward2);//select是1就選擇比較src，且兩者相等輸出1

endmodule
