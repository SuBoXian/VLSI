`include "def.v"
//`define DATA_BITS 32
//`define INTERNAL_BITS 16
//`define ALUOP_BITS 2
//`define ALUCONTROL_BITS 4
//`define FUNCTIONCODE_BITS 6

module ALUcontroller(
	ALUop,
	FUNCTION,
	ALUcontrol
);
	parameter AND = 4'b0000,
			  OR  = 4'b0001,
			  ADD = 4'b0010,
			  SUB = 4'b0110,
			  SLT = 4'b0111,
			  MUL = 4'b1000,
			  NOR = 4'b1100;
	
	input [`ALUOP_BITS-1:0] ALUop;
	input [`FUNCTIONCODE_BITS-1:0] FUNCTION;
	output [`ALUCONTROL_BITS-1:0] ALUcontrol;
	
	always@(*) begin
		case(ALUop)
			2'b00:ALUcontrol = ADD;
			
			2'b01:ALUcontrol = SUB;

			2'b10:begin //R type
					case(FUNCTION)
						6'd24:ALUcontrol = MUL;
						6'd32:ALUcontrol = ADD;
						6'd34:ALUcontrol = SUB;
						6'd36:ALUcontrol = AND;
						6'd37:ALUcontrol = OR;
						6'd39:ALUcontrol = NOR;
						6'd42:ALUcontrol = SLT;
					endcase
				end
			default:begin
						ALUcontrol = 4'b1111;
					end
		endcase
	end
endmodule
