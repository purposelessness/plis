module t_indicator_7();

reg clk;
wire seg0, seg1, seg2, seg3, seg4, seg5, seg6;

reg [3:0] counter;

indicator_7 ind(counter, {seg6, seg5, seg4, seg3, seg2, seg1, seg0});

initial begin
  clk = 0;
  counter = 0;
end

always begin
  #5 clk = ~clk;
end

always @ (clk) begin
  counter = counter + 1;
end

initial begin
  $monitor($time,, clk,, counter,, seg6, seg5, seg4, seg3, seg2, seg1, seg0);
  $dumpfile("out.vcd");
  $dumpvars(0, t_indicator_7);
  #50 $finish;
end

endmodule
