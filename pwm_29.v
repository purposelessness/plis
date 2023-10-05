`define VAR 29 

module pwm_29(
  input wire in,
  output reg out
);

reg [4:0] counter;
wire indicator = counter[4];

initial begin
  counter = 28;
  out = 0;
end

always @ (in) begin
  if ((counter + 1) % `VAR == 0) begin
    counter <= 0;
  end else begin
    counter <= counter + 1;
  end
end

always @ (negedge indicator) begin
  out <= ~out;
end

endmodule
