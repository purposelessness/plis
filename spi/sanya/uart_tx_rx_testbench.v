module test();

    reg [7:0] data;
    wire [7:0] out_data;
    wire can_write;
    reg clk_x;
    reg clk_8x;
    wire out_tx;
    reg delay_flag;
    reg delay_flag_set;

    uart_transmitter uart_tx(clk_x, data, out_tx, can_write);
    uart_receiver uart_rx(clk_8x, out_tx, out_data);

    initial begin 
        $dumpfile("out.vcd");
        $dumpvars(0,test);
        clk_x = 1'b0;
        clk_8x = 1'b0;
        data = 8'b0;
        delay_flag <= 1'b0;
        delay_flag_set <= 1'b0;
    end

    always@ (posedge can_write) begin
        data <= data + 3;
    end

    always #80 clk_x = ~clk_x;
    always #10 begin
        if(delay_flag == 1'b0) begin
            if(delay_flag_set == 1'b0)
            begin
                delay_flag_set <= 1'b1;
                #534;
                delay_flag <= 1'b1;
            end
        end
        else begin
           clk_8x = ~clk_8x; 
        end
    end

    initial
    begin
        #60000
        $finish;
    end

endmodule