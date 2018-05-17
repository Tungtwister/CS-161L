`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:51:59 04/23/2018 
// Design Name: 
// Module Name:    control_unit 
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

module control_unit(
	//input wire clk,
	//input wire reset,
	
	input wire [5:0] instr_op ,
	output reg reg_dst ,
	output reg branch ,
	output reg mem_read ,
	output reg mem_to_reg ,
	output reg [1:0] alu_op ,
	output reg mem_write ,
	output reg alu_src ,
	output reg reg_write
    );



reg c_reg_dst; 
reg c_branch; 
reg c_mem_read; 
reg c_mem_to_reg; 
reg [1:0] c_alu_op; 
reg c_mem_write; 
reg c_alu_src;
reg c_reg_write;
	 
//combinational block
always @(*) begin
//necessary functions  
//add, addu, addi
//sub, subi
//slt
//not, nor
//or
//and
//lw, sw
//Beq

//r format add, addu, sub, slt, nor, or, and

case(instr_op) 

//R-format
6'b000000 :
begin
reg_dst = 1'b1;
alu_src = 1'b0;
mem_to_reg = 1'b0;
reg_write = 1'b1;
mem_read = 1'b0;
mem_write = 1'b0;
branch = 1'b0;
alu_op = 2'b10;
end

//lw
6'b100011 :
begin
reg_dst = 1'b0;
alu_src = 1'b1;
mem_to_reg = 1'b1;
reg_write = 1'b1;
mem_read = 1'b1;
mem_write = 1'b0;
branch = 1'b0;
alu_op = 2'b00;
end

//sw
6'b101011 :
begin
//c_reg_dst = 1'b0;
alu_src = 1'b1;
//c_mem_to_reg = 1'b0;
reg_write = 1'b0;
mem_read = 1'b0;
mem_write = 1'b1;
branch = 1'b0;
alu_op = 2'b00;
end

//beq	
6'b000100 :
begin
//c_reg_dst = 1'b0;
alu_src = 1'b0;
//c_mem_to_reg = 1'b0;
reg_write = 1'b0;
mem_read = 1'b0;
mem_write = 1'b0;
branch = 1'b1;
alu_op = 2'b01;
end

//addi
6'b001000 :
begin
reg_dst = 1'b0;
alu_src = 1'b1;
mem_to_reg = 1'b0;
reg_write = 1'b1;
mem_read = 1'b0;
mem_write = 1'b0;
branch = 1'b0;
alu_op = 2'b00;
end

endcase

end

endmodule