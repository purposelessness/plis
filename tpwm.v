module tpwm();

reg clk;
wire port;

pwm pwm_instance(.clk(clk), .port(port));

always
  #1 clk = ~clk;

initial begin
  clk = 0;
end

initial begin
  #100000 $finish;
end

initial begin
  $dumpfile("out.vcd");
  $dumpvars(0, tpwm);
end

endmodule
