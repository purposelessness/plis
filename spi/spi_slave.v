module spi_slave(
  input clk,
  input cs,
  input r_mosi,
  output reg w_miso,
  output reg [0:7] w_data,
  output reg w_data_done
);


reg [2:0] counter;
reg [7:0] buffer;
reg data_done = 1'b0;


initial begin
  counter <= 3'b0;
  buffer <= 8'b0;
end


initial begin
  w_data <= 8'bx;
  w_miso <= 1'bz;
end


always @(negedge cs) begin
  counter <= 3'b0;
  w_data_done <= 1'b0;
end


always @(negedge clk) begin
  if (cs == 1'b0) begin
    w_miso <= 1'b0;
  end
  else begin
    w_miso <= 1'bz;
  end
end


always @(negedge clk) begin
  if (cs == 1'b0) begin
    buffer[7 - counter] = r_mosi;

    if (counter == 7) begin
      w_data <= buffer;
      counter <= 1'b0;
      w_data_done <= 1'b1;
    end

    counter <= counter + 1;
  end
end


endmodule
