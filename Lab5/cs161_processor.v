`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:14:42 05/04/2018 
// Design Name: 
// Module Name:    cs161_processor 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module cs161_processor(
//inputs
	 input clk,
	 input rst,
//outputs
	output reg [31:0] prog_count,  
	output reg [5:0] instr_opcode ,
	output reg [4:0] reg1_addr ,   
	output reg [31:0] reg1_data ,  
	output reg [4:0] reg2_addr , 
	output reg [31:0] reg2_data ,
	output reg [4:0] write_reg_addr ,
	output reg [31:0] write_reg_data 
    );

wire [31:0] pc_input, pc_output, pc_plus4, instr, 
read_data1, read_data2, mem_data, reg_write_data, immed, shiftleft2, pc_offset,
ALUsrc_mux, alu_result;

wire [4:0] write_reg;

wire [1:0] alu_op;

wire [3:0] alu_out;

wire mem_write, reg_dst, branch, mem_read, mem_to_reg, alu_src, reg_write, zero, branch_zero;

assign pc_plus4 = pc_output + 32'd4;

//IFID OUTPUTS
wire [31:0] instr_IFID, pc_plus4_IFID;

//IDEX OUTPUTS
wire mem_to_reg_IDEX, reg_write_IDEX, branch_IDEX, mem_write_IDEX, mem_read_IDEX, alu_src_IDEX, reg_dst_IDEX;
wire [1:0] alu_op_IDEX;
wire [4:0] instr2016_IDEX, instr1511_IDEX;
wire [31:0] pc_plus4_IDEX, read_data1_IDEX, read_data2_IDEX, immed_IDEX;

//EXMEM OUTPUTS
wire mem_to_reg_EXMEM, reg_write_EXMEM, branch_EXMEM, mem_write_EXMEM, mem_read_EXMEM, zero_EXMEM;
wire [4:0] write_reg_EXMEM;
wire [31:0] read_data2_EXMEM, alu_result_EXMEM, pc_offset_EXMEM;

//MEMWB OUTPUTS
wire mem_to_reg_MEMWB, reg_write_MEMWB;
wire [31:0] mem_data_MEMWB, alu_result_MEMWB;
wire [4:0] write_reg_MEMWB;

assign shiftleft2 = immed_IDEX << 2;
assign branch_zero = zero_EXMEM & branch_EXMEM;
//assign branch_zero = zero;

gen_register PC(
    .clk        (clk),
    .rst      (rst),
	 .write_en (1'b1),
	 .data_in (pc_input),
	 .data_out (pc_output)
);

cpumemory Instr_Mem_and_Data_Mem(
	.clk	(clk),
   .rst  (rst),
   .instr_read_address (pc_output[2+:8]),
   .instr_instruction  (instr),
	
   .data_mem_write  (mem_write_EXMEM),   
   .data_address   (alu_result_EXMEM[0+:8]),    
   .data_write_data (read_data2_EXMEM),    
   .data_read_data (mem_data) 
);

control_unit control_unit(
	.instr_op (instr_IFID[31:26]),
	.reg_dst (reg_dst),
	.branch	(branch),
	.mem_read (mem_read),
	.mem_to_reg (mem_to_reg),
	.alu_op (alu_op),
	.mem_write (mem_write),
	.alu_src (alu_src),
	.reg_write (reg_write)
);

mux_5bit mux_regDst(
	.select_in (reg_dst_IDEX),
	.datain1 (instr2016_IDEX),
	.datain2 (instr1511_IDEX),
	.data_out (write_reg)
);

cpu_registers Register(
	.clk (clk),
	.rst	(rst),
	.reg_write (reg_write_MEMWB),
	.read_register_1 (instr_IFID[25:21]),
	.read_register_2 (instr_IFID[20:16]),
	.write_register (write_reg_MEMWB),
	.write_data (reg_write_data),
	.read_data_1 (read_data1),
	.read_data_2 (read_data2)
);

sign_extend sign_extend(
	.data_in (instr_IFID[15:0]),
	.data_out (immed)
);

Adder PC_Add(
    .data1_in   (pc_plus4_IDEX),
    .data2_in   (shiftleft2),
    .data_out   (pc_offset)
);

mux_2_1 MUX_ALUsrc(
	.select_in (alu_src_IDEX),
	.datain1 (read_data2_IDEX),
	.datain2 (immed_IDEX),
	.data_out (ALUsrc_mux)
);

alu_control alu_control(
		.alu_op (alu_op_IDEX),
		.instruction_5_0 (immed_IDEX[5:0]),
		.alu_out(alu_out)
);

alu alu(
	.alu_control_in (alu_out),
	.channel_a_in (read_data1_IDEX),
	.channel_b_in (ALUsrc_mux),
	.zero_out (zero),
	.alu_result_out (alu_result)
);

mux_2_1 MUX_branch(
	.select_in (branch_zero),
	.datain1 (pc_plus4),
	.datain2 (pc_offset_EXMEM),
	.data_out (pc_input)
);

mux_2_1 MUX_to_reg(
	.select_in (mem_to_reg_MEMWB),
	.datain1 (alu_result_MEMWB),
	.datain2 (mem_data_MEMWB),
	.data_out (reg_write_data)
);

IFID_Register IFID_Reg(
	.clk (clk),
	.instrIn (instr),
	.pcplus4 (pc_plus4),
	.instrOut (instr_IFID),
	.pcplus_4 (pc_plus4_IFID)
);

Register branchIDEX(
    .clk        (clk),
    .rst      (rst),
	 .write_en (1'b1),
	 .data_in (branch),
	 .data_out (branch_IDEX)
);

IDEX_Register IDEX_Reg(
	.clk (clk),
	.rst (rst),
	.mem_to_reg_IDEX (mem_to_reg),
	.reg_write_IDEX (reg_write),
	//.branch_IDEX (branch),
	.mem_write_IDEX (mem_write),
	.mem_read_IDEX (mem_read),
	
	.alu_src_IDEX (alu_src),
	.alu_op_IDEX (alu_op),
	.reg_dst_IDEX (reg_dst),
	
	.pcplus4 (pc_plus4_IFID),
	.reg1 (read_data1),
	.reg2 (read_data2),
	.signextended (immed),
	.instr20_16 (instr_IFID[20:16]),
	.instr15_11 (instr_IFID[15:11]),
	//outputs
	.mem_to_reg_IDEX_O (mem_to_reg_IDEX),
	.reg_write_IDEX_O (reg_write_IDEX),
	//.branch_IDEX_O (branch_IDEX),
	.mem_write_IDEX_O (mem_write_IDEX),
	.mem_read_IDEX_O (mem_read_IDEX),
	
	.alu_src_IDEX_O (alu_src_IDEX),
	.alu_op_IDEX_O (alu_op_IDEX),
	.reg_dst_IDEX_O (reg_dst_IDEX),
	
	.pcplus4_O (pc_plus4_IDEX),
	.reg1_O (read_data1_IDEX),
	.reg2_O (read_data2_IDEX),
	.signextended_O (immed_IDEX),
	.instr20_16_O (instr2016_IDEX),
	.instr15_11_O (instr1511_IDEX)
);
Register branchEXMEM(
    .clk        (clk),
    .rst      (rst),
	 .write_en (1'b1),
	 .data_in (branch_IDEX),
	 .data_out (branch_EXMEM)
);

EXMEM_Register EXMEM_Reg(
	.clk (clk),
	.mem2reg (mem_to_reg_IDEX),
	.regwrite (reg_write_IDEX),
	//.branch (branch_IDEX),
	.memwrite (mem_write_IDEX),
	.memread(mem_read_IDEX),
	
	.zero(zero),
	.regdst(write_reg),
	.readdata2(read_data2_IDEX),
	.aluresult(alu_result),
	.add_pc_offset (pc_offset),
	
	.mem2reg_O (mem_to_reg_EXMEM),
	.regwrite_O (reg_write_EXMEM),
	//.branch_O (branch_EXMEM),
	.memwrite_O (mem_write_EXMEM),
	.memread_O (mem_read_EXMEM),
	.zero_O (zero_EXMEM),
	.regdst_O (write_reg_EXMEM),
	.readdata2_O (read_data2_EXMEM),
	.aluresult_O (alu_result_EXMEM),
	.add_pc_offset_O (pc_offset_EXMEM)
);	

MEMWB_Register MEMWB_Reg (
	.clk (clk),
	.mem2reg (mem_to_reg_EXMEM),
	.regwrite (reg_write_EXMEM),
	.mem_read_data (mem_data),
	.aluresult (alu_result_EXMEM),
	.regdst (write_reg_EXMEM),
	
	.mem2reg_O (mem_to_reg_MEMWB),
	.regwrite_O (reg_write_MEMWB),
	.mem_read_data_O (mem_data_MEMWB),
	.aluresult_O (alu_result_MEMWB),
	.regdst_O (write_reg_MEMWB)
	
);

always @(*)begin
prog_count <= pc_output;
instr_opcode <= instr[31:26];
reg1_addr <= instr[25:21];
reg1_data <= read_data1;
reg2_addr <= instr[20:16];
reg2_data <= read_data2;
write_reg_addr <= write_reg;
write_reg_data <= reg_write_data;
end
endmodule