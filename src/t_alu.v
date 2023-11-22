module t_alu();
    reg [2:0] a;
    reg [2:0] b;
    reg [2:0] command;
    wire [2:0] sum;
    

    alu alu_instance(a, b, command, sum);

    
    initial begin 
        a = 4;
        b = 5;
        command = 3'b0;
    end

    initial
    begin
        $monitor("a:%d (%b)   b%d (%b)   command:%b   res:%d (%b)", a, a, b, b, command, sum, sum);

        #1

        command <= 3'b001;

        #1

        command <= 3'b010;

        #1

        command <= 3'b011;

        #1

        command <= 3'b100;

        #1

        command <= 3'b101;

        #1

        command <= 3'b110;

        #1

        command <= 3'b111;

        #1

        command <= 3'b000;
    end
    

endmodule
