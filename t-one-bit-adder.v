module t_one_bit_adder();

reg a, b, c_in;
wire sum, c_out;

one_bit_adder adder(a, b, c_in, sum, c_out);

initial begin
  a = 0;
  b = 0;
  c_in = 0;
  $strobe("a=%b, b=%b, c_in=%b, sum=%b, c_out=%b", a, b, c_in, sum, c_out);
  #1
  a = 1;
  b = 0;
  c_in = 0;
  $strobe("a=%b, b=%b, c_in=%b, sum=%b, c_out=%b", a, b, c_in, sum, c_out);
  #1
  a = 0;
  b = 0;
  c_in = 1;
  $strobe("a=%b, b=%b, c_in=%b, sum=%b, c_out=%b", a, b, c_in, sum, c_out);
  #1
  a = 1;
  b = 1;
  c_in = 0;
  $strobe("a=%b, b=%b, c_in=%b, sum=%b, c_out=%b", a, b, c_in, sum, c_out);
  #1
  a = 1;
  b = 0;
  c_in = 1;
  $strobe("a=%b, b=%b, c_in=%b, sum=%b, c_out=%b", a, b, c_in, sum, c_out);
  #1
  a = 1;
  b = 1;
  c_in = 1;
  $strobe("a=%b, b=%b, c_in=%b, sum=%b, c_out=%b", a, b, c_in, sum, c_out);
end

endmodule
