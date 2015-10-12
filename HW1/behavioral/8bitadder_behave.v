module adder_beh ( output reg [7: 0] dout, output reg cout, input [7:0] din1, din2, input cin);
  always@(din1 or din2 or cin)
  begin
    {cout,dout}=din1+din2+cin;
  end
endmodule
