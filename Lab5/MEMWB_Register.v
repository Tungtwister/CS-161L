`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:21:26 05/14/2018 
// Design Name: 
// Module Name:    MEMWB_Register 
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
module MEMWB_Register(
	input clk,
	input mem2reg,
	input regwrite,
	input [31:0] mem_read_data,
	input [31:0] aluresult,
	input [4:0] regdst,
	
	output reg mem2reg_O,
	output reg regwrite_O,
	output reg [31:0] mem_read_data_O,
	output reg [31:0] aluresult_O,
	output reg [4:0] regdst_O

);

always @ (posedge clk)
begin
	mem2reg_O <= mem2reg;
	regwrite_O <= regwrite;
	mem_read_data_O <= mem_read_data;
	aluresult_O <= aluresult;
	regdst_O <= regdst;
end

endmodule
