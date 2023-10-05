module eight_bit_adder(
  input wire [7:0] a,
  input wire [7:0] b,
  output wire [7:0] sum,
  output wire cf
);

assign {cf, sum} = a + b;

endmodule
