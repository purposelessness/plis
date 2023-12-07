module test();
    reg system_clk;
    reg [7:0] data;
    wire can_write;
    reg clk;
    reg clk_8x;
    wire out;
    wire miso;
    reg counter;
    reg slave_num;
    wire sclk;
    wire mosi;
    wire cs1;
    wire cs2;
    wire [7:0] slave_data_on_master;
    wire uart_tx;
    wire [7:0] uart_readed;
    wire clk_10_8;
    wire clk_8x_10_8;

    spi_master_2 master(clk, miso, data, slave_num, can_write, slave_data_on_master, sclk, mosi, cs1, cs2);

    spi_to_uart stu(system_clk,sclk,cs1,mosi,miso,uart_tx);

    freq_10_8 freq_receiver(system_clk,clk_8x,clk_8x_10_8);

    uart_receiver rx(clk_8x_10_8,uart_tx, uart_readed);

    initial begin 
        $dumpfile("out.vcd");
        $dumpvars(0,test);
        clk = 1'b0;
        data = 8'b0;
        slave_num = 1'b0;
        counter = 1'b0;
        system_clk = 1'b0;
        clk_8x <= 1'b0;
    end

    always@ (posedge can_write) begin
        // slave_num <= ~slave_num;
        data <= data + 3;
    end


    always #800 clk = ~clk;

    always #10 system_clk = ~system_clk;

    always #100 clk_8x <= ~clk_8x;

    initial
    begin
        #600000
        $finish;
    end

endmodule