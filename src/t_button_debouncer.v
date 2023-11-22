module t_button_debouncer();

reg clk = 0;
wire out;

reg btn = 0;

button_debouncer btndeb_instance(
  .clk(clk),
  .btn(btn),
  .out(out)
);

always begin
  #1 clk = ~clk;
end

initial begin
  btn = 1;
  #1
  btn = 0;
  #10
  btn = 1;
  #10
  btn = 0;
  #10
  btn = 1;
  #100
  btn = 0;
  #100
  btn = 1;
  #200000
  btn = 0;
  #200
  btn = 1;
  #500000
  btn = 0;
  #100000
  btn = 1;
  #3000000
  btn = 0;
end

initial begin
  $dumpfile("out.vcd");
  $dumpvars(0, t_button_debouncer);
end

initial begin
  #5000000 $finish;
end

endmodule
