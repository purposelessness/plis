module spi_to_uart (
    input clk,
    input SCLK,
    input CS,
    input MOSI,
    output wire MISO,
    output wire uart_tx
);
    wire [7:0] readed_data;
    wire data_saved;
    wire sclk_10_8;

    spi_slave slave(SCLK,CS,MOSI,MISO,readed_data);
    uart_transmitter tx(sclk_10_8,readed_data,uart_tx,data_saved);
    freq_10_8 freq_multiplier(clk,SCLK,sclk_10_8);
endmodule