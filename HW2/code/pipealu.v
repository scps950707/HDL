module pipealu(instr,AluOut, Zero,clk,Carryout,Overflow,rst);
	input [15:0] instr;
	input clk;
	input rst;
	output reg [31:0] AluOut;
	output Zero;
	output reg Carryout;
	output reg Overflow;
	reg [31:0] IFID_A;
	reg [31:0] IFID_B;
	reg [3:0] IFID_ALU_ctl;
	reg [3:0] IFID_dest;
	reg [31:0] EX_A;
	reg [31:0] EX_B;
	reg [3:0] EX_ALU_ctl;
	reg [3:0] EX_dest;
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
			regfile[EX_dest] <= AluOut;
			IFID_ALU_ctl <= instr[15:12];
			IFID_A <= regfile[instr[11:8]];
			IFID_B <= regfile[instr[7:4]];
			IFID_dest <= instr[3:0];
		end
	end
	
	assign Zero = (AluOut==0);
	
	always@(posedge clk)
	begin
		EX_ALU_ctl = IFID_ALU_ctl;
		EX_A = IFID_A;
		EX_B = IFID_B;
		EX_dest = IFID_dest;
		case(IFID_ALU_ctl)
			0: 
			begin
				AluOut = EX_A & EX_B;
				Carryout = 0;
				Overflow = 0;
			end 
			1: 
			begin
				AluOut = EX_A | EX_B;
				Carryout = 0;
				Overflow = 0;
			end
			2: 
			begin
				{Carryout,AluOut} = EX_A + EX_B;
				Overflow = Carryout ^ AluOut[31];
			end
			6: 
			begin
				{Carryout,AluOut} = EX_A - EX_B;
				Overflow=((EX_A[31]&!EX_B[31])&!AluOut[31])
						|((!EX_A[31]&EX_B[31])&AluOut[31])
						|Carryout&AluOut[31];
			end
			7:
			begin
				AluOut = EX_A < EX_B ? 1 : 0;
				Carryout = 0;
				Overflow = 0;
			end
			12:
			begin
				AluOut = ~(EX_A | EX_B);
				Carryout = 0;
				Overflow = 0;
			end
			default:
			begin
				Carryout = 0;
				Overflow = 0;
			end
		endcase
	end
	
endmodule
