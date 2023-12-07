module spi_master
#(parameter SPI_MODE = 3,
  parameter CLKS_PER_HALF_BIT = 2)
(
 // Control/Data Signals,
 input        r_reset,     // FPGA Reset
 input        r_clk,       // FPGA Clock

 // TX (MOSI) Signals
 input [7:0]  r_data,        // Byte to transmit on MOSI
 input        r_data_ready,          // Data Valid Pulse with r_data 
 output reg   w_data_ready,       // Transmit Ready for next byte

 // RX (MISO) Signals
 output reg       w_master_done,     // Data Valid pulse (1 clock cycle)
 output reg [7:0] w_data,   // Byte received on MISO

 // SPI Interface
 output reg w_clk,
 input      r_miso,
 output reg w_mosi
 );

// SPI Interface (All Runs at SPI Clock Domain)
wire cpol;     // Clock polarity
wire cpha;     // Clock phase

reg [$clog2(CLKS_PER_HALF_BIT*2)-1:0] clk_count;
reg clk;
reg [4:0] clk_edges;
reg leading_edge;
reg trailing_edge;
reg       data_ready;
reg [7:0] data;

reg [2:0] rx_bit_count;
reg [2:0] tx_bit_count;

// CPOL: Clock Polarity
// CPOL=0 means clock idles at 0, leading edge is rising edge.
// CPOL=1 means clock idles at 1, leading edge is falling edge.
assign cpol  = (SPI_MODE == 2) | (SPI_MODE == 3);

// CPHA: Clock Phase
// CPHA=0 means the "out" side changes the data on trailing edge of clock
//              the "in" side captures data on leading edge of clock
// CPHA=1 means the "out" side changes the data on leading edge of clock
//              the "in" side captures data on the trailing edge of clock
assign cpha  = (SPI_MODE == 1) | (SPI_MODE == 3);



// Purpose: Generate SPI Clock correct number of times when DV pulse comes
always @(posedge r_clk or negedge r_reset)
begin
  if (~r_reset)
  begin
    w_data_ready      <= 1'b0;
    clk_edges <= 0;
    leading_edge  <= 1'b0;
    trailing_edge <= 1'b0;
    clk       <= cpol; // assign default state to idle state
    clk_count <= 0;
  end
  else
  begin

    // Default assignments
    leading_edge  <= 1'b0;
    trailing_edge <= 1'b0;
    
    if (r_data_ready)
    begin
      w_data_ready      <= 1'b0;
      clk_edges = 16;  // Total # edges in one byte ALWAYS 16
    end
    
    if (clk_edges > 0)
    begin
      w_data_ready <= 1'b0;
      
      if (clk_count == CLKS_PER_HALF_BIT*2-1)
      begin
        clk_edges <= clk_edges - 1;
        trailing_edge <= 1'b1;
        clk_count <= 0;
        clk       <= ~clk;
      end
      else if (clk_count == CLKS_PER_HALF_BIT-1)
      begin
        clk_edges <= clk_edges - 1;
        leading_edge  <= 1'b1;
        clk_count <= clk_count + 1;
        clk       <= ~clk;
      end
      else
      begin
        clk_count <= clk_count + 1;
      end
    end  
    else
    begin
      w_data_ready <= 1'b1;
    end
    
    
  end // else: !if(~r_reset)
end // always @ (posedge r_clk or negedge r_reset)


// Purpose: Register r_data when Data Valid is pulsed.
// Keeps local storage of byte in case higher level module changes the data
always @(posedge r_clk or negedge r_reset)
begin
  if (~r_reset)
  begin
    data <= 8'h00;
    data_ready   <= 1'b0;
  end
  else
    begin
      data_ready <= r_data_ready; // 1 clock cycle delay
      if (r_data_ready)
      begin
        data <= r_data;
      end
    end // else: !if(~r_reset)
end // always @ (posedge r_clk or negedge r_reset)


// Purpose: Generate MOSI data
// Works with both CPHA=0 and CPHA=1
always @(posedge r_clk or negedge r_reset)
begin
  if (~r_reset)
  begin
    w_mosi     <= 1'b0;
    tx_bit_count <= 3'b111; // send MSb first
  end
  else
  begin
    // If ready is high, reset bit counts to default
    if (w_data_ready)
    begin
      tx_bit_count <= 3'b111;
    end
    // Catch the case where we start transaction and CPHA = 0
    else if (data_ready & ~cpha)
    begin
      w_mosi     <= data[3'b111];
      tx_bit_count <= 3'b110;
    end
    else if ((leading_edge & cpha) | (trailing_edge & ~cpha))
    begin
      tx_bit_count <= tx_bit_count - 1;
      w_mosi     <= data[tx_bit_count];
    end
  end
end


// Purpose: Read in MISO data.
always @(posedge r_clk or negedge r_reset)
begin
  if (~r_reset)
  begin
    w_data      <= 8'h00;
    w_master_done        <= 1'b0;
    rx_bit_count <= 3'b111;
  end
  else
  begin

    // Default Assignments
    w_master_done   <= 1'b0;

    if (w_data_ready) // Check if ready is high, if so reset bit count to default
    begin
      rx_bit_count <= 3'b111;
    end
    else if ((leading_edge & ~cpha) | (trailing_edge & cpha))
    begin
      w_data[rx_bit_count] <= r_miso;  // Sample data
      rx_bit_count         <= rx_bit_count - 1;
      if (rx_bit_count == 3'b000)
      begin
        w_master_done   <= 1'b1;   // Byte done, pulse Data Valid
      end
    end
  end
end


// Purpose: Add clock delay to signals for alignment.
always @(posedge r_clk or negedge r_reset) begin
  if (~r_reset) begin
    w_clk  <= cpol;
  end
  else begin
    w_clk <= clk;
  end // else: !if(~r_reset)
end // always @ (posedge r_clk or negedge r_reset)


endmodule // SPI_Master
