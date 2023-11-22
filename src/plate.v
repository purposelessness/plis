module plate(
    input wire clk,
    input wire com,
    input wire enter,
    output wire led
);


reg [2:0] command = 3'b001;
wire [2:0] o;
reg [2:0] tmp = 3'b000;

assign led = tmp == o;

reg [2:0] a = 6;
reg [2:0] b = 1;

alu  alu_instance(a, b, command, o);

always @ (posedge enter) begin
  tmp <= tmp + 1'b1;
end

always @ (posedge com) begin
  command <= command + 1'b1;
end

endmodule
