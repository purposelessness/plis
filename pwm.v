module pwm(
  input wire clk,
  output wire port
);

reg port_r = 1'b0;
reg [11:0]clk_mem = 12'b0;
wire clk_24khz;

assign port = port_r;
assign clk_24khz = clk_mem[11];

always @ (clk) begin
  clk_mem <= clk_mem + 1'b1;
end

always @ (negedge clk_24khz) begin
  if (port_r == 1'b0) begin
    port_r <= 1'b1;
  end else begin
    port_r <= 1'b0;
  end
end

endmodule
