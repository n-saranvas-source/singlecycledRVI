`timescale 1ns / 1ps


module Control_Unit(reset,OPcode, branch, MemRead,MemtoReg, MemWrite, ALUSrc, RegWrite, ALUOp_out);

input [6:0]OPcode;
input reset;
output reg branch, MemRead,MemtoReg, MemWrite, ALUSrc, RegWrite;
output reg [1:0]ALUOp_out;

always@(*)
begin
if(reset == 1'b1)
begin
{ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, branch, ALUOp_out} <= 7'b0000000;
end
else begin 
case(OPcode)
7'b0110011:          //For R-Type
begin
  ALUSrc<=0;
  MemtoReg<=0;
  RegWrite<=1;
  MemRead<=0;
  MemWrite <=0;
  branch<=0; 
  ALUOp_out<=2'b10;
end

7'b0010011:   // I-type
begin
  ALUSrc<=1;
  MemtoReg<=0;
  RegWrite<=1;
  MemRead<=0;
  MemWrite <=0;
  branch<=0; 
  ALUOp_out<=2'b10;
end

7'b0000011: //Load instr
begin
ALUSrc <= 1;
MemtoReg<=1;
RegWrite<=1;
MemRead<=1;
MemWrite <=0;
branch<=0;
ALUOp_out<=2'b00;
end

7'b0100011:    //Store instr
begin
ALUSrc <= 1;
MemtoReg<=0;
RegWrite<=0;
MemRead<=0;
MemWrite <=1;
branch<=0;
ALUOp_out<=2'b00;
end

7'b1100011:  //branch equal instr
begin
ALUSrc <= 0;
MemtoReg<=0;
RegWrite<=0;
MemRead<=0;
MemWrite <=0;
branch<=1;
ALUOp_out<=2'b11;
end

 7'b1101111:   // Jump 
 begin  {ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, branch, ALUOp_out} <= {1'b0, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 2'b10};end


 7'b0110111:   // LUI

 begin {ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, branch, ALUOp_out} <= {1'b0, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 2'b10};end

default:
begin
ALUSrc <= 0;
MemtoReg<=0;
RegWrite<=0;
MemRead<=0;
MemWrite <=0;
branch<=0;
ALUOp_out<=2'b00;
end


endcase
end
end
      
      
endmodule
