module t_d_trigger();

reg clk;
reg reset;
reg [7:0] in;
wire [7:0] out;

d_trigger trigger(clk, reset, in, out);

always begin
  #1 clk = ~clk;
  #5 in = in + 1;
end

initial begin
  clk = 0;
  in = 0;
end

initial begin
  reset = 0;
  #10
  reset = 1;
  #10
  reset = 0;
  #100
  reset = 1;
  #500
  reset = 0;
end

initial begin
  $monitor("clk=%b,, reset=%b,, in=%d,, out=%d", clk, reset, in, out);
  $dumpfile("out.vcd");
  $dumpvars(0, t_d_trigger);
end

initial begin
  #2000 $finish;
end


endmodule
