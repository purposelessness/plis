module spi_master_2 (
    input clk,
    input MISO,
    input [0:7] data,
    input slave_num,
    output reg data_saved,
    output reg [0:7] slave_data,
    output reg SCLK,
    output reg MOSI,
    output reg CS1,
    output reg CS2
);
    reg [0:7] data_to_send;
    reg [0:7] data_received;
    reg slave_to_send;
    reg [2:0] counter;

    initial begin
        slave_data <= 8'bx;
        MOSI <= 1'bx;
        counter <= 3'b0;
        data_to_send <= 8'bx;
        CS1 <= 1'b1;
        CS2 <= 1'b1;
    end

    always @(clk) begin
        SCLK <= clk;
    end

    always @(posedge SCLK) begin
        case(counter)
            3'b000: 
                begin

                    data_to_send <= data;
                    slave_to_send <= slave_num;
                    data_saved <= 1'b1;
                    MOSI <= data_to_send[counter];

                    case(slave_to_send)
                        1'b0:
                            begin
                                CS1 = 1'b0;        
                            end
                        1'b1:
                            begin
                                CS2 = 1'b0;
                            end
                    endcase
                end
            default:
                begin
                    MOSI <= data_to_send[counter];
                end
        endcase
    end

    always @(negedge SCLK) begin
        case(counter)
            3'b111: 
                begin
                    data_received[counter] = MISO;
                    slave_data <= data_received;
                    counter <= counter + 1;
                    CS1 <= 1'b1;
                    CS2 <= 1'b1;
                end
            default:
                begin
                    data_received[counter] <= MISO;
                    counter <= counter + 1;
                end
        endcase
    end

    always @(data or slave_num) begin
        data_saved <= 1'b0;
    end

endmodule