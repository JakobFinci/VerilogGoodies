`timescale 1ns/1ps
`default_nettype none

module decoder_2_to_4(ena, in, out);

  input wire ena;
  input wire [1:0] in;
  output logic [3:0] out;
  logic [1:0] mid;

  decoder_1_to_2 base(
    .ena(ena),
    .in(in[0]),
    .out(mid)
    );
  
  decoder_1_to_2 mid1(
    .ena(mid[0]),
    .in(in[1]),
    .out(out[1:0])
    );
  
  decoder_1_to_2 mid2(
    .ena(mid[1]),
    .in(in[1]),
    .out(out[3:2])
    );


endmodule