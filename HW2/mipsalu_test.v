module mipsalu_test;
	//input
	reg [3:0] ALUctl;
	reg [31:0] A; 
	reg [31:0] B;
	reg clk;
	//output
	wire [31:0] ALUOut;
	wire Zero;
	
	MIPSALU test
	(
		.ALUctl(ALUctl),
		.A(A),
		.B(B),
		.ALUOut(ALUOut),
		.Zero(Zero)
	);

	initial begin
		ALUctl = 4'b0000;
		A = 32'b00000000000000000000000000010110;
		B = 32'b00000000000000000000000000011111;
		#5;
		ALUctl = 4'b0010;
		A = 32'b00000000000000000000000000000001;
		B = 32'b00000000000000000000000000000001;
		#5;
		$finish;
	end
	
endmodule