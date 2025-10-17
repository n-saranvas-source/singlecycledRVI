module PCplus4(fromPC, NexttoPC);
input [31:0]fromPC;
output [31:0] NexttoPC;

assign NexttoPC =fromPC + 32'h00000004;

endmodule
