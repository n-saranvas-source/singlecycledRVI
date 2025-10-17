
module ALUControl(ALUOp_in,func7,func3, ALUControl_out);

input [1:0]ALUOp_in;

input [6:0]func7;

input [2:0]func3;
output reg[3:0]ALUControl_out;

always @ (*) begin
case({ALUOp_in,func7,func3})

    12'b10_0000000_000 : ALUControl_out <= 4'b0000;    // ADD 
    12'b00_0000000_000 : ALUControl_out <= 4'b0000;    // ADD 
    12'b00_0000000_001 : ALUControl_out <= 4'b0000;    // ADD 
    12'b00_0000000_010 : ALUControl_out <= 4'b0000;    // ADD 
    12'b10_0100000_000 : ALUControl_out <= 4'b0001;    // SUB 
    12'b10_0000000_111 : ALUControl_out <= 4'b0010;    // AND
    12'b10_0000000_110 : ALUControl_out <= 4'b0011;    // OR
    12'b10_0000000_100 : ALUControl_out <= 4'b0100;    // XOR
    12'b10_0000000_001 : ALUControl_out <= 4'b0101;    // SLL
    12'b10_0000000_101 : ALUControl_out <= 4'b0110;    // SRL
    12'b10_0100000_101 : ALUControl_out <= 4'b0111;    // SRA
    12'b10_0000000_010 : ALUControl_out <= 4'b1000;    // SLT
    default            : ALUControl_out <= 4'b0000; 

endcase
end


endmodule
