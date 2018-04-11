`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:02:15 04/02/2018 
// Design Name: 
// Module Name:    my_alu 
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
module my_alu #(parameter NUMBITS = 32) (
    input wire clk,
    input wire reset,
    input wire [NUMBITS-1:0]A,
    input wire [NUMBITS-1:0]B,
    input wire [2:0] opcode,
    output reg [NUMBITS- 1:0] result,
    output reg  carryout,
    output reg  overflow,
    output reg zero
    );
	 
//comb block
reg [NUMBITS-1:0] c_result ; 
reg c_overflow;
reg c_carryout;

always @(*)begin

c_result = 'd0;

case (opcode)

3'd0 : begin //unsigned add
c_result = A + B; 

{c_carryout,c_result} = {1'b0, A} + {1'b0,B} ;
c_overflow = 'd0;
end

3'd1 : begin //signed add
c_result = $signed(A) + $signed(B);
c_carryout = 'd0;
			if (($signed(A) >= 0) && ($signed(B) >= 0) && ($signed(c_result) < 0)) begin 
			c_overflow = 1'b1 ;
			end else if (($signed(A) < 0) && ($signed(B) < 0) && ($signed(c_result) >= 0))begin 
			c_overflow = 1'b1 ;
			end else begin 
			c_overflow = 1'b0 ;
			end
end

3'd2 : begin //unsigned sub
c_result = A - B; 
{c_carryout,c_result} = {1'b0, A} - {1'b0,B} ;
c_overflow = 'd0;
end

3'd3 : begin //signed sub
c_result = $signed(A) - $signed(B);
c_carryout = 'd0;
			if (($signed(A) >= 0) && ($signed(A) < 0) && ($signed(A) < 0)) begin
			c_overflow = 1'b1 ;
			end else if (($signed(A) < 0) && ($signed(B) >= 0) && ($signed(c_result) >= 0)) begin 
			c_overflow = 1'b1 ;
			end else begin
			c_overflow <= 1'b0 ;
			end
end

3'd4 : begin //AND
c_result = A & B; 
c_overflow = 'd0;
c_carryout = 'd0;
end

3'd5 : begin //OR
c_result = A | B; 
c_overflow = 'd0;
c_carryout = 'd0;
end

3'd6 : begin //XOR
c_result = A ^ B; 
c_overflow = 'd0;
c_carryout = 'd0;
end

3'd7 : begin //Divide by 2
c_result = A >> 1; 
c_overflow = 'd0;
c_carryout = 'd0;
end

endcase

end

//seq block
always @( posedge clk )begin
 if( reset == 1'b1 )begin
			result <= 'd0 ;
			zero <= 'd0;
			overflow <= 'd0;
			carryout <= 'd0;
 end else begin
			result <= c_result ;
			overflow <= c_overflow;
			carryout <= c_carryout;
			
		  if (c_result == {NUMBITS{1'b0}} ) zero <= 1'b1; // Zero detection
		  else zero <= 1'b0;
		  
			zero <= ( c_result == {NUMBITS{1'b0}}) ? 1'b1 : 1'b0 ;

 end
end

endmodule





