
module RISCV_TOP(clk,reset, Write_backOut);
input clk,reset;
output Write_backOut;

wire [31:0] PCtop, NexttoPCtop, instruction_outTop, read_data1Top, read_data2Top, toALU, 
            ALU_resultTop, Read_DataTop, Write_backTop, ImmExt_Top, sum_Top, Mux2_outTop;
wire [3:0]ALUControlTop;
wire RegWriteTop,MemWriteTop,MemReadTop,ALUSrcTop, MemtoRegTop, zero_Top, branch_Top, and_outTop ;
wire [1:0]ALUOpTop;


PCplus4 pc4(
.fromPC(PCtop), 
.NexttoPC(NexttoPCtop)
);

Program_Counter Program_Counter(
.clk(clk),
.reset(reset),
.PC_in(Mux2_outTop),
.PC_out(PCtop)
);


Instruction_Mem Instruction_Mem(
.clk(clk),
.reset(reset), 
.read_address(PCtop), 
.instruction_out(instruction_outTop)
);

Register_File Register_File(
.clk(clk),
.reset(reset), 
.Rs1(instruction_outTop[19:15]),
.Rs2(instruction_outTop[24:20]),
.Rd(instruction_outTop[11:7]), 
.Write_data(Write_backTop),
.RegWrite(RegWriteTop),
.Read_data1(read_data1Top),
.Read_data2(read_data2Top)// check
);

Immediate_Generator imm_gen(
.Opcode(instruction_outTop[6:0]), 
.instruction(instruction_outTop), 
.ImmExt(ImmExt_Top)
);


Control_Unit Control_Unit(
.reset(reset),
.OPcode(instruction_outTop[6:0]), 
.branch(branch_Top), 
.MemRead(MemReadTop),
.MemtoReg(MemtoRegTop), 
.MemWrite(MemWriteTop), 
.ALUSrc(ALUSrcTop), 
.RegWrite(RegWriteTop), 
.ALUOp_out(ALUOpTop)
);


ALUControl ALUControl(
.ALUOp_in(ALUOpTop),
.func7(instruction_outTop[31:25]),//instruction[31:25] also can use
.func3(instruction_outTop[14:12]), 
.ALUControl_out(ALUControlTop)
);



ALU ALU(
.A(read_data1Top),
.B(toALU), //check
.zero(zero_Top),
.ALUControl_in(ALUControlTop),
.ALU_result(ALU_resultTop)
);

Mux1 mux1(
.Sel(ALUSrcTop),
 .A1(read_data2Top), 
 .B1(ImmExt_Top), 
 .Mux1_out(toALU)
 );
 
Adder adder(
.in_1(PCtop), 
.in_2(ImmExt_Top), 
.sum(sum_Top)
);


And_Logic andgate(
.branch(branch_Top), 
.zero(zero_Top), 
.and_out(and_outTop)
);

Mux2 mux2(
.Sel(and_outTop), 
.A2(NexttoPCtop), 
.B2(sum_Top), 
.Mux2_out(Mux2_outTop)
);


Data_Memory Data_Memory(
.clk(clk),
.reset(reset), 
.MemWrite(MemWriteTop), 
.MemRead(MemReadTop), 
.Address(ALU_resultTop), 
.write_data(read_data2Top),
.Read_Data(Read_DataTop)    //Data_out or MemDataOut in vid
);


Mux3 mux3(
.Sel3(MemtoRegTop), 
.A3(ALU_resultTop), 
.B3(Read_DataTop), 
.Mux3_out(Write_backTop)
);

assign Write_backOut = Write_backTop;


endmodule
