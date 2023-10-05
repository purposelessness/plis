module t_indicator_7();

reg key_a, key_b;
wire seg0, seg1, seg2, seg3, seg4, seg5, seg6;

indicator_control ind(key_a, key_b, {seg6, seg5, seg4, seg3, seg2, seg1, seg0});

initial begin
  key_a = 0;
  key_b = 0;
  #1
  key_a = 1;
  key_b = 0;
  #1
  key_a = 0;
  key_b = 1;
  #1
  key_a = 0;
  key_b = 0;
  #1
  key_a = 0;
  key_b = 1;
  #1
  key_a = 0;
  key_b = 0;
  #1
  key_a = 0;
  key_b = 1;
end

initial begin
  $monitor($time,, key_a, key_b,, seg6, seg5, seg4, seg3, seg2, seg1, seg0);
  $dumpfile("out.vcd");
  $dumpvars(0, t_indicator_7);
  #50 $finish;
end

endmodule
