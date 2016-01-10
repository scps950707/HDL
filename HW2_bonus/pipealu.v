module pipealu(instr,AluOut, Zero,clk,Carryout,Overflow,
				rst,read_data_n, write_data_n,
				data_address, data);
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
	reg [3:0] EX_ALU_ctl;
	reg [3:0] IFID_dest;
	reg [3:0] EX_dest;
	reg [3:0] str_addr;
	reg [31:0] regfile[15:0];
	integer i;
	assign Zero = (AluOut==0);
	
	output read_data_n;     // enable read from data memory
    output write_data_n;    // enable write to data memory
    output [31:0] data_address; // address of data
    inout [31:0] data;          // current data
	reg read_data_n, write_data_n;
	reg [31:0] data_address;
	wire [31:0] data;
	reg [31:0] DR;        // holds data to be output
	assign data = (~write_data_n) ? DR : 'bz;  // tri-state data
	
	
	always@(posedge clk)//ID stage
	begin
		IFID_ALU_ctl <= instr[15:12];
		IFID_A <= regfile[instr[11:8]];
		IFID_B <= regfile[instr[7:4]];
		str_addr <= instr[7:4];
		IFID_dest <= instr[3:0];
	end

	always@(posedge clk)//EX
	begin
		read_data_n <= 1'b1;   // set default values for data mem.
        write_data_n <= 1'b1;
		case(IFID_ALU_ctl)
			0: 
			begin
				AluOut <= IFID_A & IFID_B;
				Carryout <= 0;
				Overflow <= 0;
			end 
			1: 
			begin
				AluOut <= IFID_A | IFID_B;
				Carryout <= 0;
				Overflow <= 0;
			end
			2: 
			begin
				{Carryout,AluOut} <= IFID_A + IFID_B;
				Overflow <= Carryout ^ AluOut[31];
			end
			6: 
			begin
				{Carryout,AluOut} <= IFID_A - IFID_B;
				Overflow<=((IFID_A[31]&!IFID_B[31])&!AluOut[31])
						|((!IFID_A[31]&IFID_B[31])&AluOut[31])
						|Carryout&AluOut[31];
			end
			7:
			begin
				AluOut <= IFID_A < IFID_B ? 1 : 0;
				Carryout <= 0;
				Overflow <= 0;
			end
			12:
			begin
				AluOut <= ~(IFID_A | IFID_B);
				Carryout <= 0;
				Overflow <= 0;
			end
			13://LDR
			begin
				read_data_n <= 1'b0;
				data_address <= IFID_dest;
			end
			14://STR
			begin
				write_data_n <= 1'b0;
				data_address <= IFID_dest;
				DR <= regfile[str_addr];
			end
			15://nop
			begin
				
			end
			default:
			begin
				AluOut <= 32'bz;
				Carryout <= 0;
				Overflow <= 0;
			end
		endcase
		EX_dest <= IFID_dest;
		EX_ALU_ctl <= IFID_ALU_ctl;
	end
	
	always@(posedge clk or negedge rst)//WB
	begin
		if(~rst)
		begin
			for(i=0;i<16;i=i+1)
			begin
				regfile[i]<=32'dz;
			end
		end
		else
		begin
			if(EX_ALU_ctl==13)
				regfile[EX_dest] <=data;
			else
				if(EX_ALU_ctl!=14)
					regfile[EX_dest] <= AluOut;
		end
	end
	
endmodule
