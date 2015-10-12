module testbench;

	// Inputs
	reg [7:0] din1;
	reg [7:0] din2;
	reg cin;

	// Outputs
	wire [7:0] structure_dout;
	wire [7:0] dataflow_dout;
	wire [7:0] behave_dout;
	wire structure_cout;
	wire dataflow_cout;
	wire behave_cout;

	// Instantiate the Unit Under Test (UUT)
	adder_struct test_struct (
		.dout(structure_dout), 
		.cout(structure_cout), 
		.din1(din1), 
		.din2(din2),
		.cin(cin)
	);
	adder_dataflow test_dataflow (
		.dout(dataflow_dout), 
		.cout(dataflow_cout), 
		.din1(din1), 
		.din2(din2),
		.cin(cin)
	);
	
	adder_beh test_behave (
		.dout(behave_dout), 
		.cout(behave_cout), 
		.din1(din1), 
		.din2(din2),
		.cin(cin)
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
