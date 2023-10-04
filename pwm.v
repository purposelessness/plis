module pwm(
  input wire clk,
  output wire port
);

reg port_r = 1'b0;
reg [5:0]clk_bus = 6'b0;
wire clk_24khz;

assign port = port_r;
assign clk_24khz = clk_bus[5];

always @ (posedge clk) begin
  clk_bus <= clk_bus + 1'b1;
end

always @ (posedge clk_24khz) begin
  if (port_r == 1'b0) begin
    port_r <= 1'b1;
  end else begin
    port_r <= 1'b0;
  end
end

endmodule
