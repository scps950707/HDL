module half_adder (output S, C, input x, y);
xor (S, x, y);
and (C, x, y);
endmodule

module full_adder (output S, C, input x, y, z);
wire S1, C1, C2;
half_adder HA1 (S1, C1, x, y);
half_adder HA2 (S, C2, S1, z);
or G1 (C, C2, C1);
endmodule

module adder_struct ( output [7: 0] dout, output cout, input [7:0] din1, din2, input cin);
wire C1, C2, C3, C4, C5, C6, C7; // Intermediate carries
full_adder FA0 (dout[0], C1, din1[0], din2[0], cin),
FA1 (dout[1], C2, din1[1], din2[1], C1),
FA2 (dout[2], C3, din1[2], din2[2], C2),
FA3 (dout[3], C4, din1[3], din2[3], C3),
FA4 (dout[4], C5, din1[4], din2[4], C4),
FA5 (dout[5], C6, din1[5], din2[5], C5),
FA6 (dout[6], C7, din1[6], din2[6], C6),
FA7 (dout[7], cout, din1[7], din2[7], C7);
endmodule
