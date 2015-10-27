
module pipealu_DW_cmp_0 ( A, B, TC, GE_LT, GE_GT_EQ, GE_LT_GT_LE, EQ_NE );
  input [31:0] A;
  input [31:0] B;
  input TC, GE_LT, GE_GT_EQ;
  output GE_LT_GT_LE, EQ_NE;
  wire   n221, n222, n223, n224, n225, n226, n227, n228, n229, n230, n231,
         n232, n233, n234, n235, n236, n237, n238, n239, n240, n241, n242,
         n243, n244, n245, n246, n247, n248, n249, n250, n251, n252, n253,
         n254, n255, n256, n257, n258, n259, n260, n261, n262, n263, n264,
         n265, n266, n267, n268, n269, n270, n271, n272, n273, n274, n275,
         n276, n277, n278, n279, n280, n281, n282, n283, n284, n285, n286,
         n287, n288, n289, n290, n291, n292, n293, n294, n295, n296, n297,
         n298, n299, n300, n301, n302, n303, n304, n305, n306, n307, n308,
         n309, n310, n311, n312, n313, n314, n315, n316, n317, n318, n319,
         n320, n321, n322, n323, n324, n325, n326, n327, n328, n329, n330,
         n331, n332, n333, n334, n335, n336;

  INVX0 U152 ( .INP(n278), .ZN(n230) );
  INVX0 U153 ( .INP(n308), .ZN(n238) );
  INVX0 U154 ( .INP(n316), .ZN(n225) );
  INVX0 U155 ( .INP(n299), .ZN(n243) );
  INVX0 U156 ( .INP(n289), .ZN(n232) );
  INVX0 U157 ( .INP(A[15]), .ZN(n254) );
  INVX0 U158 ( .INP(A[11]), .ZN(n256) );
  INVX0 U159 ( .INP(B[13]), .ZN(n234) );
  INVX0 U160 ( .INP(B[9]), .ZN(n237) );
  INVX0 U161 ( .INP(A[10]), .ZN(n257) );
  INVX0 U162 ( .INP(A[14]), .ZN(n255) );
  INVX0 U163 ( .INP(A[18]), .ZN(n253) );
  INVX0 U164 ( .INP(B[5]), .ZN(n241) );
  INVX0 U165 ( .INP(B[3]), .ZN(n244) );
  INVX0 U166 ( .INP(B[24]), .ZN(n226) );
  INVX0 U167 ( .INP(B[29]), .ZN(n222) );
  INVX0 U168 ( .INP(B[27]), .ZN(n224) );
  INVX0 U169 ( .INP(B[4]), .ZN(n242) );
  INVX0 U170 ( .INP(n300), .ZN(n240) );
  INVX0 U171 ( .INP(B[12]), .ZN(n236) );
  INVX0 U172 ( .INP(B[16]), .ZN(n233) );
  INVX0 U173 ( .INP(B[20]), .ZN(n228) );
  INVX0 U174 ( .INP(B[8]), .ZN(n239) );
  INVX0 U175 ( .INP(A[2]), .ZN(n259) );
  INVX0 U176 ( .INP(A[28]), .ZN(n247) );
  INVX0 U177 ( .INP(n331), .ZN(n223) );
  INVX0 U178 ( .INP(A[25]), .ZN(n248) );
  INVX0 U179 ( .INP(n277), .ZN(n235) );
  INVX0 U180 ( .INP(n276), .ZN(n231) );
  INVX0 U181 ( .INP(B[21]), .ZN(n227) );
  INVX0 U182 ( .INP(A[19]), .ZN(n252) );
  INVX0 U183 ( .INP(B[17]), .ZN(n229) );
  INVX0 U184 ( .INP(A[31]), .ZN(n246) );
  INVX0 U185 ( .INP(A[1]), .ZN(n260) );
  INVX0 U186 ( .INP(A[6]), .ZN(n258) );
  INVX0 U187 ( .INP(A[21]), .ZN(n251) );
  INVX0 U188 ( .INP(A[22]), .ZN(n250) );
  INVX0 U189 ( .INP(B[30]), .ZN(n221) );
  INVX0 U190 ( .INP(A[23]), .ZN(n249) );
  INVX0 U191 ( .INP(B[0]), .ZN(n245) );
  AO21X1 U192 ( .IN1(B[31]), .IN2(n246), .IN3(n261), .Q(GE_LT_GT_LE) );
  OA222X1 U193 ( .IN1(B[31]), .IN2(n246), .IN3(n262), .IN4(n263), .IN5(n264), 
        .IN6(n265), .Q(n261) );
  OR3X1 U194 ( .IN1(n266), .IN2(n267), .IN3(n268), .Q(n265) );
  NAND4X0 U195 ( .IN1(n269), .IN2(n270), .IN3(n271), .IN4(n272), .QN(n264) );
  OR2X1 U196 ( .IN1(n229), .IN2(A[17]), .Q(n272) );
  NAND2X0 U197 ( .IN1(n230), .IN2(n273), .QN(n270) );
  NAND4X0 U198 ( .IN1(n235), .IN2(n231), .IN3(n274), .IN4(n275), .QN(n273) );
  OR2X1 U199 ( .IN1(n237), .IN2(A[9]), .Q(n275) );
  AO221X1 U200 ( .IN1(n279), .IN2(n280), .IN3(n281), .IN4(n282), .IN5(n278), 
        .Q(n269) );
  NAND2X0 U201 ( .IN1(n283), .IN2(n284), .QN(n278) );
  AO221X1 U202 ( .IN1(n285), .IN2(n277), .IN3(n286), .IN4(n285), .IN5(n276), 
        .Q(n284) );
  NAND3X0 U203 ( .IN1(n287), .IN2(n288), .IN3(n232), .QN(n276) );
  OR2X1 U204 ( .IN1(n234), .IN2(A[13]), .Q(n288) );
  OA21X1 U205 ( .IN1(B[10]), .IN2(n257), .IN3(n290), .Q(n286) );
  NAND3X0 U206 ( .IN1(n274), .IN2(n237), .IN3(A[9]), .QN(n290) );
  NAND2X0 U207 ( .IN1(B[10]), .IN2(n257), .QN(n274) );
  AO21X1 U208 ( .IN1(B[11]), .IN2(n256), .IN3(n291), .Q(n277) );
  AOI22X1 U209 ( .IN1(A[12]), .IN2(n236), .IN3(n292), .IN4(A[11]), .QN(n285)
         );
  NOR2X0 U210 ( .IN1(B[11]), .IN2(n291), .QN(n292) );
  NOR2X0 U211 ( .IN1(n236), .IN2(A[12]), .QN(n291) );
  AO22X1 U212 ( .IN1(n293), .IN2(n294), .IN3(n294), .IN4(n289), .Q(n283) );
  AO21X1 U213 ( .IN1(B[15]), .IN2(n254), .IN3(n295), .Q(n289) );
  AOI22X1 U214 ( .IN1(A[16]), .IN2(n233), .IN3(n296), .IN4(A[15]), .QN(n294)
         );
  NOR2X0 U215 ( .IN1(B[15]), .IN2(n295), .QN(n296) );
  NOR2X0 U216 ( .IN1(n233), .IN2(A[16]), .QN(n295) );
  OA21X1 U217 ( .IN1(B[14]), .IN2(n255), .IN3(n297), .Q(n293) );
  NAND3X0 U218 ( .IN1(n287), .IN2(n234), .IN3(A[13]), .QN(n297) );
  NAND2X0 U219 ( .IN1(B[14]), .IN2(n255), .QN(n287) );
  OA221X1 U220 ( .IN1(n298), .IN2(n299), .IN3(A[4]), .IN4(n242), .IN5(n240), 
        .Q(n282) );
  AOI21X1 U221 ( .IN1(n259), .IN2(B[2]), .IN3(n301), .QN(n298) );
  NOR2X0 U222 ( .IN1(n302), .IN2(n303), .QN(n281) );
  OA221X1 U223 ( .IN1(n304), .IN2(n305), .IN3(B[1]), .IN4(n260), .IN5(n243), 
        .Q(n302) );
  AO22X1 U224 ( .IN1(A[3]), .IN2(n244), .IN3(n306), .IN4(A[2]), .Q(n299) );
  NOR2X0 U225 ( .IN1(B[2]), .IN2(n301), .QN(n306) );
  NOR2X0 U226 ( .IN1(n244), .IN2(A[3]), .QN(n301) );
  NOR2X0 U227 ( .IN1(A[0]), .IN2(n245), .QN(n305) );
  AND2X1 U228 ( .IN1(n260), .IN2(B[1]), .Q(n304) );
  NAND2X0 U229 ( .IN1(n238), .IN2(n303), .QN(n280) );
  AO21X1 U230 ( .IN1(B[6]), .IN2(n258), .IN3(n307), .Q(n303) );
  AO221X1 U231 ( .IN1(A[5]), .IN2(n241), .IN3(n309), .IN4(A[4]), .IN5(n308), 
        .Q(n279) );
  AO22X1 U232 ( .IN1(A[8]), .IN2(n239), .IN3(n310), .IN4(A[6]), .Q(n308) );
  NOR2X0 U233 ( .IN1(B[6]), .IN2(n307), .QN(n310) );
  NOR2X0 U234 ( .IN1(n239), .IN2(A[8]), .QN(n307) );
  NOR2X0 U235 ( .IN1(B[4]), .IN2(n300), .QN(n309) );
  NOR2X0 U236 ( .IN1(n241), .IN2(A[5]), .QN(n300) );
  OA221X1 U237 ( .IN1(n267), .IN2(n311), .IN3(n312), .IN4(n313), .IN5(n314), 
        .Q(n263) );
  OA221X1 U238 ( .IN1(n251), .IN2(n315), .IN3(B[22]), .IN4(n250), .IN5(n225), 
        .Q(n313) );
  NAND2X0 U239 ( .IN1(n317), .IN2(n227), .QN(n315) );
  NOR2X0 U240 ( .IN1(n318), .IN2(n316), .QN(n312) );
  AO22X1 U241 ( .IN1(A[24]), .IN2(n226), .IN3(n319), .IN4(A[23]), .Q(n316) );
  NOR2X0 U242 ( .IN1(B[23]), .IN2(n320), .QN(n319) );
  AO22X1 U243 ( .IN1(n321), .IN2(n322), .IN3(n322), .IN4(n268), .Q(n311) );
  AO21X1 U244 ( .IN1(B[19]), .IN2(n252), .IN3(n323), .Q(n268) );
  AOI22X1 U245 ( .IN1(A[20]), .IN2(n228), .IN3(n324), .IN4(A[19]), .QN(n322)
         );
  NOR2X0 U246 ( .IN1(B[19]), .IN2(n323), .QN(n324) );
  NOR2X0 U247 ( .IN1(n228), .IN2(A[20]), .QN(n323) );
  OA21X1 U248 ( .IN1(B[18]), .IN2(n253), .IN3(n325), .Q(n321) );
  NAND3X0 U249 ( .IN1(n271), .IN2(n229), .IN3(A[17]), .QN(n325) );
  NAND2X0 U250 ( .IN1(B[18]), .IN2(n253), .QN(n271) );
  NAND3X0 U251 ( .IN1(n317), .IN2(n326), .IN3(n318), .QN(n267) );
  AOI21X1 U252 ( .IN1(B[23]), .IN2(n249), .IN3(n320), .QN(n318) );
  NOR2X0 U253 ( .IN1(n226), .IN2(A[24]), .QN(n320) );
  NAND2X0 U254 ( .IN1(B[21]), .IN2(n251), .QN(n326) );
  NAND2X0 U255 ( .IN1(B[22]), .IN2(n250), .QN(n317) );
  AND2X1 U256 ( .IN1(n266), .IN2(n314), .Q(n262) );
  AOI22X1 U257 ( .IN1(A[30]), .IN2(n221), .IN3(n327), .IN4(n328), .QN(n314) );
  AO221X1 U258 ( .IN1(A[27]), .IN2(n224), .IN3(n329), .IN4(A[25]), .IN5(n330), 
        .Q(n328) );
  NOR2X0 U259 ( .IN1(B[25]), .IN2(n331), .QN(n329) );
  OA21X1 U260 ( .IN1(n332), .IN2(n330), .IN3(n333), .Q(n327) );
  AO22X1 U261 ( .IN1(A[29]), .IN2(n222), .IN3(n334), .IN4(A[28]), .Q(n330) );
  NOR2X0 U262 ( .IN1(B[28]), .IN2(n335), .QN(n334) );
  NAND4X0 U263 ( .IN1(n332), .IN2(n333), .IN3(n223), .IN4(n336), .QN(n266) );
  NAND2X0 U264 ( .IN1(B[25]), .IN2(n248), .QN(n336) );
  NOR2X0 U265 ( .IN1(n224), .IN2(A[27]), .QN(n331) );
  OR2X1 U266 ( .IN1(n221), .IN2(A[30]), .Q(n333) );
  AOI21X1 U267 ( .IN1(B[28]), .IN2(n247), .IN3(n335), .QN(n332) );
  NOR2X0 U268 ( .IN1(n222), .IN2(A[29]), .QN(n335) );
endmodule


module pipealu_DW01_sub_0 ( A, B, CI, DIFF, CO );
  input [32:0] A;
  input [32:0] B;
  output [32:0] DIFF;
  input CI;
  output CO;
  wire   n1, n2, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n16, n17, n18,
         n19, n20, n21, n22, n23, n24, n25, n26, n27, n28, n29, n30, n31, n32,
         n33, n34, n35;
  wire   [33:0] carry;

  FADDX1 U2_31 ( .A(A[31]), .B(n6), .CI(carry[31]), .CO(carry[32]), .S(
        DIFF[31]) );
  FADDX1 U2_30 ( .A(A[30]), .B(n7), .CI(carry[30]), .CO(carry[31]), .S(
        DIFF[30]) );
  FADDX1 U2_29 ( .A(A[29]), .B(n8), .CI(carry[29]), .CO(carry[30]), .S(
        DIFF[29]) );
  FADDX1 U2_28 ( .A(A[28]), .B(n9), .CI(carry[28]), .CO(carry[29]), .S(
        DIFF[28]) );
  FADDX1 U2_27 ( .A(A[27]), .B(n10), .CI(carry[27]), .CO(carry[28]), .S(
        DIFF[27]) );
  FADDX1 U2_25 ( .A(A[25]), .B(n11), .CI(carry[25]), .CO(carry[27]), .S(
        DIFF[25]) );
  FADDX1 U2_24 ( .A(A[24]), .B(n12), .CI(carry[24]), .CO(carry[25]), .S(
        DIFF[24]) );
  FADDX1 U2_23 ( .A(A[23]), .B(n13), .CI(carry[23]), .CO(carry[24]), .S(
        DIFF[23]) );
  FADDX1 U2_22 ( .A(A[22]), .B(n14), .CI(carry[22]), .CO(carry[23]), .S(
        DIFF[22]) );
  FADDX1 U2_21 ( .A(A[21]), .B(n15), .CI(carry[21]), .CO(carry[22]), .S(
        DIFF[21]) );
  FADDX1 U2_20 ( .A(A[20]), .B(n16), .CI(carry[20]), .CO(carry[21]), .S(
        DIFF[20]) );
  FADDX1 U2_19 ( .A(A[19]), .B(n17), .CI(carry[19]), .CO(carry[20]), .S(
        DIFF[19]) );
  FADDX1 U2_18 ( .A(A[18]), .B(n18), .CI(carry[18]), .CO(carry[19]), .S(
        DIFF[18]) );
  FADDX1 U2_17 ( .A(A[17]), .B(n19), .CI(carry[17]), .CO(carry[18]), .S(
        DIFF[17]) );
  FADDX1 U2_16 ( .A(A[16]), .B(n20), .CI(carry[16]), .CO(carry[17]), .S(
        DIFF[16]) );
  FADDX1 U2_15 ( .A(A[15]), .B(n21), .CI(carry[15]), .CO(carry[16]), .S(
        DIFF[15]) );
  FADDX1 U2_14 ( .A(A[14]), .B(n22), .CI(carry[14]), .CO(carry[15]), .S(
        DIFF[14]) );
  FADDX1 U2_13 ( .A(A[13]), .B(n23), .CI(carry[13]), .CO(carry[14]), .S(
        DIFF[13]) );
  FADDX1 U2_12 ( .A(A[12]), .B(n24), .CI(carry[12]), .CO(carry[13]), .S(
        DIFF[12]) );
  FADDX1 U2_11 ( .A(A[11]), .B(n25), .CI(carry[11]), .CO(carry[12]), .S(
        DIFF[11]) );
  FADDX1 U2_10 ( .A(A[10]), .B(n26), .CI(carry[10]), .CO(carry[11]), .S(
        DIFF[10]) );
  FADDX1 U2_9 ( .A(A[9]), .B(n27), .CI(carry[9]), .CO(carry[10]), .S(DIFF[9])
         );
  FADDX1 U2_8 ( .A(A[8]), .B(n28), .CI(carry[8]), .CO(carry[9]), .S(DIFF[8])
         );
  FADDX1 U2_6 ( .A(A[6]), .B(n29), .CI(carry[6]), .CO(carry[8]), .S(DIFF[6])
         );
  FADDX1 U2_5 ( .A(A[5]), .B(n30), .CI(carry[5]), .CO(carry[6]), .S(DIFF[5])
         );
  FADDX1 U2_4 ( .A(A[4]), .B(n31), .CI(carry[4]), .CO(carry[5]), .S(DIFF[4])
         );
  FADDX1 U2_3 ( .A(A[3]), .B(n32), .CI(carry[3]), .CO(carry[4]), .S(DIFF[3])
         );
  FADDX1 U2_2 ( .A(A[2]), .B(n33), .CI(carry[2]), .CO(carry[3]), .S(DIFF[2])
         );
  FADDX1 U2_1 ( .A(A[1]), .B(n34), .CI(carry[1]), .CO(carry[2]), .S(DIFF[1])
         );
  INVX0 U1 ( .INP(carry[32]), .ZN(DIFF[32]) );
  INVX0 U2 ( .INP(carry[27]), .ZN(DIFF[26]) );
  INVX0 U3 ( .INP(carry[8]), .ZN(DIFF[7]) );
  INVX0 U4 ( .INP(B[25]), .ZN(n11) );
  INVX0 U5 ( .INP(B[6]), .ZN(n29) );
  INVX0 U6 ( .INP(B[2]), .ZN(n33) );
  INVX0 U7 ( .INP(B[23]), .ZN(n13) );
  INVX0 U8 ( .INP(B[28]), .ZN(n9) );
  INVX0 U9 ( .INP(B[9]), .ZN(n27) );
  INVX0 U10 ( .INP(B[13]), .ZN(n23) );
  INVX0 U11 ( .INP(B[17]), .ZN(n19) );
  INVX0 U12 ( .INP(B[11]), .ZN(n25) );
  INVX0 U13 ( .INP(B[15]), .ZN(n21) );
  INVX0 U14 ( .INP(B[19]), .ZN(n17) );
  INVX0 U15 ( .INP(B[5]), .ZN(n30) );
  INVX0 U16 ( .INP(B[30]), .ZN(n7) );
  INVX0 U17 ( .INP(B[3]), .ZN(n32) );
  INVX0 U18 ( .INP(B[24]), .ZN(n12) );
  INVX0 U19 ( .INP(B[29]), .ZN(n8) );
  INVX0 U20 ( .INP(B[4]), .ZN(n31) );
  INVX0 U21 ( .INP(B[12]), .ZN(n24) );
  INVX0 U22 ( .INP(B[16]), .ZN(n20) );
  INVX0 U23 ( .INP(B[20]), .ZN(n16) );
  INVX0 U24 ( .INP(B[1]), .ZN(n34) );
  NAND2X1 U25 ( .IN1(n1), .IN2(n2), .QN(carry[1]) );
  INVX0 U26 ( .INP(A[0]), .ZN(n1) );
  INVX0 U27 ( .INP(B[10]), .ZN(n26) );
  INVX0 U28 ( .INP(B[14]), .ZN(n22) );
  INVX0 U29 ( .INP(B[18]), .ZN(n18) );
  INVX0 U30 ( .INP(B[21]), .ZN(n15) );
  INVX0 U31 ( .INP(B[22]), .ZN(n14) );
  INVX0 U32 ( .INP(B[27]), .ZN(n10) );
  INVX0 U33 ( .INP(B[8]), .ZN(n28) );
  INVX0 U34 ( .INP(B[31]), .ZN(n6) );
  INVX0 U35 ( .INP(n35), .ZN(n2) );
  INVX0 U36 ( .INP(B[0]), .ZN(n35) );
  XOR2X1 U37 ( .IN1(n2), .IN2(A[0]), .Q(DIFF[0]) );
endmodule


module pipealu_DW01_add_0 ( A, B, CI, SUM, CO );
  input [32:0] A;
  input [32:0] B;
  output [32:0] SUM;
  input CI;
  output CO;
  wire   n1, n2, n3;
  wire   [32:1] carry;

  FADDX1 U1_31 ( .A(A[31]), .B(B[31]), .CI(carry[31]), .CO(SUM[32]), .S(
        SUM[31]) );
  FADDX1 U1_30 ( .A(A[30]), .B(B[30]), .CI(carry[30]), .CO(carry[31]), .S(
        SUM[30]) );
  FADDX1 U1_29 ( .A(A[29]), .B(B[29]), .CI(carry[29]), .CO(carry[30]), .S(
        SUM[29]) );
  FADDX1 U1_28 ( .A(A[28]), .B(B[28]), .CI(n2), .CO(carry[29]), .S(SUM[28]) );
  FADDX1 U1_25 ( .A(A[25]), .B(B[25]), .CI(carry[25]), .CO(SUM[26]), .S(
        SUM[25]) );
  FADDX1 U1_24 ( .A(A[24]), .B(B[24]), .CI(carry[24]), .CO(carry[25]), .S(
        SUM[24]) );
  FADDX1 U1_23 ( .A(A[23]), .B(B[23]), .CI(carry[23]), .CO(carry[24]), .S(
        SUM[23]) );
  FADDX1 U1_22 ( .A(A[22]), .B(B[22]), .CI(carry[22]), .CO(carry[23]), .S(
        SUM[22]) );
  FADDX1 U1_21 ( .A(A[21]), .B(B[21]), .CI(carry[21]), .CO(carry[22]), .S(
        SUM[21]) );
  FADDX1 U1_20 ( .A(A[20]), .B(B[20]), .CI(carry[20]), .CO(carry[21]), .S(
        SUM[20]) );
  FADDX1 U1_19 ( .A(A[19]), .B(B[19]), .CI(carry[19]), .CO(carry[20]), .S(
        SUM[19]) );
  FADDX1 U1_18 ( .A(A[18]), .B(B[18]), .CI(carry[18]), .CO(carry[19]), .S(
        SUM[18]) );
  FADDX1 U1_17 ( .A(A[17]), .B(B[17]), .CI(carry[17]), .CO(carry[18]), .S(
        SUM[17]) );
  FADDX1 U1_16 ( .A(A[16]), .B(B[16]), .CI(carry[16]), .CO(carry[17]), .S(
        SUM[16]) );
  FADDX1 U1_15 ( .A(A[15]), .B(B[15]), .CI(carry[15]), .CO(carry[16]), .S(
        SUM[15]) );
  FADDX1 U1_14 ( .A(A[14]), .B(B[14]), .CI(carry[14]), .CO(carry[15]), .S(
        SUM[14]) );
  FADDX1 U1_13 ( .A(A[13]), .B(B[13]), .CI(carry[13]), .CO(carry[14]), .S(
        SUM[13]) );
  FADDX1 U1_12 ( .A(A[12]), .B(B[12]), .CI(carry[12]), .CO(carry[13]), .S(
        SUM[12]) );
  FADDX1 U1_11 ( .A(A[11]), .B(B[11]), .CI(carry[11]), .CO(carry[12]), .S(
        SUM[11]) );
  FADDX1 U1_10 ( .A(A[10]), .B(B[10]), .CI(carry[10]), .CO(carry[11]), .S(
        SUM[10]) );
  FADDX1 U1_9 ( .A(A[9]), .B(B[9]), .CI(n1), .CO(carry[10]), .S(SUM[9]) );
  FADDX1 U1_6 ( .A(A[6]), .B(B[6]), .CI(carry[6]), .CO(SUM[7]), .S(SUM[6]) );
  FADDX1 U1_5 ( .A(A[5]), .B(B[5]), .CI(carry[5]), .CO(carry[6]), .S(SUM[5])
         );
  FADDX1 U1_4 ( .A(A[4]), .B(B[4]), .CI(carry[4]), .CO(carry[5]), .S(SUM[4])
         );
  FADDX1 U1_3 ( .A(A[3]), .B(B[3]), .CI(carry[3]), .CO(carry[4]), .S(SUM[3])
         );
  FADDX1 U1_2 ( .A(A[2]), .B(B[2]), .CI(carry[2]), .CO(carry[3]), .S(SUM[2])
         );
  FADDX1 U1_1 ( .A(A[1]), .B(B[1]), .CI(n3), .CO(carry[2]), .S(SUM[1]) );
  AND2X1 U1 ( .IN1(A[8]), .IN2(B[8]), .Q(n1) );
  AND2X1 U2 ( .IN1(A[27]), .IN2(B[27]), .Q(n2) );
  AND2X1 U3 ( .IN1(A[0]), .IN2(B[0]), .Q(n3) );
  XOR2X1 U4 ( .IN1(A[0]), .IN2(B[0]), .Q(SUM[0]) );
  XOR2X1 U5 ( .IN1(A[27]), .IN2(B[27]), .Q(SUM[27]) );
  XOR2X1 U6 ( .IN1(A[8]), .IN2(B[8]), .Q(SUM[8]) );
endmodule


module pipealu ( instr, AluOut, Zero, clk, Carryout, Overflow );
  input [15:0] instr;
  output [31:0] AluOut;
  input clk;
  output Zero, Carryout, Overflow;
  wire   N183, N184, N203, N205, N207, N208, N209, N210, N211, N212, N213,
         N214, N233, N235, N237, N238, N239, N240, N241, N242, N374, N375,
         N376, N377, N378, N379, N380, N381, N382, N383, N384, N385, N386,
         N387, N388, N389, N390, N391, N392, N393, N394, N395, N396, N397,
         N398, N399, N400, N401, N402, N403, N404, N405, N406, N408, N409,
         N410, N411, N412, N413, N414, N415, N416, N417, N418, N419, N420,
         N421, N422, N423, N424, N425, N426, N427, N428, N429, N430, N431,
         N432, N433, N434, N435, N436, N437, N438, N439, N440, N442, N443,
         N444, N445, N446, N447, N448, N449, N450, N451, N452, N453, N454,
         N455, N456, N457, N458, N459, N460, N461, N462, N463, N464, N465,
         N466, N467, N468, N469, N470, N471, N472, N473, N474, N475, N476, n33,
         n34, n35, n36, n37, n38, n39, n40, n41, n42, n43, n44, n45, n46, n47,
         n48, n49, n50, n51, n52, n53, n54, n55, n56, n57, n58, n60, n61, n62,
         n63, n64, n65, n66, n67, n68, n69, n72, n73, n74, n75, n76, n77, n78,
         n79, n80, n81, n82, n83, n84, n85, n86, n87, n88, n89, n90, n91, n92,
         n93, n94, n95, n96, n97, n98, n99, n100, n101, n102, n103, n104, n105,
         n106, n107, n108, n109, n110, n111, n112, n113, n114, n115, n116,
         n117, n118, n119, n120, n121, n122, n123, n124, n125, n126, n129,
         n130, n131, n132, n133, n134, n135, n136, n137, n138, n139, n140,
         n141, n142, n143, n144, n145, n146, n147, n148, n149, n150, n151,
         n152, n153, n154, n155, n156, n157, n158, n159, n160, n161, n162,
         n163, n164, n165, n166, n167, n168, n169, n170, n171, n172, n173,
         n174, n175, n176, n177, n178, n179, n180, n181, n182, n183, n184,
         n185, n186, n187, n188, n189, n190, n191, n192, n193, n194, n195,
         n196, n197, n198, n199, n200, n201, n202, n203, n204, n205, n206,
         n207, n208, n209, n210, n211, n212, n213, n214, n215, n216, n217,
         n218, n219, n220;
  wire   [3:0] opcode;
  wire   [31:0] tempA;
  wire   [31:0] tempB;

  DFFX1 \tempB_reg[31]  ( .D(N213), .CLK(clk), .Q(tempB[31]), .QN(n185) );
  DFFX1 \tempB_reg[30]  ( .D(N214), .CLK(clk), .Q(tempB[30]) );
  DFFX1 \tempB_reg[29]  ( .D(N235), .CLK(clk), .Q(tempB[29]) );
  DFFX1 \tempB_reg[28]  ( .D(n212), .CLK(clk), .Q(tempB[28]) );
  DFFX1 \tempB_reg[27]  ( .D(N233), .CLK(clk), .Q(tempB[27]) );
  DFFX1 \tempB_reg[25]  ( .D(N235), .CLK(clk), .Q(tempB[25]) );
  DFFX1 \tempB_reg[24]  ( .D(N235), .CLK(clk), .Q(tempB[24]) );
  DFFX1 \tempB_reg[23]  ( .D(N235), .CLK(clk), .Q(tempB[23]) );
  DFFX1 \tempB_reg[22]  ( .D(N233), .CLK(clk), .Q(tempB[22]) );
  DFFX1 \tempB_reg[21]  ( .D(n212), .CLK(clk), .Q(tempB[21]) );
  DFFX1 \tempB_reg[20]  ( .D(n212), .CLK(clk), .Q(tempB[20]) );
  DFFX1 \tempB_reg[19]  ( .D(N235), .CLK(clk), .Q(tempB[19]) );
  DFFX1 \tempB_reg[18]  ( .D(N233), .CLK(clk), .Q(tempB[18]) );
  DFFX1 \tempB_reg[17]  ( .D(n212), .CLK(clk), .Q(tempB[17]) );
  DFFX1 \tempB_reg[16]  ( .D(N235), .CLK(clk), .Q(tempB[16]) );
  DFFX1 \tempB_reg[15]  ( .D(N235), .CLK(clk), .Q(tempB[15]) );
  DFFX1 \tempB_reg[14]  ( .D(N233), .CLK(clk), .Q(tempB[14]) );
  DFFX1 \tempB_reg[13]  ( .D(N235), .CLK(clk), .Q(tempB[13]) );
  DFFX1 \tempB_reg[12]  ( .D(n212), .CLK(clk), .Q(tempB[12]) );
  DFFX1 \tempB_reg[11]  ( .D(N235), .CLK(clk), .Q(tempB[11]) );
  DFFX1 \tempB_reg[10]  ( .D(N233), .CLK(clk), .Q(tempB[10]) );
  DFFX1 \tempB_reg[9]  ( .D(N235), .CLK(clk), .Q(tempB[9]) );
  DFFX1 \tempB_reg[8]  ( .D(N235), .CLK(clk), .Q(tempB[8]) );
  DFFX1 \tempB_reg[6]  ( .D(n210), .CLK(clk), .Q(tempB[6]) );
  DFFX1 \tempB_reg[5]  ( .D(N237), .CLK(clk), .Q(tempB[5]) );
  DFFX1 \tempB_reg[4]  ( .D(N238), .CLK(clk), .Q(tempB[4]) );
  DFFX1 \tempB_reg[3]  ( .D(N239), .CLK(clk), .Q(tempB[3]) );
  DFFX1 \tempB_reg[2]  ( .D(N240), .CLK(clk), .Q(tempB[2]) );
  DFFX1 \tempB_reg[1]  ( .D(N241), .CLK(clk), .Q(tempB[1]) );
  DFFX1 \tempB_reg[0]  ( .D(N242), .CLK(clk), .Q(tempB[0]), .QN(n186) );
  DFFX1 \opcode_reg[3]  ( .D(instr[15]), .CLK(clk), .Q(opcode[3]), .QN(n182)
         );
  DFFX1 \opcode_reg[2]  ( .D(instr[14]), .CLK(clk), .Q(opcode[2]), .QN(n181)
         );
  DFFX1 \opcode_reg[1]  ( .D(instr[13]), .CLK(clk), .Q(opcode[1]), .QN(n184)
         );
  DFFX1 \opcode_reg[0]  ( .D(instr[12]), .CLK(clk), .Q(opcode[0]) );
  DFFX1 \tempA_reg[31]  ( .D(N183), .CLK(clk), .Q(tempA[31]), .QN(n183) );
  DFFX1 \tempA_reg[30]  ( .D(N184), .CLK(clk), .Q(tempA[30]) );
  DFFX1 \tempA_reg[29]  ( .D(N205), .CLK(clk), .Q(tempA[29]) );
  DFFX1 \tempA_reg[28]  ( .D(n206), .CLK(clk), .Q(tempA[28]) );
  DFFX1 \tempA_reg[27]  ( .D(N203), .CLK(clk), .Q(tempA[27]) );
  DFFX1 \tempA_reg[25]  ( .D(N205), .CLK(clk), .Q(tempA[25]) );
  DFFX1 \tempA_reg[24]  ( .D(N205), .CLK(clk), .Q(tempA[24]) );
  DFFX1 \tempA_reg[23]  ( .D(N205), .CLK(clk), .Q(tempA[23]) );
  DFFX1 \tempA_reg[22]  ( .D(N203), .CLK(clk), .Q(tempA[22]) );
  DFFX1 \tempA_reg[21]  ( .D(n206), .CLK(clk), .Q(tempA[21]) );
  DFFX1 \tempA_reg[20]  ( .D(n206), .CLK(clk), .Q(tempA[20]) );
  DFFX1 \tempA_reg[19]  ( .D(N205), .CLK(clk), .Q(tempA[19]) );
  DFFX1 \tempA_reg[18]  ( .D(N203), .CLK(clk), .Q(tempA[18]) );
  DFFX1 \tempA_reg[17]  ( .D(n206), .CLK(clk), .Q(tempA[17]) );
  DFFX1 \tempA_reg[16]  ( .D(N205), .CLK(clk), .Q(tempA[16]) );
  DFFX1 \tempA_reg[15]  ( .D(N205), .CLK(clk), .Q(tempA[15]) );
  DFFX1 \tempA_reg[14]  ( .D(N203), .CLK(clk), .Q(tempA[14]) );
  DFFX1 \tempA_reg[13]  ( .D(N205), .CLK(clk), .Q(tempA[13]) );
  DFFX1 \tempA_reg[12]  ( .D(n206), .CLK(clk), .Q(tempA[12]) );
  DFFX1 \tempA_reg[11]  ( .D(N205), .CLK(clk), .Q(tempA[11]) );
  DFFX1 \tempA_reg[10]  ( .D(N203), .CLK(clk), .Q(tempA[10]) );
  DFFX1 \tempA_reg[9]  ( .D(N205), .CLK(clk), .Q(tempA[9]) );
  DFFX1 \tempA_reg[8]  ( .D(N205), .CLK(clk), .Q(tempA[8]) );
  DFFX1 \tempA_reg[6]  ( .D(n204), .CLK(clk), .Q(tempA[6]) );
  DFFX1 \tempA_reg[5]  ( .D(N207), .CLK(clk), .Q(tempA[5]) );
  DFFX1 \tempA_reg[4]  ( .D(N208), .CLK(clk), .Q(tempA[4]) );
  DFFX1 \tempA_reg[3]  ( .D(N209), .CLK(clk), .Q(tempA[3]) );
  DFFX1 \tempA_reg[2]  ( .D(N210), .CLK(clk), .Q(tempA[2]) );
  DFFX1 \tempA_reg[1]  ( .D(N211), .CLK(clk), .Q(tempA[1]) );
  DFFX1 \tempA_reg[0]  ( .D(N212), .CLK(clk), .Q(tempA[0]) );
  DFFX1 Overflow_reg ( .D(N476), .CLK(clk), .Q(Overflow) );
  DFFX1 \AluOut_reg[31]  ( .D(N475), .CLK(clk), .Q(AluOut[31]) );
  DFFX1 \AluOut_reg[30]  ( .D(N474), .CLK(clk), .Q(AluOut[30]) );
  DFFX1 \AluOut_reg[29]  ( .D(N473), .CLK(clk), .Q(AluOut[29]) );
  DFFX1 \AluOut_reg[28]  ( .D(N472), .CLK(clk), .Q(AluOut[28]) );
  DFFX1 \AluOut_reg[27]  ( .D(N471), .CLK(clk), .Q(AluOut[27]) );
  DFFX1 \AluOut_reg[26]  ( .D(N470), .CLK(clk), .Q(AluOut[26]) );
  DFFX1 \AluOut_reg[25]  ( .D(N469), .CLK(clk), .Q(AluOut[25]) );
  DFFX1 \AluOut_reg[24]  ( .D(N468), .CLK(clk), .Q(AluOut[24]) );
  DFFX1 \AluOut_reg[23]  ( .D(N467), .CLK(clk), .Q(AluOut[23]) );
  DFFX1 \AluOut_reg[22]  ( .D(N466), .CLK(clk), .Q(AluOut[22]) );
  DFFX1 \AluOut_reg[21]  ( .D(N465), .CLK(clk), .Q(AluOut[21]) );
  DFFX1 \AluOut_reg[20]  ( .D(N464), .CLK(clk), .Q(AluOut[20]) );
  DFFX1 \AluOut_reg[19]  ( .D(N463), .CLK(clk), .Q(AluOut[19]) );
  DFFX1 \AluOut_reg[18]  ( .D(N462), .CLK(clk), .Q(AluOut[18]) );
  DFFX1 \AluOut_reg[17]  ( .D(N461), .CLK(clk), .Q(AluOut[17]) );
  DFFX1 \AluOut_reg[16]  ( .D(N460), .CLK(clk), .Q(AluOut[16]) );
  DFFX1 \AluOut_reg[15]  ( .D(N459), .CLK(clk), .Q(AluOut[15]) );
  DFFX1 \AluOut_reg[14]  ( .D(N458), .CLK(clk), .Q(AluOut[14]) );
  DFFX1 \AluOut_reg[13]  ( .D(N457), .CLK(clk), .Q(AluOut[13]) );
  DFFX1 \AluOut_reg[12]  ( .D(N456), .CLK(clk), .Q(AluOut[12]) );
  DFFX1 \AluOut_reg[11]  ( .D(N455), .CLK(clk), .Q(AluOut[11]) );
  DFFX1 \AluOut_reg[10]  ( .D(N454), .CLK(clk), .Q(AluOut[10]) );
  DFFX1 \AluOut_reg[9]  ( .D(N453), .CLK(clk), .Q(AluOut[9]) );
  DFFX1 \AluOut_reg[8]  ( .D(N452), .CLK(clk), .Q(AluOut[8]) );
  DFFX1 \AluOut_reg[7]  ( .D(N451), .CLK(clk), .Q(AluOut[7]) );
  DFFX1 \AluOut_reg[6]  ( .D(N450), .CLK(clk), .Q(AluOut[6]) );
  DFFX1 \AluOut_reg[5]  ( .D(N449), .CLK(clk), .Q(AluOut[5]) );
  DFFX1 \AluOut_reg[4]  ( .D(N448), .CLK(clk), .Q(AluOut[4]) );
  DFFX1 \AluOut_reg[3]  ( .D(N447), .CLK(clk), .Q(AluOut[3]) );
  DFFX1 \AluOut_reg[2]  ( .D(N446), .CLK(clk), .Q(AluOut[2]) );
  DFFX1 \AluOut_reg[1]  ( .D(N445), .CLK(clk), .Q(AluOut[1]) );
  DFFX1 \AluOut_reg[0]  ( .D(N444), .CLK(clk), .Q(AluOut[0]) );
  DFFX1 Carryout_reg ( .D(N443), .CLK(clk), .Q(Carryout) );
  DFFX1 Zero_reg ( .D(n180), .CLK(clk), .Q(Zero) );
  AND2X1 U92 ( .IN1(n33), .IN2(n34), .Q(n180) );
  NOR4X0 U93 ( .IN1(n35), .IN2(n36), .IN3(n37), .IN4(n38), .QN(n34) );
  OR4X1 U94 ( .IN1(N460), .IN2(N461), .IN3(N462), .IN4(N463), .Q(n38) );
  OR4X1 U95 ( .IN1(N464), .IN2(N465), .IN3(N466), .IN4(N467), .Q(n37) );
  OR4X1 U96 ( .IN1(N468), .IN2(N469), .IN3(N470), .IN4(N471), .Q(n36) );
  OR4X1 U97 ( .IN1(N472), .IN2(N473), .IN3(N474), .IN4(N475), .Q(n35) );
  NOR4X0 U98 ( .IN1(n39), .IN2(n40), .IN3(n41), .IN4(n42), .QN(n33) );
  OR4X1 U99 ( .IN1(N444), .IN2(N445), .IN3(N446), .IN4(N447), .Q(n42) );
  OR4X1 U100 ( .IN1(N448), .IN2(N449), .IN3(N450), .IN4(N451), .Q(n41) );
  OR4X1 U101 ( .IN1(N452), .IN2(N453), .IN3(N454), .IN4(N455), .Q(n40) );
  OR4X1 U102 ( .IN1(N456), .IN2(N457), .IN3(N458), .IN4(N459), .Q(n39) );
  AO22X1 U103 ( .IN1(tempB[31]), .IN2(n43), .IN3(n44), .IN4(n185), .Q(N476) );
  NAND3X0 U104 ( .IN1(n196), .IN2(n183), .IN3(N405), .QN(n46) );
  NAND3X0 U105 ( .IN1(tempA[31]), .IN2(n203), .IN3(n200), .QN(n45) );
  NAND3X0 U106 ( .IN1(tempA[31]), .IN2(n202), .IN3(n196), .QN(n49) );
  NAND3X0 U107 ( .IN1(n200), .IN2(n183), .IN3(N439), .QN(n48) );
  AO221X1 U108 ( .IN1(N439), .IN2(n200), .IN3(n194), .IN4(tempA[31]), .IN5(n50), .Q(N475) );
  OAI222X1 U109 ( .IN1(n51), .IN2(n185), .IN3(n189), .IN4(n52), .IN5(n53), 
        .IN6(n202), .QN(n50) );
  AO221X1 U110 ( .IN1(N438), .IN2(n201), .IN3(tempA[30]), .IN4(n190), .IN5(n56), .Q(N474) );
  AO222X1 U111 ( .IN1(tempB[30]), .IN2(n57), .IN3(n58), .IN4(n199), .IN5(N404), 
        .IN6(n196), .Q(n56) );
  AO21X1 U112 ( .IN1(tempA[30]), .IN2(n195), .IN3(n192), .Q(n57) );
  AO221X1 U113 ( .IN1(N437), .IN2(n201), .IN3(tempA[29]), .IN4(n190), .IN5(n60), .Q(N473) );
  AO222X1 U114 ( .IN1(tempB[29]), .IN2(n61), .IN3(n62), .IN4(n199), .IN5(N403), 
        .IN6(n196), .Q(n60) );
  AO21X1 U115 ( .IN1(tempA[29]), .IN2(n195), .IN3(n192), .Q(n61) );
  AO221X1 U116 ( .IN1(N436), .IN2(n201), .IN3(tempA[28]), .IN4(n190), .IN5(n63), .Q(N472) );
  AO222X1 U117 ( .IN1(tempB[28]), .IN2(n64), .IN3(n65), .IN4(n199), .IN5(N402), 
        .IN6(n196), .Q(n63) );
  AO21X1 U118 ( .IN1(tempA[28]), .IN2(n217), .IN3(n192), .Q(n64) );
  AO221X1 U119 ( .IN1(N435), .IN2(n201), .IN3(tempA[27]), .IN4(n190), .IN5(n66), .Q(N471) );
  AO222X1 U120 ( .IN1(tempB[27]), .IN2(n67), .IN3(n68), .IN4(n199), .IN5(N401), 
        .IN6(n196), .Q(n66) );
  AO21X1 U121 ( .IN1(tempA[27]), .IN2(n195), .IN3(n192), .Q(n67) );
  AO221X1 U125 ( .IN1(N433), .IN2(n201), .IN3(tempA[25]), .IN4(n190), .IN5(n72), .Q(N469) );
  AO222X1 U126 ( .IN1(tempB[25]), .IN2(n73), .IN3(n74), .IN4(n199), .IN5(N399), 
        .IN6(n196), .Q(n72) );
  AO21X1 U127 ( .IN1(tempA[25]), .IN2(n195), .IN3(n192), .Q(n73) );
  AO221X1 U128 ( .IN1(N432), .IN2(n201), .IN3(tempA[24]), .IN4(n191), .IN5(n75), .Q(N468) );
  AO222X1 U129 ( .IN1(tempB[24]), .IN2(n76), .IN3(n77), .IN4(n199), .IN5(N398), 
        .IN6(n196), .Q(n75) );
  AO21X1 U130 ( .IN1(tempA[24]), .IN2(n195), .IN3(n192), .Q(n76) );
  AO221X1 U131 ( .IN1(N431), .IN2(n201), .IN3(tempA[23]), .IN4(n191), .IN5(n78), .Q(N467) );
  AO222X1 U132 ( .IN1(tempB[23]), .IN2(n79), .IN3(n80), .IN4(n199), .IN5(N397), 
        .IN6(n196), .Q(n78) );
  AO21X1 U133 ( .IN1(tempA[23]), .IN2(n195), .IN3(n193), .Q(n79) );
  AO221X1 U134 ( .IN1(N430), .IN2(n201), .IN3(tempA[22]), .IN4(n191), .IN5(n81), .Q(N466) );
  AO222X1 U135 ( .IN1(tempB[22]), .IN2(n82), .IN3(n83), .IN4(n199), .IN5(N396), 
        .IN6(n196), .Q(n81) );
  AO21X1 U136 ( .IN1(tempA[22]), .IN2(n195), .IN3(n192), .Q(n82) );
  AO221X1 U137 ( .IN1(N429), .IN2(n201), .IN3(tempA[21]), .IN4(n191), .IN5(n84), .Q(N465) );
  AO222X1 U138 ( .IN1(tempB[21]), .IN2(n85), .IN3(n86), .IN4(n199), .IN5(N395), 
        .IN6(n196), .Q(n84) );
  AO21X1 U139 ( .IN1(tempA[21]), .IN2(n195), .IN3(n192), .Q(n85) );
  AO221X1 U140 ( .IN1(N428), .IN2(n201), .IN3(tempA[20]), .IN4(n191), .IN5(n87), .Q(N464) );
  AO222X1 U141 ( .IN1(tempB[20]), .IN2(n88), .IN3(n89), .IN4(n199), .IN5(N394), 
        .IN6(n196), .Q(n87) );
  AO21X1 U142 ( .IN1(tempA[20]), .IN2(n195), .IN3(n192), .Q(n88) );
  AO221X1 U143 ( .IN1(N427), .IN2(n201), .IN3(tempA[19]), .IN4(n192), .IN5(n90), .Q(N463) );
  AO222X1 U144 ( .IN1(tempB[19]), .IN2(n91), .IN3(n92), .IN4(n199), .IN5(N393), 
        .IN6(n196), .Q(n90) );
  AO21X1 U145 ( .IN1(tempA[19]), .IN2(n195), .IN3(n193), .Q(n91) );
  AO221X1 U146 ( .IN1(N426), .IN2(n201), .IN3(tempA[18]), .IN4(n192), .IN5(n93), .Q(N462) );
  AO222X1 U147 ( .IN1(tempB[18]), .IN2(n94), .IN3(n95), .IN4(n199), .IN5(N392), 
        .IN6(n196), .Q(n93) );
  AO21X1 U148 ( .IN1(tempA[18]), .IN2(n195), .IN3(n193), .Q(n94) );
  AO221X1 U149 ( .IN1(N425), .IN2(n201), .IN3(tempA[17]), .IN4(n192), .IN5(n96), .Q(N461) );
  AO222X1 U150 ( .IN1(tempB[17]), .IN2(n97), .IN3(n98), .IN4(n199), .IN5(N391), 
        .IN6(n196), .Q(n96) );
  AO21X1 U151 ( .IN1(tempA[17]), .IN2(n195), .IN3(n193), .Q(n97) );
  AO221X1 U152 ( .IN1(N424), .IN2(n201), .IN3(tempA[16]), .IN4(n191), .IN5(n99), .Q(N460) );
  AO222X1 U153 ( .IN1(tempB[16]), .IN2(n100), .IN3(n101), .IN4(n199), .IN5(
        N390), .IN6(n196), .Q(n99) );
  AO21X1 U154 ( .IN1(tempA[16]), .IN2(n195), .IN3(n193), .Q(n100) );
  AO221X1 U155 ( .IN1(N423), .IN2(n201), .IN3(tempA[15]), .IN4(n192), .IN5(
        n102), .Q(N459) );
  AO222X1 U156 ( .IN1(tempB[15]), .IN2(n103), .IN3(n104), .IN4(n198), .IN5(
        N389), .IN6(n197), .Q(n102) );
  AO21X1 U157 ( .IN1(tempA[15]), .IN2(n195), .IN3(n193), .Q(n103) );
  AO221X1 U158 ( .IN1(N422), .IN2(n200), .IN3(tempA[14]), .IN4(n191), .IN5(
        n105), .Q(N458) );
  AO222X1 U159 ( .IN1(tempB[14]), .IN2(n106), .IN3(n107), .IN4(n198), .IN5(
        N388), .IN6(n197), .Q(n105) );
  AO21X1 U160 ( .IN1(tempA[14]), .IN2(n195), .IN3(n193), .Q(n106) );
  AO221X1 U161 ( .IN1(N421), .IN2(n200), .IN3(tempA[13]), .IN4(n191), .IN5(
        n108), .Q(N457) );
  AO222X1 U162 ( .IN1(tempB[13]), .IN2(n109), .IN3(n110), .IN4(n198), .IN5(
        N387), .IN6(n197), .Q(n108) );
  AO21X1 U163 ( .IN1(tempA[13]), .IN2(n195), .IN3(n193), .Q(n109) );
  AO221X1 U164 ( .IN1(N420), .IN2(n200), .IN3(tempA[12]), .IN4(n190), .IN5(
        n111), .Q(N456) );
  AO222X1 U165 ( .IN1(tempB[12]), .IN2(n112), .IN3(n113), .IN4(n198), .IN5(
        N386), .IN6(n197), .Q(n111) );
  AO21X1 U166 ( .IN1(tempA[12]), .IN2(n217), .IN3(n193), .Q(n112) );
  AO221X1 U167 ( .IN1(N419), .IN2(n200), .IN3(tempA[11]), .IN4(n191), .IN5(
        n114), .Q(N455) );
  AO222X1 U168 ( .IN1(tempB[11]), .IN2(n115), .IN3(n116), .IN4(n198), .IN5(
        N385), .IN6(n197), .Q(n114) );
  AO21X1 U169 ( .IN1(tempA[11]), .IN2(n195), .IN3(n193), .Q(n115) );
  AO221X1 U170 ( .IN1(N418), .IN2(n200), .IN3(tempA[10]), .IN4(n191), .IN5(
        n117), .Q(N454) );
  AO222X1 U171 ( .IN1(tempB[10]), .IN2(n118), .IN3(n119), .IN4(n198), .IN5(
        N384), .IN6(n197), .Q(n117) );
  AO21X1 U172 ( .IN1(tempA[10]), .IN2(n195), .IN3(n193), .Q(n118) );
  AO221X1 U173 ( .IN1(N417), .IN2(n200), .IN3(tempA[9]), .IN4(n191), .IN5(n120), .Q(N453) );
  AO222X1 U174 ( .IN1(tempB[9]), .IN2(n121), .IN3(n122), .IN4(n198), .IN5(N383), .IN6(n197), .Q(n120) );
  AO21X1 U175 ( .IN1(tempA[9]), .IN2(n195), .IN3(n193), .Q(n121) );
  AO221X1 U176 ( .IN1(N416), .IN2(n200), .IN3(tempA[8]), .IN4(n191), .IN5(n123), .Q(N452) );
  AO222X1 U177 ( .IN1(tempB[8]), .IN2(n124), .IN3(n125), .IN4(n198), .IN5(N382), .IN6(n197), .Q(n123) );
  AO21X1 U178 ( .IN1(tempA[8]), .IN2(n195), .IN3(n193), .Q(n124) );
  AO221X1 U182 ( .IN1(N414), .IN2(n200), .IN3(tempA[6]), .IN4(n190), .IN5(n129), .Q(N450) );
  AO222X1 U183 ( .IN1(tempB[6]), .IN2(n130), .IN3(n131), .IN4(n198), .IN5(N380), .IN6(n197), .Q(n129) );
  AO21X1 U184 ( .IN1(tempA[6]), .IN2(n195), .IN3(n194), .Q(n130) );
  AO221X1 U185 ( .IN1(N413), .IN2(n200), .IN3(tempA[5]), .IN4(n190), .IN5(n132), .Q(N449) );
  AO222X1 U186 ( .IN1(tempB[5]), .IN2(n133), .IN3(n134), .IN4(n198), .IN5(N379), .IN6(n197), .Q(n132) );
  AO21X1 U187 ( .IN1(tempA[5]), .IN2(n195), .IN3(n194), .Q(n133) );
  AO221X1 U188 ( .IN1(N412), .IN2(n200), .IN3(tempA[4]), .IN4(n190), .IN5(n135), .Q(N448) );
  AO222X1 U189 ( .IN1(tempB[4]), .IN2(n136), .IN3(n137), .IN4(n198), .IN5(N378), .IN6(n197), .Q(n135) );
  AO21X1 U190 ( .IN1(tempA[4]), .IN2(n195), .IN3(n194), .Q(n136) );
  AO221X1 U191 ( .IN1(N411), .IN2(n200), .IN3(tempA[3]), .IN4(n190), .IN5(n138), .Q(N447) );
  AO222X1 U192 ( .IN1(tempB[3]), .IN2(n139), .IN3(n140), .IN4(n198), .IN5(N377), .IN6(n197), .Q(n138) );
  AO21X1 U193 ( .IN1(tempA[3]), .IN2(n195), .IN3(n194), .Q(n139) );
  AO221X1 U194 ( .IN1(N410), .IN2(n200), .IN3(tempA[2]), .IN4(n190), .IN5(n141), .Q(N446) );
  AO222X1 U195 ( .IN1(tempB[2]), .IN2(n142), .IN3(n143), .IN4(n198), .IN5(N376), .IN6(n197), .Q(n141) );
  AO21X1 U196 ( .IN1(tempA[2]), .IN2(n195), .IN3(n194), .Q(n142) );
  AO221X1 U197 ( .IN1(N409), .IN2(n200), .IN3(tempA[1]), .IN4(n190), .IN5(n144), .Q(N445) );
  AO222X1 U198 ( .IN1(tempB[1]), .IN2(n145), .IN3(n146), .IN4(n198), .IN5(N375), .IN6(n197), .Q(n144) );
  AO21X1 U199 ( .IN1(tempA[1]), .IN2(n195), .IN3(n194), .Q(n145) );
  NAND4X0 U200 ( .IN1(n147), .IN2(n148), .IN3(n149), .IN4(n150), .QN(N444) );
  AOI222X1 U201 ( .IN1(tempA[0]), .IN2(n194), .IN3(N374), .IN4(n197), .IN5(
        N408), .IN6(n200), .QN(n150) );
  AO21X1 U202 ( .IN1(n55), .IN2(n151), .IN3(n186), .Q(n149) );
  NAND3X0 U203 ( .IN1(n181), .IN2(n182), .IN3(n184), .QN(n54) );
  NAND4X0 U204 ( .IN1(opcode[0]), .IN2(n184), .IN3(n181), .IN4(n182), .QN(n55)
         );
  NAND4X0 U205 ( .IN1(N442), .IN2(opcode[1]), .IN3(n152), .IN4(opcode[0]), 
        .QN(n148) );
  OR3X1 U206 ( .IN1(tempA[0]), .IN2(tempB[0]), .IN3(n189), .Q(n147) );
  AO221X1 U207 ( .IN1(N406), .IN2(n197), .IN3(N440), .IN4(n200), .IN5(n198), 
        .Q(N443) );
  AND2X1 U209 ( .IN1(n153), .IN2(opcode[2]), .Q(n47) );
  NOR3X0 U210 ( .IN1(opcode[0]), .IN2(opcode[3]), .IN3(n184), .QN(n153) );
  AO22X1 U211 ( .IN1(n154), .IN2(n214), .IN3(n155), .IN4(n156), .Q(N242) );
  AO21X1 U212 ( .IN1(instr[7]), .IN2(instr[6]), .IN3(n157), .Q(n156) );
  AO221X1 U213 ( .IN1(n155), .IN2(n213), .IN3(n154), .IN4(instr[6]), .IN5(N233), .Q(N241) );
  AO22X1 U214 ( .IN1(n155), .IN2(instr[7]), .IN3(n158), .IN4(n213), .Q(N240)
         );
  OR2X1 U215 ( .IN1(instr[5]), .IN2(n154), .Q(n158) );
  AO22X1 U216 ( .IN1(n157), .IN2(n155), .IN3(n159), .IN4(n160), .Q(N239) );
  AO221X1 U217 ( .IN1(n161), .IN2(n154), .IN3(n157), .IN4(instr[4]), .IN5(N233), .Q(N238) );
  XOR2X1 U218 ( .IN1(instr[6]), .IN2(instr[5]), .Q(n164) );
  NAND3X0 U220 ( .IN1(instr[7]), .IN2(n213), .IN3(n160), .QN(n166) );
  OR3X1 U221 ( .IN1(n160), .IN2(instr[7]), .IN3(n213), .Q(n165) );
  AO21X1 U222 ( .IN1(n160), .IN2(n213), .IN3(N233), .Q(N213) );
  AO22X1 U224 ( .IN1(n167), .IN2(n208), .IN3(n168), .IN4(n169), .Q(N212) );
  AO21X1 U225 ( .IN1(instr[11]), .IN2(instr[10]), .IN3(n170), .Q(n169) );
  AO221X1 U226 ( .IN1(n168), .IN2(n207), .IN3(n167), .IN4(instr[10]), .IN5(
        N203), .Q(N211) );
  AO22X1 U227 ( .IN1(n168), .IN2(instr[11]), .IN3(n171), .IN4(n207), .Q(N210)
         );
  OR2X1 U228 ( .IN1(instr[9]), .IN2(n167), .Q(n171) );
  AO22X1 U229 ( .IN1(n170), .IN2(n168), .IN3(n172), .IN4(n173), .Q(N209) );
  AO221X1 U230 ( .IN1(n174), .IN2(n167), .IN3(n170), .IN4(instr[8]), .IN5(N203), .Q(N208) );
  XOR2X1 U231 ( .IN1(instr[9]), .IN2(instr[10]), .Q(n177) );
  NAND3X0 U233 ( .IN1(instr[11]), .IN2(n207), .IN3(n173), .QN(n179) );
  OR3X1 U234 ( .IN1(n173), .IN2(instr[11]), .IN3(n207), .Q(n178) );
  AO21X1 U235 ( .IN1(n173), .IN2(n207), .IN3(N203), .Q(N183) );
  pipealu_DW_cmp_0 lt_65 ( .A({tempA[31:27], 1'b0, tempA[25:8], 1'b0, 
        tempA[6:0]}), .B({tempB[31:27], 1'b0, tempB[25:8], 1'b0, tempB[6:0]}), 
        .TC(1'b0), .GE_LT(1'b1), .GE_GT_EQ(1'b0), .GE_LT_GT_LE(N442) );
  pipealu_DW01_sub_0 sub_59 ( .A({1'b0, tempA[31:27], 1'b0, tempA[25:8], 1'b0, 
        tempA[6:0]}), .B({1'b0, tempB[31:27], 1'b0, tempB[25:8], 1'b0, 
        tempB[6:0]}), .CI(1'b0), .DIFF({N440, N439, N438, N437, N436, N435, 
        N434, N433, N432, N431, N430, N429, N428, N427, N426, N425, N424, N423, 
        N422, N421, N420, N419, N418, N417, N416, N415, N414, N413, N412, N411, 
        N410, N409, N408}) );
  pipealu_DW01_add_0 add_53 ( .A({1'b0, tempA[31:27], 1'b0, tempA[25:8], 1'b0, 
        tempA[6:0]}), .B({1'b0, tempB[31:27], 1'b0, tempB[25:8], 1'b0, 
        tempB[6:0]}), .CI(1'b0), .SUM({N406, N405, N404, N403, N402, N401, 
        N400, N399, N398, N397, N396, N395, N394, N393, N392, N391, N390, N389, 
        N388, N387, N386, N385, N384, N383, N382, N381, N380, N379, N378, N377, 
        N376, N375, N374}) );
  INVX0 U237 ( .INP(n54), .ZN(n217) );
  NBUFFX2 U238 ( .INP(n216), .Z(n194) );
  INVX0 U239 ( .INP(n53), .ZN(n218) );
  OR2X1 U240 ( .IN1(n69), .IN2(n187), .Q(N470) );
  AND2X1 U241 ( .IN1(N434), .IN2(n200), .Q(n187) );
  NAND2X1 U242 ( .IN1(n189), .IN2(n220), .QN(n69) );
  NAND2X1 U243 ( .IN1(N400), .IN2(n196), .QN(n220) );
  INVX0 U244 ( .INP(n55), .ZN(n216) );
  NAND2X1 U245 ( .IN1(N381), .IN2(n196), .QN(n219) );
  OR2X1 U246 ( .IN1(n126), .IN2(n188), .Q(N451) );
  AND2X1 U247 ( .IN1(N415), .IN2(n200), .Q(n188) );
  NAND2X1 U248 ( .IN1(n189), .IN2(n219), .QN(n126) );
  INVX0 U249 ( .INP(N405), .ZN(n202) );
  INVX0 U250 ( .INP(n189), .ZN(n198) );
  INVX0 U251 ( .INP(n189), .ZN(n199) );
  NAND2X1 U252 ( .IN1(n153), .IN2(n181), .QN(n53) );
  NOR2X0 U253 ( .IN1(n209), .IN2(n205), .QN(n167) );
  NOR2X0 U254 ( .IN1(n215), .IN2(n211), .QN(n154) );
  AND2X1 U255 ( .IN1(n170), .IN2(n208), .Q(N203) );
  AND2X1 U256 ( .IN1(n157), .IN2(n214), .Q(N233) );
  AND2X1 U257 ( .IN1(N203), .IN2(n209), .Q(N205) );
  AND2X1 U258 ( .IN1(N233), .IN2(n215), .Q(N235) );
  INVX0 U259 ( .INP(n176), .ZN(n206) );
  INVX0 U260 ( .INP(n163), .ZN(n212) );
  NOR2X0 U261 ( .IN1(n207), .IN2(n205), .QN(n172) );
  NOR2X0 U262 ( .IN1(n213), .IN2(n211), .QN(n159) );
  NAND2X1 U263 ( .IN1(n175), .IN2(n176), .QN(N207) );
  NAND2X1 U264 ( .IN1(n162), .IN2(n163), .QN(N237) );
  INVX0 U265 ( .INP(n175), .ZN(n204) );
  INVX0 U266 ( .INP(n162), .ZN(n210) );
  INVX0 U267 ( .INP(N439), .ZN(n203) );
  NOR2X0 U268 ( .IN1(tempB[28]), .IN2(tempA[28]), .QN(n65) );
  NOR2X0 U269 ( .IN1(tempB[30]), .IN2(tempA[30]), .QN(n58) );
  NOR2X0 U270 ( .IN1(tempB[29]), .IN2(tempA[29]), .QN(n62) );
  NOR2X0 U271 ( .IN1(tempB[27]), .IN2(tempA[27]), .QN(n68) );
  NAND2X1 U272 ( .IN1(n183), .IN2(n185), .QN(n52) );
  OA21X1 U273 ( .IN1(n54), .IN2(n183), .IN3(n55), .Q(n51) );
  NAND2X1 U274 ( .IN1(n48), .IN2(n49), .QN(n43) );
  NAND2X1 U275 ( .IN1(n45), .IN2(n46), .QN(n44) );
  NOR2X0 U276 ( .IN1(tempB[16]), .IN2(tempA[16]), .QN(n101) );
  NOR2X0 U277 ( .IN1(tempB[20]), .IN2(tempA[20]), .QN(n89) );
  NOR2X0 U278 ( .IN1(tempB[24]), .IN2(tempA[24]), .QN(n77) );
  NOR2X0 U279 ( .IN1(tempB[18]), .IN2(tempA[18]), .QN(n95) );
  NOR2X0 U280 ( .IN1(tempB[22]), .IN2(tempA[22]), .QN(n83) );
  NOR2X0 U281 ( .IN1(tempB[21]), .IN2(tempA[21]), .QN(n86) );
  NOR2X0 U282 ( .IN1(tempB[17]), .IN2(tempA[17]), .QN(n98) );
  NOR2X0 U283 ( .IN1(tempB[25]), .IN2(tempA[25]), .QN(n74) );
  NOR2X0 U284 ( .IN1(tempB[15]), .IN2(tempA[15]), .QN(n104) );
  NOR2X0 U285 ( .IN1(tempB[19]), .IN2(tempA[19]), .QN(n92) );
  NOR2X0 U286 ( .IN1(tempB[23]), .IN2(tempA[23]), .QN(n80) );
  NOR2X0 U287 ( .IN1(opcode[3]), .IN2(n181), .QN(n152) );
  NOR2X0 U288 ( .IN1(tempB[8]), .IN2(tempA[8]), .QN(n125) );
  NOR2X0 U289 ( .IN1(tempB[12]), .IN2(tempA[12]), .QN(n113) );
  NOR2X0 U290 ( .IN1(tempB[10]), .IN2(tempA[10]), .QN(n119) );
  NOR2X0 U291 ( .IN1(tempB[14]), .IN2(tempA[14]), .QN(n107) );
  NOR2X0 U292 ( .IN1(tempB[9]), .IN2(tempA[9]), .QN(n122) );
  NOR2X0 U293 ( .IN1(tempB[13]), .IN2(tempA[13]), .QN(n110) );
  NOR2X0 U294 ( .IN1(tempB[11]), .IN2(tempA[11]), .QN(n116) );
  NAND2X1 U295 ( .IN1(tempA[0]), .IN2(n217), .QN(n151) );
  NOR2X0 U296 ( .IN1(tempB[1]), .IN2(tempA[1]), .QN(n146) );
  NOR2X0 U297 ( .IN1(tempB[3]), .IN2(tempA[3]), .QN(n140) );
  NOR2X0 U298 ( .IN1(tempB[4]), .IN2(tempA[4]), .QN(n137) );
  NOR2X0 U299 ( .IN1(tempB[5]), .IN2(tempA[5]), .QN(n134) );
  NOR2X0 U300 ( .IN1(tempB[2]), .IN2(tempA[2]), .QN(n143) );
  NOR2X0 U301 ( .IN1(tempB[6]), .IN2(tempA[6]), .QN(n131) );
  OR4X1 U302 ( .IN1(n182), .IN2(n181), .IN3(opcode[0]), .IN4(opcode[1]), .Q(
        n189) );
  INVX0 U303 ( .INP(instr[10]), .ZN(n207) );
  INVX0 U304 ( .INP(instr[6]), .ZN(n213) );
  INVX0 U305 ( .INP(instr[9]), .ZN(n208) );
  INVX0 U306 ( .INP(instr[5]), .ZN(n214) );
  NOR2X0 U307 ( .IN1(n208), .IN2(instr[8]), .QN(n168) );
  NOR2X0 U308 ( .IN1(n214), .IN2(instr[4]), .QN(n155) );
  NOR2X0 U309 ( .IN1(instr[9]), .IN2(instr[8]), .QN(n173) );
  NOR2X0 U310 ( .IN1(instr[5]), .IN2(instr[4]), .QN(n160) );
  NAND2X1 U311 ( .IN1(n167), .IN2(n177), .QN(n175) );
  NAND2X1 U312 ( .IN1(n154), .IN2(n164), .QN(n162) );
  NOR2X0 U313 ( .IN1(n208), .IN2(n207), .QN(n174) );
  NOR2X0 U314 ( .IN1(n214), .IN2(n213), .QN(n161) );
  NAND2X1 U315 ( .IN1(N203), .IN2(instr[8]), .QN(n176) );
  NAND2X1 U316 ( .IN1(N233), .IN2(instr[4]), .QN(n163) );
  INVX0 U317 ( .INP(instr[11]), .ZN(n205) );
  INVX0 U318 ( .INP(instr[7]), .ZN(n211) );
  NOR2X0 U319 ( .IN1(instr[10]), .IN2(instr[11]), .QN(n170) );
  NOR2X0 U320 ( .IN1(instr[6]), .IN2(instr[7]), .QN(n157) );
  NAND2X1 U321 ( .IN1(n178), .IN2(n179), .QN(N184) );
  NAND2X1 U322 ( .IN1(n165), .IN2(n166), .QN(N214) );
  INVX0 U323 ( .INP(instr[8]), .ZN(n209) );
  INVX0 U324 ( .INP(instr[4]), .ZN(n215) );
  NBUFFX2 U325 ( .INP(n216), .Z(n190) );
  NBUFFX2 U326 ( .INP(n216), .Z(n191) );
  NBUFFX2 U327 ( .INP(n216), .Z(n192) );
  NBUFFX2 U328 ( .INP(n216), .Z(n193) );
  NBUFFX2 U329 ( .INP(n217), .Z(n195) );
  NBUFFX2 U330 ( .INP(n218), .Z(n196) );
  NBUFFX2 U331 ( .INP(n218), .Z(n197) );
  NBUFFX2 U332 ( .INP(n47), .Z(n200) );
  NBUFFX2 U333 ( .INP(n47), .Z(n201) );
endmodule

