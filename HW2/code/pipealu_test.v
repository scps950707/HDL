module pipealu_test;
	//input
	reg [15:0] instr;
	reg clk;
	//output
	wire [31:0] AluOut;
	wire Zero;
	wire Carryout;
	wire Overflow;

	pipealu test
	(
		.instr(instr),
		.AluOut(AluOut),
		.Zero(Zero),
		.clk(clk),
		.Carryout(Carryout),
		.Overflow(Overflow)
	);
	
	initial begin
		instr = 16'b0010000000011111;//add r15 = r0+r1  (test add overflow)
		clk = 0;
		#4;
		clk = 1;
		#4;
		instr = 16'b0110000000011111;//sub r15 = r0-r1
		clk = 0;
		#4;
		clk = 1;
		#4;
		instr = 16'b0000000000011111;//and r15 = r0&r1
		clk = 0;
		#4;
		clk = 1;
		#4;
		instr = 16'b0001000000011111;//or r15 = r0|r1
		clk = 0;
		#4;
		clk = 1;
		#4;
		instr = 16'b0111000000011111;//slt r15 = r0 slt r1
		clk = 0;
		#4;
		clk = 1;
		#4;
		instr = 16'b1100000000011111;//nor r15 = r0 nor r1
		clk = 0;
		#4;
		clk = 1;
		#4;
		instr = 16'b0010010101101111;//add r15 = r5+r6 (test add overflow)
		clk = 0;
		#4;
		clk = 1;
		#4;
		clk = 0;
		#4;
		clk = 1;
		#4;
		instr = 16'b0110011110001111;//sub r15 = r7-r8 (test sub overflow)
		clk = 0;
		#4;
		clk = 1;
		#4;
		instr = 16'b0010110011011111;//add r15 = r0+r1
		clk = 0;
		#4;
		clk = 1;
		#4;
		clk = 0;
		#4;
		clk = 1;
		#4;
		clk = 0;
		#4;
		clk = 1;
		#4;
		$finish;
	end


endmodule