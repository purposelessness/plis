module t_alu_controller();

reg clk = 0;
wire led;

reg com = 0;
reg inc = 0;

alu_controller alu_controller_instance(
  .clk(clk),
  .com(com),
  .inc_guess(inc),
  .led(led)
);

always begin
  #1 clk = ~clk;
end

initial begin
  $monitor("inc:%d   com:%d   led:%d", inc, com, led);
  #1
  inc = 1;
  #1
  inc = 0;
  // guess = 1 == res = 1
  #1
  inc = 1;
  #1
  inc = 0;
  // guess = 2 != res = 1
  #1
  com = 1;
  #1
  com = 0;
  // guess = 2 != res = 7
  #1
  com = 1;
  #1
  com = 0;
  // guess = 2 != res = 4
  #1
  inc = 1;
  #1
  inc = 0;
  // guess = 3 != res = 4
  #1
  inc = 1;
  #1
  inc = 0;
  // guess = 4 == res = 4
  #1
  $finish;
end

endmodule
