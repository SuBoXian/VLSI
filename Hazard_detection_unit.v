`include "def.v"
//`define REGISTER_BITS 5

module Hazard_detection_unit(IF_ID_RS,
							 IF_ID_RT,
							 ID_EX_RT,
							 ID_EX_RD,
							 EX_MEM_RT,
							 ID_EX_MemRead,
							 ID_EX_RegWrite,
							 EX_MEM_MemRead,
							 IF_ID_Branch,
							 EX_MEM_RT,
							 Hold,
							 ID_Flush,
							 EX_Flush
							 );
	
	input ID_EX_MemRead, ID_EX_RegWrite, IF_ID_Branch, EX_MEM_MemRead;
	input [`REGISTER_BITS-1:0] IF_ID_RS, IF_ID_RT, ID_EX_RT, ID_EX_RD, EX_MEM_RT;
	output reg Hold, ID_Flush, EX_Flush;
	
	//data hazard for lw , RT is the destination of lw
	always@(*)
	begin
		if(ID_EX_MemRead && ((IF_ID_RS==ID_EX_RT) || (IF_ID_RT==ID_EX_RT)) ) begin
			//lw before R-type or lw before branch
			Hold = 1'b1;
			ID_Flush = 1'b1; //ID_EX_MemRead = 0 next cycle
			EX_Flush = 1'b0;
		end
		else if(EX_MEM_MemRead && IF_ID_Branch && ((IF_ID_RS==EX_MEM_RT) || (IF_ID_RT==EX_MEM_RT)) ) begin
			//lw before before branch
			Hold = 1'b1;
			ID_Flush = 1'b0;
			EX_Flush = 1'b1;
		end
		else if(ID_EX_RegWrite && ((IF_ID_RS==ID_EX_RD) || (IF_ID_RT==ID_EX_RD)) ) begin
			//R-type before branch
			Hold = 1'b1;
			ID_Flush = 1'b1;
			EX_Flush = 1'b0;
		end
		else begin
			Hold = 1'b0;
			ID_Flush = 1'b0;
			EX_Flush = 1'b0;
		end
	end

endmodule
