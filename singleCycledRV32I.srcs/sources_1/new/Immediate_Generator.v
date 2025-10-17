
module Immediate_Generator(Opcode, instruction, ImmExt);

input [6:0] Opcode;
input [31:0] instruction;
output reg [31:0] ImmExt;


always @(*)
begin
case(Opcode)
7'b0010011 :
 begin 
ImmExt = {{20{instruction[31]}},instruction[31:20]};  //i type
 end

7'b0000011: 
begin 
ImmExt = {{20{instruction[31]}},instruction[31:20]};   // Load-type
end 

7'b0100011 : 
begin
 ImmExt = {{20{instruction[31]}},instruction[31:25],instruction[11:7]};   // s type
end	

7'b1100011 : 
begin
ImmExt = {{19{instruction[31]}},instruction[7],instruction[30:25], instruction[11:8], 1'b0}; // b type
end

7'b0110111: 
begin
ImmExt = {instruction[31:12], 12'b0}; // U-type
end

7'b0010111:
 begin 
ImmExt = {instruction[31:12], 12'b0}; // U-type
end

7'b1101111: 
begin
ImmExt = {{11{instruction[31]}}, instruction[19:12], instruction[20], instruction[30:21], 1'b0}; // J-type
end
default: 
begin
ImmExt = 32'b0; // Default case
end

endcase
end




endmodule
