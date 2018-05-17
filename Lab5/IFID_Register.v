`timescale 1ns / 1ps

module IFID_Register(

	input clk,
	input [31:0] instrIn,
	input [31:0] pcplus4,
	output reg [31:0] instrOut,
	output reg [31:0] pcplus_4
    );

always @(posedge clk)
begin
 instrOut <= instrIn;
 pcplus_4 <= pcplus4;
end

endmodule
