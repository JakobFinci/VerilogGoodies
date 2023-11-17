`timescale 1ns/1ps
`default_nettype none

module decoder_3_to_8(ena, in, out);

  input wire ena;
  input wire [2:0] in;
  output logic [7:0] out;

  parameter N = 8;
  logic [7:0] preout;

  decoder_2_to_4 baselow(
    .ena(~in[2]),
    .in(in[1:0]),
    .out(preout[3:0])
    );
  
  decoder_2_to_4 basehigh(
    .ena(in[2]),
    .in(in[1:0]),
    .out(preout[7:4])
    );

  assign out = {{N}{ena}} & preout;


endmodule