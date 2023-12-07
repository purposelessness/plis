module uart_transmitter(
        input clk,
        input [0:7] data,
        output reg uart_tx,
        output reg data_saved
    );
    
    reg [0:7] data_out;
    reg [3:0] counter; 

    initial begin
        uart_tx <= 1'b0;
        data_saved <= 1'b0;
        counter <= 4'b1001;
    end

    always @(posedge clk) begin
        case (counter)
            4'b1000: 
                begin
                    uart_tx <= 1'b1;
                    counter <= counter + 1;
                end
            4'b1001: 
                begin
                    uart_tx <= 1'b0;
                    data_out <= data;
                    data_saved <= 1'b1;
                    counter <= 4'b0000;
                end
            default: 
                begin
                    uart_tx <= data_out[counter];
                    counter <= counter + 1;
                end
        endcase
    end

    always @(data) begin
        data_saved <= 1'b0;
    end

endmodule