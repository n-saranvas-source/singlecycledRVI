
module Mux3 (Sel3, A3, B3, Mux3_out);
input Sel3;
input [31:0]A3,B3;
output [31:0] Mux3_out;

assign Mux3_out = (Sel3 == 1'b0)? A3:B3;


endmodule
