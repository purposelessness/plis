module test();

    reg [7:0] data;
    wire can_write;
    reg clk;
    wire out;

    uart_transmitter uart_tx(clk, data, out, can_write);

    initial begin 
        $dumpfile("out.vcd");
        $dumpvars(0,test);
        clk = 1'b0;
        data = 8'b0;
    end

    always@ (posedge can_write) begin
        data <= data + 3;
    end

    always #10 clk = ~clk;

    initial
    begin
        #3000
        $finish;
    end

endmodule