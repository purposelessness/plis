module indicator_control(
  input wire key_a,
  input wire key_b,
  output reg [6:0] segments
);

parameter CODES = 8;

reg [2:0] code_mod = 0;

always @ (posedge key_a) begin
  code_mod = code_mod == 0 ? 
             CODES - 1 : code_mod - 1;
end

always @ (posedge key_b) begin
  code_mod = code_mod + 1 == CODES ? 
             0 : code_mod + 1;
end

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
