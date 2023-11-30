`default_nettype none

// python: print(", ".join([f"in{i}" for i in range(16)]))
module mux16(
  in0, in1, in2, in3, in4, in5, in6, in7, 
  in8, in9, in10, in11, in12, in13, in14, in15, 
  s, out
);

parameter N=32;
input wire [N-1:0] in0, in1, in2, in3, in4, in5, in6, in7, in8, in9, in10, in11, in12, in13, in14, in15;
input wire [3:0] s;
output logic [N-1:0] out;
logic [N-1:0] mid1, mid2;

mux8 mux8a(
  .in0(in0),
  .in1(in1), 
  .in2(in2), 
  .in3(in3), 
  .in4(in4), 
  .in5(in5), 
  .in6(in6), 
  .in7(in7), 
  .s(s[2:0]), 
  .out(mid1)
);

mux8 mux8b(
  .in0(in8),
  .in1(in9), 
  .in2(in10), 
  .in3(in11), 
  .in4(in12), 
  .in5(in13), 
  .in6(in14), 
  .in7(in15), 
  .s(s[2:0]), 
  .out(mid2)
);

always_comb out = s[1] ? mid2 : mid1;

endmodule
