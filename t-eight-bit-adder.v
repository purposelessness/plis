module t_eight_bit_adder();

reg [7:0] a;
reg [7:0] b;
wire [7:0] sum;
wire cf;

eight_bit_adder adder(a, b, sum, cf);

initial begin
  a = 0;
  b = 0;
  $strobe("a=%b, b=%b, sum=%b, cf=%b", a, b, sum, cf);
  #1
  a = 8'b00100100;
  b = 8'b10100111;
  $strobe("a=%b, b=%b, sum=%b, cf=%b", a, b, sum, cf);
  #1
  a = 8'b10000000;
  b = 8'b10100111;
  $strobe("a=%b, b=%b, sum=%b, cf=%b", a, b, sum, cf);
  #1
  a = 8'd255;
  b = 8'd255;
  $strobe("a=%b, b=%b, sum=%b, cf=%b", a, b, sum, cf);
end

endmodule
