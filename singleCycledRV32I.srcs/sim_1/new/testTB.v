`timescale 1ns / 1ps


module testTB();
reg clk,reset;
RISCV_TOP DUT(.clk(clk),.reset(reset));
initial begin
clk =0;
end
always #5 clk = ~clk;

initial begin
reset = 1'b1;
#5;
reset = 1'b0;
#400;

$finish;
end

endmodule
