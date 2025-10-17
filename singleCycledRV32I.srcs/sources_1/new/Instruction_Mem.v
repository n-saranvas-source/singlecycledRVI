`timescale 1ns / 1ps
module Instruction_Mem(clk,reset, read_address, instruction_out);
input reset,clk;
input [31:0]read_address;
output [31:0]instruction_out;

reg [31:0] Imemory [63:0];

assign instruction_out = Imemory[read_address];
integer k;
always @ (posedge clk)//check may need to change to asyn
begin
if(reset) begin
for (k = 0; k<64; k=k+1)
begin
Imemory[k] = 32'h00000000;
end
end
else if (reset == 1'b0)
//r type
Imemory[0] = 32'b0000000_00000_00000_000_00000_0000000;//no operation
Imemory[4] = 32'b0000000_11001_10000_000_01101_0110011;//add x13 x16 x25
Imemory[8] = 32'b0100000_00011_01000_000_00101_0110011;// sub x5 x8, x3
Imemory[12] = 32'b0000000_00011_00010_111_00001_0110011;//and x1 x2, x3
Imemory[16] = 32'b0000000_00101_00011_110_00100_0110011;//or x4 x3 x5
Imemory[20] = 32'b0000000_00101_00011_100_00100_0110011;    // xor x4, x3, x5
Imemory[24] = 32'b0000000_00101_00011_001_00100_0110011;    // sll x4, x3, x5
Imemory[28] = 32'b0000000_00101_00011_101_00100_0110011;    // srl x4, x3, x5
Imemory[32] = 32'b0100000_00010_00011_101_00101_0110011;    //sra x5, x3, x2
Imemory[36] = 32'b0000000_00010_00011_010_00101_0110011;   //slt x5, x3, x2 
// i type
Imemory[40] = 32'b0000000_00010_10101_000_10110_0010011;//addi x22 x21 2
Imemory[44] = 32'b0000000_00011_01000_110_01001_0010011;//ori x9 x8 3
Imemory[48] = 32'b000000000100_01000_100_01001_0010011;     // xori x9, x8, 4
Imemory[52] = 32'b000000000101_00010_111_00001_0010011;     // andi x1, x2, 5
Imemory[56] = 32'b000000000110_00011_001_00100_0010011;    // slli x4, x3, 6
Imemory[60] = 32'b000000000111_00011_101_00100_0010011;    // srli x4, x3, 7 
Imemory[64] = 32'b010000001000_00011_101_00101_0010011;    //srai x5, x3, 8
Imemory[68] = 32'b000000001001_00011_010_00101_0010011;    //slti x5, x3, 9  
//lw-type
Imemory[72]=  32'b000000000101_00011_000_01001_0000011;     // lb x9, 5(x3)
Imemory[76] = 32'b000000000011_00011_001_01001_0000011;    // lh x9, 3(x3)
Imemory[80]= 32'b000000001111_00010_010_01000_0000011;    // lw x8, 15(x2) 
//s type

Imemory[84] = 32'b0000000_01111_00011_000_01000_0100011;//sb x15 8(x3) x3=12
Imemory[88] = 32'b0000000_01110_00110_001_01010_0100011;//sh x14 10(x6) x6=44
Imemory[92] = 32'b0000000_01110_00110_010_01100_0100011;     // sw x14, 12(x6), x6 = 44     
//sb type
//Imemory[44] = 32'h00948663; //beq x9 x9 12

Imemory[96] = 32'b0_000000_01001_01001_000_0110_0_1100011;     // beq x9, x9, 12, (PC + 12 if x9 = x9 
Imemory[100] = 32'b0_000000_01001_01001_001_0111_0_1100011;    //bne x9, x9, 14,(PC + 14 if x9 != x9)

// U-type
Imemory[104] =  32'b00000000000000101000_00011_0110111;     // lui x3, 40
Imemory[108] =  32'b00000000000000101000_00101_0010111;     // auipc x5, 20 (rd = PC + (imm << 12))
// J-type
Imemory[112] = 32'b0_00000000_0_0000010100_00001_1101111;         // jal x1, 20




end



endmodule
