module t_alu_2();
    reg [3:0] a;
    reg [3:0] b;
    reg [2:0] command;
    wire [3:0] sum;
    

    alu alu_instance(a, b, command, sum);

    
    initial begin 
        a <= 4'b0;
        b <= 5'b0;
        command <= 5'b0;
    end

    initial
    begin
        $monitor("a:%d (%b)   b%d (%b)   command:%b   res:%d (%b)", a, a, b, b, command, sum, sum);

        #10

        a <= 10;
        b <= 1;
        command <= 3'b001;

        #10

        command <= 3'b010;

        #10

        a <= 4'b1011;
        b <= 5'b10101;
        command <= 3'b011;

        #10

        command <= 3'b100;

        #10

        a <= 15;
        command <= 3'b110;

        #10

        a <= 15;
        b <= 12;
        command <= 3'b101;

        #10

        a <= 12;
        b <= 15;
        command <= 3'b101;

        #10

        b <= 21;
        command <= 3'b111;
    end
    

endmodule
