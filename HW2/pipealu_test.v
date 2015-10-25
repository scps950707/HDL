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
		instr = 16'b0010000000011111;//add
		clk = 0;
		#4;
		clk = 1;
		#4;
		instr = 16'b0110000000011111;//sub
		clk = 0;
		#4;
		clk = 1;
		#4;
		instr = 16'b0000000000011111;//and
		clk = 0;
		#4;
		clk = 1;
		#4;
		instr = 16'b0001000000011111;//or
		clk = 0;
		#4;
		clk = 1;
		#4;
		instr = 16'b0111000000011111;//slt
		clk = 0;
		#4;
		clk = 1;
		#4;
		instr = 16'b1100000000011111;//nor
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