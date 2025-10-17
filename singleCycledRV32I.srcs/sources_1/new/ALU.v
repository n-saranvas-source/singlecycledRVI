`timescale 1ns / 1ps
module ALU(A,B,zero,ALUControl_in,ALU_result);

input [31:0] A,B;
input[3:0]ALUControl_in;
output reg[31:0]ALU_result;
output reg zero;

always@(ALUControl_in or A or B)// need to check the zero 
begin
case(ALUControl_in)
4'b0000:begin 
 ALU_result = A+B; end
4'b0011:begin 
ALU_result = A|B; end
4'b0010:begin 
ALU_result = A&B; end
4'b0100: begin 
ALU_result = A^B; end
4'b0101: begin 
ALU_result = A << B[4:0]; end // SLL (Shift Left Logical)
4'b0110: begin 
 ALU_result = A >> B[4:0];   end  		// SRL (Shift Right Logical)
4'b0111: begin 
ALU_result = $signed(A) >>> B[4:0]; end   // SRA (Shift Right Arithmetic)
4'b1000: begin  
ALU_result =($signed(A) < $signed(B)) ? 32'b1 : 32'b0;end

4'b0001:begin  

ALU_result = A-B; 
end
default : begin 
ALU_result = 32'b0; end
endcase
zero = (ALU_result == 32'b0) ? 1 : 0;
end



endmodule
