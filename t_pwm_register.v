module t_pwm_key_control();

reg in = 0;
reg [7:0] level = 127;
wire out;

pwm_register pwm(in, level, out);

always begin
  #1 in = ~in;
end

initial begin
  #1000
  level <= 255;
  #1000
  level <= 0;
  #1000
  level <= 50;
  #1000
  level <= 200;
  #1000
  level <= 127;
end

initial begin
  #10000 $finish;
end

initial begin
  $dumpfile("out.vcd");
  $dumpvars(0, t_pwm_key_control);
end

endmodule
