`default_nettype none

module comparator_lt(a, b, out);

parameter N = 32;
input wire signed [N-1:0] a, b;
output logic out;

logic [N-1:0] not_b;
always_comb not_b = ~b;
wire c_out;
wire [N-1:0] difference; 

adder_n #(.N(N)) SUBTRACTOR(
  .a(a), .b(not_b), .c_in(1'b1),
  .c_out(c_out), .sum(difference[N-1:0])
);

mux4 #(.N(1)) LT_MUX(
  .s({a[31], b[31]}), // switch on the sign bits
  .in0(difference[N-1]), .in1(1'b0), .in2(1'b1), .in3(difference[N-1]),
  .out(out)
);

endmodule

