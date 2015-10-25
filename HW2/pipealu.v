module pipealu(instr,AluOut, Zero,clk,Carryout,Overflow);
	input [15:0] instr;
	input clk;
	output reg [31:0] AluOut;
	output reg Zero;
	output reg Carryout;
	output reg Overflow;
	reg [31:0] tempA;
	reg [31:0] tempB;
	reg [31:0] data[15:0];
	reg [3:0] opcode;
	reg [3:0] dest;
	reg [31:0] regfile[15:0];

	
	initial begin
		regfile[0] = 32'hABCDEF12;
		regfile[1] = 32'h98765432;
		regfile[2] = 15;
		regfile[3] = 20;
		regfile[4] = $random;
		regfile[5] = $random;
		regfile[6] = $random;
		regfile[7] = $random;
		regfile[8] = $random;
		regfile[9] = $random;
		regfile[10] = $random;
		regfile[11] = $random;
		regfile[12] = $random;
		regfile[13] = $random;
		regfile[14] = $random;
		regfile[15] = $random;
		Carryout = 0;
		Zero = 0;
		Overflow = 0;
	end
	
	always@(posedge clk)
	begin
		opcode <= instr[15:12];
		tempA <= regfile[instr[11:8]];
		tempB <= regfile[instr[7:4]];
		dest <= instr[3:0];
	end
	
	always@(posedge clk)
	begin
		case(opcode)
			0: {Carryout,AluOut} = tempA & tempB;
			1: {Carryout,AluOut} = tempA | tempB;
			2: 
			begin
				{Carryout,AluOut} = tempA + tempB;
				Overflow=((!tempA[31:31]&!tempB[31:31])&AluOut[31:31])
				        |((tempA[31:31]&tempB[31:31])&!AluOut[31:31]);
			end
			6: 
			begin
				{Carryout,AluOut} = tempA - tempB;
				Overflow=((tempA[31:31]&!tempB[31:31])&!AluOut[31:31])
						|((!tempA[31:31]&tempB[31:31])&AluOut[31:31]);
			end
			7: {Carryout,AluOut} = tempA < tempB ? 1 : 0;
			12: {Carryout,AluOut} = ~(tempA | tempB);
			default: {Carryout,AluOut} = 0;
		endcase
		regfile[dest]=AluOut;
		Zero = (AluOut==0);
	end
	
endmodule
