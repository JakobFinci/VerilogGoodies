`timescale 1ns/1ps
`default_nettype none

module decoder_1_to_2(ena, in, out);

input wire ena;
input wire in;
output logic [1:0] out;

assign out[0] = ena & ~in;
assign out[1] = ena & in;

endmodule