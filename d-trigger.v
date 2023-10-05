module d_trigger(
  input wire clk,
  input wire reset,
  input wire [7:0] in,
  output reg [7:0] out
);

always @ (posedge clk or posedge reset) begin
  if (reset) begin
    out <= 0;
  end else begin
    out <= in;
  end
end

endmodule
