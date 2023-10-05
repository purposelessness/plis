module t_pwm_29();

reg in = 0;
wire out;

pwm_29 pwm(in, out);

always
  #1 in = ~in;

initial begin
  #100000 $finish;
end

initial begin
  $dumpfile("out.vcd");
  $dumpvars(0, t_pwm_29);
end

endmodule
