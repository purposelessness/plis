module top(
  input clk,
  output txd
);

reg [15:0] cnt = 16'b0;
reg [2:0] rom_addr = 3'b111;
reg uart_start = 1'b0;

always @(posedge clk) begin
  if (cnt == 16'b0) begin
    rom_addr <= rom_addr + 3'b1;
    uart_start <= 1'b1;
  end
  else begin
    uart_start <= 1'b0;
  end

  cnt <= cnt + 16'b1;
end

wire [7:0] uart_data;
wire [7:0] receiver_data;

rom rom(rom_addr, clk, uart_data);

uart_tx uart_tx(clk, uart_start, uart_data, txd);
uart_r uart_r(clk, txd, receiver_data);

endmodule
