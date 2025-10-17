

module Data_Memory(clk,reset, MemWrite, MemRead, Address, write_data,Read_Data);

input clk,reset;
input MemWrite,MemRead;
input[31:0]Address,write_data;
output [31:0] Read_Data;

reg [31:0] Dmemory[63:0];

assign Read_Data = (MemRead)?Dmemory[Address]:32'b00;
integer k;
always @(posedge clk) begin
	Dmemory[17] = 56;
	Dmemory[15] = 65;
end 
always@(posedge clk or posedge reset)
begin
if(reset)
begin
for(k=0; k<64; k=k+1)
begin
Dmemory[k] =32'h0;
end
end
else if(MemWrite) Dmemory[Address] = write_data;//check
end


endmodule
