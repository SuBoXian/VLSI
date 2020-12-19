`include "def.v"
//`define INTERNAL_BITS 32
//`define DATA_BITS 32
module Adder(
	Data_in1,
	Data_in2,
	Result
);

	input [`INTERNAL_BITS-1:0] Data_in1,Data_in2;
	output [`INTERNAL_BITS-1:0] Result;

 assign Result = Data_in1 + Data_in2;

endmodule
