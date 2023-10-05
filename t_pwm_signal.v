module t_pwm_key_control();

reg in = 0;
wire out;

reg sig;
integer i = 0;

pwm_register pwm(in, sig, out);

always begin
  #1 in = ~in;
end

initial begin
  sig = 0;
  for (i = 0; i < 15; i = i + 1) begin
    #100
    sig = 1;
    #2
    sig = 0;
  end
end

initial begin
  #2000 $finish;
end

initial begin
  $dumpfile("out.vcd");
  $dumpvars(0, t_pwm_key_control);
end

endmodule
