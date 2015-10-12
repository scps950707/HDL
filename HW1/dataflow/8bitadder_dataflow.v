module adder_dataflow ( output [7: 0] dout, output cout, input [7:0] din1, din2, input cin);
  assign {cout,dout}=din1+din2+cin;
endmodule
