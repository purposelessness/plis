module test();

    reg [7:0] data;
    wire can_write;
    reg clk;
    wire out;
    reg miso;
    reg counter;
    reg slave_num;
    wire sclk;
    wire mosi;
    wire cs1;
    wire cs2;
    wire [7:0] slave_data;

    spi_master_2 master(clk, miso, data, slave_num, can_write, slave_data, sclk, mosi, cs1, cs2);

    initial begin 
        $dumpfile("out.vcd");
        $dumpvars(0,test);
        clk = 1'b0;
        data = 8'b0;
        miso <= 1'b0;
        slave_num <= 1'b0;
        counter <= 1'b0;
    end

    always@ (posedge can_write) begin
        slave_num <= ~slave_num;
        data <= data + 3;
    end


    always #10 clk = ~clk;

    initial
    begin
        #3000
        $finish;
    end

endmodule