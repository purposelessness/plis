module one_bit_adder(
  input wire a,
  input wire b,
  input wire c_in,
  output wire sum,
  output wire c_out
);

assign sum = (a ^ b) ^ c_in;
assign c_out = (a & b) ^ ((a ^ b) & c_in);

endmodule
