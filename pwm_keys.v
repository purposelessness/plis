module pwm_register(
  input wire in,
  input wire inc,
  input wire dec,
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

always @ (posedge in) begin
  if (inc) begin
    if (level < MAX_LEVEL) begin
      level = level + 1;
    end
  end else if (dec) begin
    if (level > 0) begin
      level = level - 1;
    end
  end
end

endmodule
