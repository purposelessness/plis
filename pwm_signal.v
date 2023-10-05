module pwm_register(
  input wire in,
  input wire sig,
  output wire out
);

parameter MAX_LEVEL = 10;
reg [3:0] level = 5;

reg [3:0] counter;
wire indicator = counter[3];

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

always @ (posedge sig) begin
  if (level < MAX_LEVEL) begin
    level = level + 1;
  end else begin
    level <= 0;
  end
end

endmodule
