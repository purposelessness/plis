module t_pwm_key_control();

reg in = 0;
wire out;

reg inc, dec;
integer i = 0;

pwm_register pwm(in, inc, dec, out);

always begin
  #1 in = ~in;
end

initial begin
  inc = 0;
  dec = 0;
  for (i = 0; i < 5; i = i + 1) begin
    #40
    inc = 1;
    dec = 0;
    #2
    inc = 0;
    dec = 0;
  end
  #50
  for (i = 0; i < 10; i = i + 1) begin
    #40
    inc = 0;
    dec = 1;
    #2
    inc = 0;
    dec = 0;
  end
end

initial begin
  #1500 $finish;
end

initial begin
  $dumpfile("out.vcd");
  $dumpvars(0, t_pwm_key_control);
end

endmodule
