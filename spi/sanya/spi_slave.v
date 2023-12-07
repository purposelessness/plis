module spi_slave (
    input SCLK,
    input CS,
    input MOSI,
    output reg MISO,
    output reg [0:7] readed_data
);

reg [2:0] counter;
reg [0:7] buffer;

initial begin
    readed_data <= 8'bx;
    MISO <= 1'bz;
end

always @(negedge CS) begin
    counter <= 3'b0;
end

always @(posedge SCLK) begin
    if (CS == 1'b0) begin
        MISO <= readed_data[counter];
    end
    else begin
        MISO <= 1'bz;
    end
end

always @(negedge SCLK) begin
    if (CS == 1'b0) begin
        buffer[counter] = MOSI;

        if (counter == 7) begin
            readed_data <= buffer;
        end

        counter <= counter + 1;
    end
end

endmodule