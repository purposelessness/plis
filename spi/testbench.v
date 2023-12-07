module spi_testbench();
  
parameter SPI_MODE = 3; // CPOL = 0, CPHA = 0
parameter CLKS_PER_HALF_BIT = 2;
parameter MAIN_CLK_DELAY = 2;

reg w_reset = 1'b0;
wire r_spi_clk;
reg clk = 1'b0;
wire spi_mosi;

// Master Specific
reg [7:0] w_master_data = 0;
reg w_master_data_ready = 1'b0;
wire r_master_data_ready;
wire r_mater_data_done;
wire [7:0] r_master_data;

// Clock Generators:
always #(MAIN_CLK_DELAY) clk = ~clk;

reg master_miso = 1'b0;

spi_master
#(.SPI_MODE(SPI_MODE),
  .CLKS_PER_HALF_BIT(CLKS_PER_HALF_BIT)) spi_master_instance
(
 // Control/Data Signals,
 .r_reset(w_reset),              // FPGA Reset
 .r_clk(clk),                    // FPGA Clock
 
 // TX (MOSI) Signals
 .r_data(w_master_data),      // Byte to transmit on MOSI
 .r_data_ready(w_master_data_ready),  // Data Valid Pulse with i_TX_Byte
 .w_data_ready(r_master_data_ready), // Transmit Ready for Byte
 
 // RX (MISO) Signals
 .w_master_done(r_mater_data_done),    // Data Valid pulse (1 clock cycle)
 .w_data(r_master_data),      // Byte received on MISO

 // SPI Interface
 .w_clk(r_spi_clk),
 .r_miso(master_miso),
 .w_mosi(spi_mosi)
);

reg cs = 1'b1;
wire slave_miso;
wire [7:0] slave_data;
wire slave_data_done 1'b0;

spi_slave spi_slave_instance(
  .clk(r_spi_clk),
  .cs(cs),
  .r_mosi(spi_mosi),
  .w_miso(slave_miso),
  .w_data(slave_data),
  .w_data_done(slave_data_done)
);


initial begin
  $dumpfile("dump.vcd"); 
  $dumpvars;

#10

  w_master_data <= 8'hC1;
  w_master_data_ready <= 1'b1;
  w_reset <= 1'b1;
  cs <= 1'b0;

#10

  w_master_data_ready <= 1'b0;

end // initial begin

initial begin
  #10000
  $finish();
end

endmodule
