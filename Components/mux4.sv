`default_nettype none

module mux4(in0, in1, in2, in3, s, out);

parameter N=32;
input wire [N-1:0] in0, in1, in2, in3;
input wire [1:0] s;
output logic [N-1:0] out;
logic [N-1:0] mid1, mid2;

mux2 mux2_a (
    .in0(in0),
    .in1(in1),
    .s(s[0]),
    .out(mid1)
);

mux2 mux2_b (
    .in0(in2),
    .in1(in3),
    .s(s[0]),
    .out(mid2)
);

always_comb out = s[1] ? mid2 : mid1;

endmodule
