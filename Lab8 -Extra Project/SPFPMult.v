`timescale 1ns / 1ps

module SPFPMult (
		input clk,
		input rst,
		input enable,
		output reg valid,
		input[31:0]  A,
		input[31:0]  B,
		output reg[31:0] result
	);
reg [31:0] C;
reg [31:0] yourresult;
reg [22:0] mantisA, mantisB;
reg [23:0] exManA, exManB;	
reg [47:0] mantMult;
reg [7:0] shift;
integer i;
reg [22:0] mantisC;

reg [7:0] expA, expB;
reg [7:0] expC;
reg [7:0] expT;

reg signA, signB;
reg signC;

// Sequential Part 
always @ (*) begin
yourresult = 32'h0;
if(enable == 1)begin //check if enable is 1

//Mantissa Calculations
mantisA = A[22:0];
mantisB = B[22:0];
exManA = {{1'b1},{mantisA}};
exManB = {{1'b1},{mantisB}};

mantMult = exManA * exManB;
//$display("%b",mantMult);
shift = 0;
for(i =0; i<48; i=i+1)
	begin
			if(mantMult[47] == 0)
			begin
			mantMult = mantMult << 1;
			shift = shift + 1;
			end
	end
mantisC = mantMult[46:24];

//Exponent Calculations
expA = A[30:23];
expB = B[30:23];
expC = (expA - 127) + (expB - 127) + 127;
expT =(expA - 127) + (expB - 127);
if(shift == 0)
begin
	expC = expC + 1;
end

//Sign Calculations
signA = A[31];
signB = B[31];
signC = signA ^ signB;

C = {{signC},{expC},{mantisC}};
yourresult = C;
end
end

always @(posedge clk) begin

	if (rst) begin
		result <= 0;
		valid  <= 0;
	end
	else begin
		result <= yourresult ; 
		valid <= enable;
	end
end
	
endmodule

