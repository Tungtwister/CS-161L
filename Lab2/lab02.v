`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
module lab02(
input wire clk,
input wire rst ,
input wire[31:0] targetnumber,
input wire[4:0] fixpointpos ,
input wire opcode ,
output reg[31:0] result );

//Combinational block
reg [31:0] c_targetnumber;
reg [4:0] c_fixpointpos;
reg [31:0] floatresult ;
reg [31:0] fixresult ;

integer i;
integer count;
reg sign = 0;
reg [7:0] exp;
integer exp2; //integer form for exponent in order to handle denormalized floating points
reg [22:0] mantissa;
reg [31:0] temp;


always @ (*) begin

c_targetnumber = targetnumber;
c_fixpointpos = fixpointpos;
floatresult = 32'h0;
fixresult = 32'h0;

case(opcode)
// -------------------------------------------
// From fix to float
// -------------------------------------------
// Your Implementation
1'b00 : begin

if(c_targetnumber[31] == 1) //if negative change number to positive using twos compliment
begin
	sign = 1'b1;
	c_targetnumber = -c_targetnumber;
end

for(i = 0; i < 31; i = i + 1) //loop finds first 1 bit in c_targetnumber
begin
	if(c_targetnumber[i] == 1)
	begin
		count = i;
	end
end
	//$display("%d",count);

exp = (count - c_fixpointpos) + 127; //determines biased exponent
	//$display("%d",exp);

c_targetnumber = c_targetnumber << (31 - count); //shifts mantissa to front 
mantissa = c_targetnumber[31:8]; 					//so mantissa can be grabbed

floatresult = { {sign}, {exp}, {mantissa} }; //input results into floatresult

end
// -------------------------------------------
// From float to fix
// -------------------------------------------
// Your Implementation
1'b01 : begin

sign = c_targetnumber[31];	//divides floating point into separate parts
exp2 = c_targetnumber[30:23] - 127;
mantissa = c_targetnumber[22:0];
//$display("%d",exp2);
//$display("%b",mantissa);

count = 23 - (exp2 + c_fixpointpos); //determines position of exponent
temp = {1'b1,mantissa};
if(count > 0)
begin
	temp = temp >> count; //shifts temp into correct position if too many bits
end
else if(count <= 0)
begin
	temp = temp << -count; //shifts temp into correct position it too little bits
end
//$display("%h",temp);

if(sign == 1'b1) // handles negatives, inverts using 2s complement
begin
	temp = -temp;
end

fixresult = temp;


end

// -------------------------------------------
// Register the results
// -------------------------------------------
endcase
end

always @ ( posedge clk ) begin
if( rst == 1'b1 )
begin
			result <= 32'h0;
end

result <= opcode == 1 ? fixresult : floatresult ;
end

endmodule
