module testbench_dff;

	// Inputs
	reg [7:0] din1;
	reg [7:0] din2;
	reg cin;
	reg clk;

	// Outputs
	wire [7:0] structure_dout;
	wire [7:0] dataflow_dout;
	wire [7:0] behave_dout;
	wire structure_cout;
	wire dataflow_cout;
	wire behave_cout;
	

always 
	begin
	clk = 0; #5;
	clk = 1; #5;
	end

	// Instantiate the Unit Under Test (UUT)
	adder_struct_dff test_struct_dff (
		.dout(structure_dout), 
		.cout(structure_cout), 
		.din1(din1), 
		.din2(din2),
		.cin(cin),
		.clk(clk)
	);
	adder_dataflow_dff test_dataflow_dff (
		.dout(dataflow_dout), 
		.cout(dataflow_cout), 
		.din1(din1), 
		.din2(din2),
		.cin(cin),
		.clk(clk)
	);
	
	adder_beh_dff test_behave_dff (
		.dout(behave_dout), 
		.cout(behave_cout), 
		.din1(din1), 
		.din2(din2),
		.cin(cin),
		.clk(clk)
	);

	initial begin
	  din1 = 8'b01111111;
	  din2 = 8'b01111111;
	  cin = 0;
	  #5;
	  din1 = $random;
	  din2 = $random;
	  cin = 0;
	  #5;
    din1 = $random;
	  din2 = $random;
	  cin = 0;
	  #5;din1 = $random;
	  din2 = $random;
	  cin = 0;
	  #5;
	  din1 = $random;
	  din2 = $random;
	  cin = 0;
	  #5;
	  din1 = $random;
	  din2 = $random;
	  cin = 0;
	  #5;
	  din1 = $random;
	  din2 = $random;
	  cin = 0;
	  #5;
	  $finish;
	end
      
endmodule