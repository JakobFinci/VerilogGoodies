`timescale 1ns/1ps
`default_nettype none

`include "alu_types.sv"

module alu(a, b, control, result, overflow, zero, equal);
parameter N = 32;

input wire [N-1:0] a, b;
input alu_control_t control;

logic [N-1:0] oAND, oOR, oXOR, oSLL, oSRL, oSRA, add_out, add_b_in; 
logic oLT, oLTU, c_out;
// o for (potental) output

output logic [N-1:0] result; // Result of the selected operation.

output logic overflow; // Is high if the result of an ADD or SUB wraps around the 32 bit boundary.
output logic zero;  // Is high if the result is ever all zeros.
output logic equal; // is high if a == b.

// Hardware

sll #(.N(N)) mySLL(.in(a), .shamt(b[4:0]), .out(oSLL));
srl #(.N(N)) mySRL(.in(a), .shamt(b[4:0]), .out(oSRL));
sra #(.N(N)) mySRA(.in(a), .shamt(b[4:0]), .out(oSRA));

adder_n #(.N(N)) elAdder(
      .a(a),
      .b(add_b_in), 
      .c_in(control[2]),
      .sum(add_out),
      .c_out(c_out));

mux16 #(.N(N)) controlMux(
  // Comp
  .in0(32'b0), .in1(oAND), .in2(oOR), .in3(oXOR), 
  // Shift
  .in4(32'b0), .in5(oSLL), .in6(oSRL), .in7(oSRA),
  // Add or Sub
  .in8(add_out), .in9(32'b0), .in10(32'b0), .in11(32'b0), .in12(add_out),
  // Other
  .in13({31'b0,oLT}), .in14(32'b0), .in15({31'b0,oLTU}), 
  .s(control), .out(result)
);


always_comb begin : ALU_comb_logic
    // Non-adder things
    equal = &(a ~^ b);
    oAND = a & b;
    oOR = a | b;
    oXOR = a ^ b;
    // Adder things
    add_b_in = control[2] ? ~b : b;
    overflow = control[3] & (a[N-1] ^ add_out[N-1]) & ~(control[2] ^ a[N-1] ^ b[N-1]);
    oLT = overflow ^ add_out[N-1];
    oLTU = ~c_out;
    zero = &(~result);
end
endmodule


