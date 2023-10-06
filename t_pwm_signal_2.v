module t_pwm_key_control();

reg in = 0;
wire out;

wire sig;
integer i = 0;

pwm_signal pwm(in, sig, out);
sig_creator creat(sig);

always begin
  #1 in = ~in;
end

initial begin
  #2000 $finish;
end

initial begin
  $dumpfile("out.vcd");
  $dumpvars(0, t_pwm_key_control);
end

endmodule

module sig_creator(
  output wire out
);

reg val = 0;

assign out = val;
integer i = 0;

always begin
  #20
  val = 1'b1;
  #5
  val = 1'b0;
end

endmodule
