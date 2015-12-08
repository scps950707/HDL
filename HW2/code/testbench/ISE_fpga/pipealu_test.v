`timescale 1ns/1ps
module pipealu_test;
	//input
	reg [15:0] instr;
	reg clk;
	reg rst;
	//output
	wire [31:0] AluOut;
	wire Zero;
	wire Carryout;
	wire Overflow;

	pipealu test
	(
		.instr(instr),
		.clk(clk),
		.rst(rst),
		.AluOut(AluOut),
		.Zero(Zero),
		.Carryout(Carryout),
		.Overflow(Overflow)
	);
	
initial begin
clk = 1'b0;
forever #10 clk = ~clk ;
end
	
initial begin
	rst = 0;
	#10;
	rst = 1;
	instr = 16'h0562;//R2 = R5 & R6
	#200;
	instr = 16'h1345;//R5 = R4 | R3
	#40;
	instr = 16'h2678;//R8 = R6 + R7
	#40;
	instr = 16'h69ab;//R11 = R10 -R9
	#40;
	instr = 16'h7cde;//R14 = a(R12)<b(R13) ? 1 : 0
	#40;
	instr = 16'hccef;//R15 = R12 nor R14
	#40;
	instr = 16'h654d;//R13 = R4 - R5 = 0
	#120;
	$stop;
end		

endmodule