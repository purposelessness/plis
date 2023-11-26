module uart_r(
  input clk,
  input q,
  output reg [7:0] data = 8'b0
);

reg [23:0] cnt = 24'b0;
reg [3:0] bit_num = 4'b1111;

reg [7:0] internal_data = 8'b0;

// To make speed 9600 bit/s: 5208 = 50MHz / 9600bit/s
wire bit_start = (cnt == 5208);
// To make speed 8 bit/s: 6'250k = 50Mhz / 8bit/s
// wire bit_start = (cnt == 6250000);

wire idle = (bit_num == 4'hF);

always @(posedge clk) begin
  if (!q && idle)
    cnt <= 24'b0;
  else if (bit_start)
    cnt <= 24'b0;
  else
    cnt <= cnt + 24'b1;
end

always @(posedge clk) begin
  if (!q && idle) begin
    bit_num <= 4'h0;
  end
  else if (bit_start) begin
    case (bit_num)
      4'h0: begin bit_num <= 4'h1; internal_data[0] <= q; end
      4'h1: begin bit_num <= 4'h2; internal_data[1] <= q; end
      4'h2: begin bit_num <= 4'h3; internal_data[2] <= q; end
      4'h3: begin bit_num <= 4'h4; internal_data[3] <= q; end
      4'h4: begin bit_num <= 4'h5; internal_data[4] <= q; end
      4'h5: begin bit_num <= 4'h6; internal_data[5] <= q; end
      4'h6: begin bit_num <= 4'h7; internal_data[6] <= q; end
      4'h7: begin bit_num <= 4'h8; internal_data[7] <= q; end
      4'h8: begin
        bit_num <= 4'h9;
        data <= internal_data;
        internal_data <= 8'b0;
      end
      default: begin bit_num <= 4'hF; end
    endcase
  end
end

endmodule
