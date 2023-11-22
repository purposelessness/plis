module alu
    #(
    parameter len_A = 3,
    parameter len_B = 3,
    parameter len_F = 3
    )

    (input [len_A - 1:0] a,
     input [len_B - 1:0] b,
    input [2:0] op,
    output reg [len_F - 1:0] f);

    reg [2:0] ram [0:6];
    initial begin
        ram[0] = 3'b001;
        ram[1] = 3'b010;
        ram[2] = 3'b011;
        ram[3] = 3'b100;
        ram[4] = 3'b101;
        ram[5] = 3'b110;
        ram[6] = 3'b111;
    end

    always @(a or b or op)
    begin
        case (op)
            ram[0]: f = a + b;
            ram[1]: f = a - b;
            ram[2]: f = a & b;
            ram[3]:  f = a | b;
            ram[4]: f = a < b;
            ram[5]:  f = a << 1;
            ram[6]:  f = b >> 1;
            default: f = {len_F{1'bX}};
        endcase
    end
endmodule
