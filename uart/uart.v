module uart_tx(
  input clk,
  input start,
  input [7:0] data,
  output reg q = 1'b1
);

reg [23:0] cnt = 24'b0;
reg [3:0] bit_num = 4'b1111;

// To make speed 9600 bit/s: 5208 = 50MHz / 9600bit/s
wire bit_start = (cnt == 5208);
// To make speed 8 bit/s: 6'250k = 50Mhz / 8bit/s
// wire bit_start = (cnt == 6250000);

wire idle = (bit_num == 4'hF);

always @(posedge clk) begin
  if (start && idle)
    cnt <= 24'b0;
  else if (bit_start)
    cnt <= 24'b0;
  else
    cnt <= cnt + 24'b1;
end

always @(posedge clk) begin
  if (start && idle) begin
    bit_num <= 4'h0;
    q <= 1'b0;
  end
  else if (bit_start) begin
    case (bit_num)
      4'h0: begin bit_num <= 4'h1; q <= data[0]; end
      4'h1: begin bit_num <= 4'h2; q <= data[1]; end
      4'h2: begin bit_num <= 4'h3; q <= data[2]; end
      4'h3: begin bit_num <= 4'h4; q <= data[3]; end
      4'h4: begin bit_num <= 4'h5; q <= data[4]; end
      4'h5: begin bit_num <= 4'h6; q <= data[5]; end
      4'h6: begin bit_num <= 4'h7; q <= data[6]; end
      4'h7: begin bit_num <= 4'h8; q <= data[7]; end
      4'h8: begin bit_num <= 4'h9; q <= 1'b1; end
      default: begin bit_num <= 4'hF; end
    endcase
  end
end

endmodule
