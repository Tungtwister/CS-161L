`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:41:53 05/14/2018 
// Design Name: 
// Module Name:    EXMEM_Register 
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
module EXMEM_Register(
	input clk,
	input mem2reg,
	input regwrite,
	//input branch,
	input memwrite,
	input memread,
	
	input zero,
	input [4:0] regdst,
	input [31:0] readdata2,
	input [31:0] aluresult,
	input [31:0] add_pc_offset,
	
	output reg mem2reg_O,
	output reg regwrite_O,
	//output reg branch_O,
	output reg memwrite_O,
	output reg memread_O,
	
	output reg zero_O,
	output reg [4:0] regdst_O,
	output reg [31:0] readdata2_O,
	output reg [31:0] aluresult_O,
	output reg [31:0] add_pc_offset_O
);

always @(posedge clk)
begin	 
	mem2reg_O <= mem2reg;
	regwrite_O <= regwrite;
	//branch_O <= branch;
	memwrite_O <= memwrite;
	memread_O <= memread;
	
	zero_O <= zero;
	regdst_O <= regdst;
	readdata2_O <= readdata2;
	aluresult_O <= aluresult;
	add_pc_offset_O <= add_pc_offset;
end
endmodule
