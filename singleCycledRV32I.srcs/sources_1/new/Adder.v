module Adder(in_1, in_2, sum);
input [31:0] in_1, in_2;
output reg[31:0] sum;

//assign sum = in_1+in_2;
    always @(*) begin
        sum <= in_1+in_2;  
    end

endmodule
