`include "def.v"
//`define REGISTER_BITS 5

module Forwarding_unit(ID_EX_RS,
					   ID_EX_RT,
					   EX_MEM_RD,
					   MEM_WB_RD,
					   EX_MEM_RegWrite,
					   MEM_WB_RegWrite,
					   src1_mux,
					   src2_mux
					   );
	
	input EX_MEM_RegWrite, MEM_WB_RegWrite;
	input [`REGISTER_BITS-1:0] ID_EX_RS, ID_EX_RT, EX_MEM_RD, MEM_WB_RD;
	output reg [1:0] src1_mux, src2_mux;
	
	always@(*)
	begin
		if(EX_MEM_RegWrite) begin //forward from EX_MEM
			if(ID_EX_RS==EX_MEM_RD)
				src1_mux = 2'b01; //rs
			else
				src2_mux = 2'b01; //rt
		end
		else if(MEM_WB_RegWrite) begin //forward from MEM_WB
			if(ID_EX_RS==MEM_WB_RD)
				src1_mux = 2'b10; //rs
			else
				src2_mux = 2'b10; //rt
		end
		else begin//without forwarding
			src1_mux = 2'b00;
			src2_mux = 2'b00; 
		end
	end
endmodule
