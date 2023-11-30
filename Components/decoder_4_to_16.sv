`timescale 1ns/1ps
`default_nettype none

module decoder_4_to_16(ena, in, out);

input wire ena;
input wire [3:0] in;
output logic [15:0] out;

parameter N = 16;
logic [15:0] preout;

decoder_3_to_8 basehigh(
    .ena(in[3]),
    .in(in[2:0]),
    .out(preout[15:8])
);

decoder_3_to_8 baselow(
    .ena(~in[3]),
    .in(in[2:0]),
    .out(preout[7:0])
);

assign out = {{N}{ena}} & preout;

endmodule