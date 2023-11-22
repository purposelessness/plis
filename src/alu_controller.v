module alu_controller(
    input wire clk,
    input wire com,
    input wire inc_guess,
    output wire led
);


wire [2:0] res;
reg [2:0] guess = 3'b000;

assign led = guess == res;

reg [2:0] a = 4;
reg [2:0] b = 5;
reg [2:0] command = 3'b001;

alu alu_instance(a, b, command, res);

always @(posedge inc_guess) begin
  guess <= guess + 1'b1;
end

always @(posedge com) begin
  command <= command + 1'b1;
end

endmodule
