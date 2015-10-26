`timescale 1ns/1ps
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
		regfile[4] = 0;
		regfile[5] = 32'h40000000;
		regfile[6] = 32'h40000000;
		regfile[7] = 32'h40000000;
		regfile[8] = 32'hc0000000;
		regfile[9] = 5;
		regfile[10] = 6;
		regfile[11] = 100;
		regfile[12] = 8;
		regfile[13] = 99;
		regfile[14] = 5;
		regfile[15] = 18;
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
			0: 
			begin
				{Carryout,AluOut} = tempA & tempB;
				Overflow = 0;
			end 
			1: 
			begin
				{Carryout,AluOut} = tempA | tempB;
				Overflow = 0;
			end
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
			7:
			begin
				{Carryout,AluOut} = tempA < tempB ? 1 : 0;
				Overflow = 0;
			end
			12:
			begin
				{Carryout,AluOut} = ~(tempA | tempB);
				Overflow = 0;
			end
			default:
			begin
				{Carryout,AluOut} = 0;
				Overflow = 0;
			end
		endcase
		regfile[dest]=AluOut;
		Zero = (AluOut==0);
	end
	
endmodule
