module alu
    #(
    parameter addab = 3'b001,
    subab = 3'b010,
    andab = 3'b011,
    orab = 3'b100,
    ltab = 3'b101,
    shifta = 3'b110,
    shiftb = 3'b111,
    
    parameter len_A = 4,
    parameter len_B = 5,
    parameter len_F = 5
    )

    (input [len_A - 1:0] a,
     input [len_B - 1:0] b,
    input [2:0] op,
    output reg [len_F - 1:0] f);

    always @(a or b or op)
    begin
        case (op)
            addab: f = a + b;
            shifta:  f = a + 1;
            shiftb:  f = b + 1;
            andab: f = a & b;
            orab:  f = a | b;
            subab: f = a - b;
            ltab: f = a < b;
            default: f = {len_F{1'bX}};
        endcase
    end
endmodule
