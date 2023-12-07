module freq_10_8 (
        input clk,
        input clk_in,
        output reg clk_out
    );

    reg [29:0] clk_counter_edge;
    reg [29:0] clk_counter;
    reg [2:0] tick_counter;
    reg count_start;
    reg count_end;

    always @(clk_in) begin
        if(count_start == 1'b0) begin
            tick_counter <= 3'b111;
            clk_counter_edge <= 30'b0;
            count_start <= 1'b1;
        end
        else begin
            if(count_end == 1'b0) begin
                count_end = 1'b1;
                clk_counter = 30'b1;
                clk_out = clk_in;
            end 
        end
    end

    always @(clk) begin
        if(count_start & count_end) begin
            if (clk_counter == clk_counter_edge) begin
                    clk_counter <= 30'b1;
                    clk_out = ~clk_out;
                end
            else begin
                clk_counter <= clk_counter + 1;
            end
        end
        else begin
            tick_counter <= tick_counter + 1;
        end
    end

    always @(tick_counter) begin
        if (tick_counter != 3'b111) begin
            case(tick_counter)
                3'b100:
                    begin
                        tick_counter <= 3'b111;
                    end
                default:
                    begin
                        clk_counter_edge = clk_counter_edge + 1;
                    end
            endcase
        end
    end

    initial begin
        count_start <= 1'b0;
        count_end <= 1'b0;
    end
endmodule