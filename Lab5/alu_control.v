`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:28:37 04/27/2018 
// Design Name: 
// Module Name:    alu_control 
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
module alu_control(
	 //input wire clk,
	 //input wire reset,
	 
    input wire [1:0] alu_op,
    input wire [5:0] instruction_5_0,
    output reg [3:0] alu_out
    );	

reg c_alu_out;

always @(*)begin
case (alu_op)
//LW and SW and addi
2'b00 : alu_out = 4'b0010;
//Branch equal
2'b01 : alu_out = 4'b0110;
2'b11 : alu_out = 4'b0110;
//R-type
2'b10 : 
	
	case(instruction_5_0)
	//add
	6'b100000 : alu_out = 4'b0010;
	//addu
	6'b100001 : alu_out = 4'b0010;
	//sub
	6'b100010 : alu_out = 4'b0110;
	//AND
	6'b100100 : alu_out = 4'b0000;
	//OR
	6'b100101 : alu_out = 4'b0001;
	//NOR
	6'b100111 : alu_out = 4'b1100;
	//set on less than slt
	6'b101010 : alu_out = 4'b0111;
	
	
	endcase


endcase

end

endmodule
