module indicator_7(
  input wire [3:0] code,
  output reg [6:0] segments
);

parameter CODES = 8;

wire [2:0] code_mod;
assign code_mod = code % CODES;

always @ (code_mod) begin
  case (code_mod)
    0: segments = 7'b0000000;
    1: segments = 7'b0101010;
    2: segments = 7'b1010101;
    3: segments = 7'b1110000;
    4: segments = 7'b0001111;
    5: segments = 7'b1100011;
    6: segments = 7'b0011100;
    7: segments = 7'b1111111;
  endcase
end

endmodule
