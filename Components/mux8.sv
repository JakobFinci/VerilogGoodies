`default_nettype none

module mux8(in0, in1, in2, in3, in4, in5, in6, in7, s, out);

parameter N=32;
input wire [N-1:0] in0, in1, in2, in3, in4, in5, in6, in7;
input wire [2:0] s;
output logic [N-1:0] out;
logic [N-1:0] mid1, mid2;

mux4 mux4_a(
    .in0(in0), 
    .in1(in1), 
    .in2(in2), 
    .in3(in3), 
    .s(s[1:0]),
    .out(mid1)
);

mux4 mux4_b(
    .in0(in4), 
    .in1(in5), 
    .in2(in6), 
    .in3(in7), 
    .s(s[1:0]),
    .out(mid2)
);

always_comb out = s[2] ? mid2 : mid1;

endmodule
