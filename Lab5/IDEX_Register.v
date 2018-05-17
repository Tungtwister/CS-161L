`timescale 1ns / 1ps

module IDEX_Register(
	 
	input clk,
	input rst,
	
	//Write Back
	input mem_to_reg_IDEX,
	input reg_write_IDEX,
	
	//Memory
	//input branch_IDEX,
	input mem_write_IDEX,
	input mem_read_IDEX,
	
	//Execute
	input alu_src_IDEX,
	input [1:0] alu_op_IDEX,
	input reg_dst_IDEX,
	
	input [31:0] pcplus4,
	
	input [31:0] reg1, reg2,
	
	input[31:0] signextended,
	
	input[4:0] instr20_16, instr15_11,
	
	//output reg branch_IDEX_O,
	output reg mem_read_IDEX_O,
	output reg mem_to_reg_IDEX_O,
	output reg  mem_write_IDEX_O,
	output reg reg_write_IDEX_O,
	
	//Execute
	output reg alu_src_IDEX_O,
	output reg [1:0] alu_op_IDEX_O,
	output reg reg_dst_IDEX_O,
	
	output reg [31:0] pcplus4_O,
	
	output reg [31:0] reg1_O, reg2_O,
	
	output reg[31:0] signextended_O,
	
	output reg [4:0] instr20_16_O, instr15_11_O
	
);

always @(posedge clk)
begin
	if (rst)
	begin
	//branch_IDEX_O <= branch_IDEX;
	mem_read_IDEX_O <= 1'b0;
	mem_to_reg_IDEX_O <= 1'b0;
	mem_write_IDEX_O <= 1'b0;
	reg_write_IDEX_O <= 1'b0;
	
	//Execute
	alu_src_IDEX_O <= 1'b0;
	alu_op_IDEX_O <= 2'b0;
	reg_dst_IDEX_O <= 1'b0;
	
	pcplus4_O <= 32'b0;
	
	reg1_O <= 32'b0;
	reg2_O <= 32'b0;
	
	signextended_O <= 32'b0;
	
	instr20_16_O <= 5'b0;
	instr15_11_O <= 5'b0;
	end
	else if (clk)
	begin
	//branch_IDEX_O <= branch_IDEX;
	mem_read_IDEX_O <= mem_read_IDEX;
	mem_to_reg_IDEX_O <= mem_to_reg_IDEX;
	mem_write_IDEX_O <= mem_write_IDEX;
	reg_write_IDEX_O <= reg_write_IDEX;
	
	//Execute
	alu_src_IDEX_O <= alu_src_IDEX;
	alu_op_IDEX_O <= alu_op_IDEX;
	reg_dst_IDEX_O <= reg_dst_IDEX;
	
	pcplus4_O <= pcplus4;
	
	reg1_O <= reg1;
	reg2_O <= reg2;
	
	signextended_O <= signextended;
	
	instr20_16_O <= instr20_16;
	instr15_11_O <= instr15_11;
	end
end



endmodule
