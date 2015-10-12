module adder_dataflow_dff
(	output [7:0]dout,output cout,input [7:0]din1,input [7:0]din2,input cin,input clk);
	wire [7:0] dout_temp;
	wire cout_temp;
	adder_dataflow addder(dout_temp,cout_temp,din1,din2,cin);
	D_FF	dff0(dout[0],dout_temp[0],clk),
			dff1(dout[1],dout_temp[1],clk),
			dff2(dout[2],dout_temp[2],clk),
			dff3(dout[3],dout_temp[3],clk),
			dff4(dout[4],dout_temp[4],clk),
			dff5(dout[5],dout_temp[5],clk),
			dff6(dout[6],dout_temp[6],clk),
			dff7(dout[7],dout_temp[7],clk),
			dff8(cout,cout_temp,clk);
endmodule