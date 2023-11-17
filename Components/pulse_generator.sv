// Outputs a pulse generator with a period of "ticks".
// outt should go high for one cycle ever "ticks" clocks.

`timescale 1ns/1ps
`default_nettype none

module pulse_generator(clk, rst, ena, ticks, out);

parameter N = 8;
input wire clk, rst, ena;
input wire [N-1:0] ticks;
output logic out;

wire [N-1:0] counter, next_counter;
logic counter_rst;
wire count_done;

adder_n #(.N(N)) ADDER(
  .a(counter), .b(1), .c_in(1'b0), .sum(next_counter), .c_out()
);

comparator_eq #(.N(N)) COMPARATOR(
  .a(next_counter), .b(ticks), .out(count_done)
);

always_comb begin
  out = count_done & ena;
  counter_rst = count_done | rst;
end

register #(.N(N)) COUNTER_REGISTER(
  .clk(clk), .rst(counter_rst), .ena(1'b1), .d(next_counter), .q(counter)
);


endmodule
