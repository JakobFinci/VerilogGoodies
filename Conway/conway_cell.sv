`default_nettype none
`timescale 1ns/1ps

module conway_cell(clk, rst, ena, state_0, state_d, state_q, neighbors);
parameter N = 4;

input wire clk;
input wire rst;
input wire ena;

input wire state_0;
output logic state_d;
output logic state_q;

input wire [7:0] neighbors;
wire gnd; //gnd for c_out 
logic if_dead, if_alive; // states for muxes
logic [3:0] living_neighbors;
logic [3:0] a_out, b_out, c_out;

adder_n #(.N(N)) adder_a( // my parameterized ripple carry adder.
    .a({3'b0,neighbors[0]}),
    .b({3'b0,neighbors[1]}),
    .c_in(neighbors[2]),
    .c_out(gnd), 
    .sum(a_out)
);

adder_n #(.N(N)) adder_b(
    .a(a_out),
    .b({3'b0,neighbors[3]}),
    .c_in(neighbors[4]),
    .c_out(gnd), 
    .sum(b_out)
);

adder_n #(.N(N)) adder_c(
    .a(b_out),
    .b({3'b0,neighbors[5]}),
    .c_in(neighbors[6]),
    .c_out(gnd), 
    .sum(c_out)
);

adder_n #(.N(N)) adder_d(
    .a(c_out),
    .b({3'b0,neighbors[7]}),
    .c_in(1'b0),
    .c_out(gnd), 
    .sum(living_neighbors)
);

always_comb if_dead = &(living_neighbors ~^ 4'd3);
always_comb if_alive = &(living_neighbors ~^ 4'd3) | &(living_neighbors ~^ 4'd2);
always_comb state_d = state_q ? if_alive : if_dead;

always_ff @(posedge clk)
    if(rst) state_q <= state_0;
    else if(ena) state_q <= state_d;
    else state_q <= state_q;

endmodule