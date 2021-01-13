`include "def.v"
//`define DATA_BITS 32
//`define INTERNAL_BITS 32
//`define ALUCONTROL_BITS 4

module ALU(
	src1,
	src2,
	ALUcontrol,
	zero,
	Result
);
	parameter AND = 4'b0000,
			  OR  = 4'b0001,
			  ADD = 4'b0010,
			  SUB = 4'b0110,
			  SLT = 4'b0111,
			  MUL = 4'b1000,
			  NOR = 4'b1100;
	
	input [`INTERNAL_BITS-1:0] src1,src2;
	input [`ALUCONTROL_BITS-1:0] ALUcontrol;
	output reg [`INTERNAL_BITS:0] Result;
	output reg zero;
	
	reg [`INTERNAL_BITS-1:0] temp;
	
	always@(*) begin
		Result[`INTERNAL_BITS] = 1'b0;
		zero = 1'b0;
		case(ALUcontrol)
			AND:begin
					Result[`INTERNAL_BITS-1:0] = src1&src2;//bit-wise
				end
			
			OR:begin
					Result[`INTERNAL_BITS-1:0] = src1|src2;//bit-wise
				end
			
			ADD:begin //CLA?
					Result[`INTERNAL_BITS-1:0] = src1 + src2;
					if((src1[`INTERNAL_BITS-1]==1'b0&&src2[`INTERNAL_BITS-1]==1'b0&&Result==1'b1)||
					   (src1[`INTERNAL_BITS-1]==1'b1&&src2[`INTERNAL_BITS-1]==1'b1&&Result==1'b0))
						Result[`INTERNAL_BITS] = 1'b1;
					else
						Result[`INTERNAL_BITS] = 1'b0;
				end
			
			SUB:begin
					Result[`INTERNAL_BITS-1:0] = src1 - src2;
					if((src1[31]==1'b0 && src2[31]==1'b1 && Result[31]==1'b1)||
				       (src1[31]==1'b1 && src2[31]==1'b0 && Result[31]==1'b0))
						Result[`INTERNAL_BITS] = 1'b1;
					else
						Result[`INTERNAL_BITS] = 1'b0;
					
					if(Result==33'b0)
						zero = 1'b1;
					else
						zero = 1'b0;
				end
			
			SLT:begin
					temp = src1 - src2;
					Result[`INTERNAL_BITS:0] = (temp[`INTERNAL_BITS-1])? 33'd1:33'd0;
				end
			
			MUL:begin
					Result[`INTERNAL_BITS-1:0] = src1[14:0]*src2[14:0];
				end
			
			NOR:begin
					temp[`INTERNAL_BITS-1:0] = src1|src2;//bit-wise
					Result[`INTERNAL_BITS-1:0] = ~temp;
				end
				
			
			default:begin
						Result[`INTERNAL_BITS] = 33'b0;
					end			
		endcase
	end
	
endmodule
