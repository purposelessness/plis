module button_debouncer(
    input wire clk,
    input wire btn,
    output wire out
  );
 
  reg [19:0] ctr_d = 20'b0;
  reg [19:0] ctr_q = 20'b0;
  reg [1:0] sync_d = 2'b0;
  reg [1:0] sync_q = 2'b0;
 
  assign out = ctr_q == {20{1'b1}};
 
  always @(*) begin
    sync_d[0] = btn;
    sync_d[1] = sync_q[0];
    ctr_d = ctr_q + 1'b1;
 
    if (ctr_q == {20{1'b1}}) begin
      ctr_d = ctr_q;
    end
 
    if (!sync_q[1])
      ctr_d = 20'd0;
  end
 
  always @(posedge clk) begin
    ctr_q <= ctr_d;
    sync_q <= sync_d;
  end
 
endmodule
