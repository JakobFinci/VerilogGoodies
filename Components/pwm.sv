/*
  A pulse width modulation module 
*/

module pwm(clk, rst, ena, step, duty, out);

parameter N = 8;

input wire clk, rst;
input wire ena; // Enables the output.
input wire step; // Enables the internal counter. You should only increment when this signal is high (this is how we slow down the PWM to reasonable speeds).
input wire [N-1:0] duty; // The "duty cycle" input.
output logic out;

// Create combinational (always_comb) and sequential (always_ff @(posedge clk)) 
// logic that drives the out signal.
// out should be off if ena is low.
// out should be fully zero (no pulses) if duty is 0.
// out should have its highest duty cycle if duty is 2^N-1;
// bonus: out should be fully zero at duty = 0, and fully 1 (always on) at duty = 2^N-1;
// You can use behavioural combinational logic, but try to keep your sequential
//   and combinational blocks as separate as possible.

wire [N-1:0] counter, next_counter;
wire comparator;

comparator_lt #(.N(N)) COMPARATOR (.a(counter), .b(duty), .out(comparator));
adder_n #(.N(N)) ADDER (
  .a(counter), .b(1), .c_in(1'b0), .c_out(), .sum(next_counter)
);
register #(.N(N)) COUNTER_REGISTER (
  .clk(clk), .rst(rst), .ena(step), .d(next_counter), .q(counter)
);

always_comb begin
  // Trick to have the output be fully high at maximum duty cycle.
  out = ena & ( comparator | &counter );
end

endmodule