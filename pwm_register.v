module pwm_register(
  input wire in,
  input wire [7:0] level,
  output wire out
);

parameter MAX_LEVEL = 255;

reg [7:0] counter;
wire indicator = counter[4];

assign out = counter > level;

initial begin
  counter = 0;
end

always @ (posedge in) begin
  if (counter == MAX_LEVEL) begin
    counter <= 1;
  end else begin
    counter <= counter + 1;
  end
end

endmodule
