module pipealu(instr,AluOut, Zero,clk,Carryout,Overflow,rst);
	input [15:0] instr;
	input clk;
	input rst;
	output reg [31:0] AluOut;
	output Zero;
	output reg Carryout;
	output reg Overflow;
	reg [31:0] pipeA;
	reg [31:0] pipeB;
	reg [3:0] ALU_ctl;
	reg [3:0] dest;
	reg [3:0] pipedest;
	reg [31:0] regfile[15:0];
	
	always@(posedge clk or negedge rst)//first stage
	begin
	if(!rst)
		begin
			regfile[0] <= 32'd1;
			regfile[1] <= 32'd2;
			regfile[2] <= 32'd3;
			regfile[3] <= 32'd4;
			regfile[4] <= 32'd5;
			regfile[5] <= 32'd6;
			regfile[6] <= 32'd7;
			regfile[7] <= 32'd8;
			regfile[8] <= 32'd9;
			regfile[9] <= 32'd10;
			regfile[10] <= 32'd11;
			regfile[11] <= 32'd12;
			regfile[12] <= 32'd13;
			regfile[13] <= 32'd14;
			regfile[14] <= 32'd15;
			regfile[15] <= 32'd16;
		end
	else
		begin
			regfile[pipedest] <= AluOut;
			ALU_ctl <= instr[15:12];
			pipeA <= regfile[instr[11:8]];
			pipeB <= regfile[instr[7:4]];
			dest <= instr[3:0];
		end
	end
	
	assign Zero = (AluOut==0);
	
	always@(posedge clk)
	begin
		pipedest <= dest;
		case(ALU_ctl)
			0: 
			begin
				AluOut = pipeA & pipeB;
				Carryout = 0;
				Overflow = 0;
			end 
			1: 
			begin
				AluOut = pipeA | pipeB;
				Carryout = 0;
				Overflow = 0;
			end
			2: 
			begin
				{Carryout,AluOut} = pipeA + pipeB;
				Overflow = Carryout ^ AluOut[31];
			end
			6: 
			begin
				{Carryout,AluOut} = pipeA - pipeB;
				Overflow=((pipeA[31]&!pipeB[31])&!AluOut[31])
						|((!pipeA[31]&pipeB[31])&AluOut[31])
						|Carryout&AluOut[31];
			end
			7:
			begin
				AluOut = pipeA < pipeB ? 1 : 0;
				Carryout = 0;
				Overflow = 0;
			end
			12:
			begin
				AluOut = ~(pipeA | pipeB);
				Carryout = 0;
				Overflow = 0;
			end
			default:
			begin
				AluOut = 0;
				Carryout = 0;
				Overflow = 0;
			end
		endcase
	end
	
endmodule
