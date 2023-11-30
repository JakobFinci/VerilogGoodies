`timescale 1ns/1ps
`default_nettype none

/*
A synchronous register (batch of flip flops) with rst > ena.
*/

module register(clk, ena, rst, d, q);
parameter N = 1;
parameter RESET_VALUE = 0; // Value to reset to.

input wire clk, ena, rst;
input wire [N-1:0] d;
output logic [N-1:0] q;

always_ff @(posedge clk)
    if(rst) q <= 0;
    else if(ena) q <= d;
    else q <= q;

endmodule
