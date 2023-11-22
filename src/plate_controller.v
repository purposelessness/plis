module plate_controller(
    input wire clk,
    input wire com_btn,
    input wire inc_a_btn,
    output wire led,
    output wire led_btn
);

wire com;
wire inc_a;

button_debouncer com_debouncer(clk, com_btn, com);
button_debouncer inc_a_debouncer(clk, inc_a_btn, inc_a);

alu_controller alu_controller_instance(clk, com, inc_a, led);

reg led_btn_on = 0;
assign led_btn = led_btn_on;

always @(posedge com or posedge inc_a) begin
  led_btn_on <= ~led_btn_on;
end

endmodule
