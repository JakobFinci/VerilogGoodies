`timescale 1ns/1ps
`default_nettype none

module decoder_5_to_32(ena, in, out);

input wire ena;
input wire [4:0] in;
output logic [31:0] out;

parameter N = 32;
logic [31:0] preout;

decoder_4_to_16 basehigh(
    .ena(in[4]),
    .in(in[3:0]),
    .out(preout[31:16])
    );

decoder_4_to_16 baselow(
    .ena(~in[4]),
    .in(in[3:0]),
    .out(preout[15:0])
);

assign out = {{N}{ena}} & preout;

endmodule
