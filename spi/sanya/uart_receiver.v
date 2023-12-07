module uart_receiver (
    input clk_8x,
    input uart_rx,
    output reg[7:0] out
);
    reg [2:0] tick_counter;

    reg [2:0] bit_low;
    reg [2:0] bit_high;
    reg readed_bit;
    reg [9:0] package_read;
    reg [3:0] bit_counter;
    reg read_properly;

    initial begin
        tick_counter <= 3'b0;
        bit_counter <= 4'b0;
        bit_counter <= 4'b1111;
        read_properly <= 1'b0;

    end

    always @(posedge clk_8x) begin
        case(tick_counter)
            3'b111: 
                begin
                    if (uart_rx == 1'b1) begin
                        bit_high <= bit_high + 1;
                    end
                    else begin
                        bit_low <= bit_low + 1;    
                    end

                    if(bit_high > bit_low)
                        begin
                            readed_bit <= 1'b1;
                        end
                    else
                        begin
                            readed_bit <= 1'b0;
                        end

                    bit_counter <= bit_counter + 1;
                    tick_counter <= 3'b0;
                    bit_high <= 3'b0;
                    bit_low <= 3'b0;

                    if(bit_high == bit_low)
                        begin
                            tick_counter <= 3'b100;
                        end
                end
            default: 
                begin
                    if (uart_rx == 1'b1) begin
                        bit_high <= bit_high + 1;
                    end
                    else begin
                        bit_low <= bit_low + 1;    
                    end
                    tick_counter <= tick_counter + 1;
                end
        endcase
    end
    
    always @(bit_counter) begin
        if (bit_counter != 4'b1111) 
        begin
            if (bit_counter == 4'b0000 & read_properly == 1'b0)
                begin
                    if(readed_bit == 1'b0) 
                        begin
                            read_properly = 1'b1;
                        end
                    else
                        begin
                            bit_counter <= 4'b1111;
                        end
                end
            
            if (read_properly == 1'b1)
                begin
                    case(bit_counter)
                        4'b1001: 
                            begin
                                package_read[bit_counter] <= readed_bit;
                                if (package_read[0] == 1'b0 & package_read[9] == 1'b1) 
                                    begin
                                        read_properly <= 1'b1;
                                        out <= {package_read[1],
                                        package_read[2],
                                        package_read[3],
                                        package_read[4],
                                        package_read[5],
                                        package_read[6],
                                        package_read[7],
                                        package_read[8]};
                                    end
                                else 
                                    begin
                                        out <= 8'bx;
                                        read_properly <= 1'b0;
                                    end
                                bit_counter <= 4'b1111;
                            end
                        default:
                            begin
                                package_read[bit_counter] <= readed_bit;
                            end
                    endcase 
                end
        end
    end

endmodule