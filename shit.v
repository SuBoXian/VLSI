`include "def.v"
//`define INTERNAL_BITS 32
//`define DATA_BITS 32
module ALU(
	Data_in1,
	Data_in2,
	Op,
	Zero,
	Result
);

	input [`INTERNAL_BITS-1:0] Data_in1,Data_in2;
	input [`ALU_OP-1:0] Op;
	output [`INTERNAL_BITS-1:0] Result,Zero;

endmodule

//jdkjflkjdkjlskjfkl;sd
