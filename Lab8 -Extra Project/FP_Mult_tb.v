`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Dummy testbench 

// Make sure your add your own test cases *****************************
// Make sure your add your own test cases *****************************
// Make sure your add your own test cases *****************************
// Make sure your add your own test cases *****************************
// Make sure your add your own test cases *****************************

////////////////////////////////////////////////////////////////////////////////

module FP_Mult_tb;


	// Inputs
	reg [31:0] N1;
	reg [31:0] N2;
	reg clk;
	reg rst;
	reg enable;

	// Outputs
	wire [31:0] result;
	wire valid;
	
	// Instantiate the Unit Under Test (UUT)
	SPFPMult uut (
		.clk (clk),
		.rst (rst),
		.enable (enable),
		.valid (valid),
		.A(N1), 
		.B(N2), 
		.result(result)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 0;
		
		// Wait 100 ns for global reset to finish
		#100;

		rst = 1;
		clk = 0;
		#5
		
		clk = 1;
		rst = 1;
		#5
		
		clk = 0;
		rst = 0;
		
		enable = 1;
		
		forever begin
			#5 clk = ~clk;
		end
	end
	
	
	initial begin
		// Initialize Inputs
		N1 = 0;
		N2 = 0;
		enable = 0;

		// Wait 100 ns for global reset to finish
		#100;
		
		//Wait for reset to finish
		#10
		


//10.5 * 11.24 = 118.02
N1 = 32'h41280000;
N2 = 32'h4133d70a;
#10 
$display("T1");
$display("result: %x", result);
$display("expect: 42ec0a3d\n");

//10.5 * -11.24 = -118.02
N1 = 32'h41280000;
N2 = 32'hc133d70a;
#10
$display("T2");
$display("result: %x", result);
$display("expect: c2ec0a3d\n");

//-10.5 * 11.24 = -118.02
N1 = 32'hc1280000;
N2 = 32'h4133d70a;
#10
$display("T3");
$display("result: %x", result);
$display("expect: c2ec0a3d\n");

//-10.5 * -11.24 = 118.02
N1 = 32'hc1280000;
N2 = 32'hc133d70a;
#10
$display("T4");
$display("result: %x", result);
$display("expect: 42ec0a3d\n");

//10 * -10 = -100
N1 = 32'h41200000;
N2 = 32'hc1200000;
 #10;
$display("T5");
$display("result: %x", result);
$display("expect: c2c80000\n");

//-10 * 10 = -100
N1 = 32'hc1200000;
N2 = 32'h41200000;
 #10
$display("T6");
$display("result: %x", result);
$display("expect: c2c80000\n");

//1e+06 * -5 = -5e+06
N1 = 32'h49742400;
N2 = 32'hc0a00000;
 #10
$display("T7");
$display("result: %x", result);
$display("expect: ca989680\n");

//1e+06 * 5 = 5e+06
N1 = 32'h49742400;
N2 = 32'h40a00000;
 #10
$display("T8");
$display("result: %x", result);
$display("expect: 4a989680\n");

//5 * 1e+06 = 5e+06
N1 = 32'h40a00000;
N2 = 32'h49742400;
 #10
$display("T9");
$display("result: %x", result);
$display("expect: 4a989680\n");

//-5 * 1e+06 = -5e+06
N1 = 32'hc0a00000;
N2 = 32'h49742400;
 #10
$display("T10");
$display("result: %x", result);
$display("expect: ca989680\n");

//1.67772e+07 * 1 = 1.67772e+07
N1 = 32'h4b800000;
N2 = 32'h3f800000;
 #10
$display("T11");
$display("result: %x", result);
$display("expect: 4b800000\n");

//1.67772e+07 * -1 = -1.67772e+07
N1 = 32'h4b800000;
N2 = 32'hbf800000;
 #10
$display("T12");
$display("result: %x", result);
$display("expect: cb800000\n");

//200 * 50 = 10000
N1 = 32'h43480000;
N2 = 32'h42480000;
#10 
$display("T13");
$display("result: %x", result);
$display("expect: 461c4000\n");

//19.7554 * 700.623 = 13841.1
N1 = 32'h419e0b0f;
N2 = 32'h442f27df;
 #10
$display("T14");
$display("result: %x", result);
$display("expect: 46584459\n");

//19.7554 * -700.623 = -13841.1
N1 = 32'h419e0b0f;
N2 = 32'hc42f27df;
 #10
$display("T15");
$display("result: %x", result);
$display("expect: c6584459\n");

//-19.7554 * 700.623 = -13841.1
N1 = 32'hc19e0b0f;
N2 = 32'h442f27df;
 #10
$display("T16");
$display("result: %x", result);
$display("expect: c6584459\n");

//-19.7554 * -700.623 = 13841.1
N1 = 32'hc19e0b0f;
N2 = 32'hc42f27df;
 #10;
$display("T17");
$display("result: %x", result);
$display("expect: 46584459\n");

//7.88861e-31 * 3.9443e-31 = 0
N1 = 32'h0d800000;
N2 = 32'h0d000000;
 #10
$display("T18");
$display("result: %x", result);
$display("expect: 00000000\n");


//test the enable/valid 
enable = 0;
//-19.7554 * -700.623 = 13841.1
N1 = 32'hc19e0b0f;
N2 = 32'hc42f27df;
 #10 ;
$display("T19");
$display("result: %x", result);
$display("expect: 00000000");
$display("valid (%d) should be 0\n", valid);

// Add your own test cases 

enable = 0; #10
enable = 1; #10 ; 
//5 * 2 = 10
N1 = 32'h40a00000;
N2 = 32'h40000000;
 #10
$display("T20");
$display("result: %x", result);
$display("expect: 41200000\n");

//-5 * 2 = -10
N1 = 32'hc0a00000;
N2 = 32'h40000000;
 #10
$display("T21");
$display("result: %x", result);
$display("expect: c1200000\n");

//5 * -2 = -10
N1 = 32'h40a00000;
N2 = 32'hc0000000;
 #10
$display("T22");
$display("result: %x", result);
$display("expect: c1200000\n");

//-5 * -2 = 10
N1 = 32'hc0a00000;
N2 = 32'hc0000000;
 #10
$display("T23");
$display("result: %x", result);
$display("expect: 41200000\n");

//2018 * 1997 = 4,029,946
N1 = 32'h44fc4000;
N2 = 32'h44f9a000;
 #10
$display("T24");
$display("result: %x", result);
$display("expect: 4a75f7e8\n");

//1234 * 4321 = 5,332,114
N1 = 32'h449a4000;
N2 = 32'h45870800;
 #10
$display("T25");
$display("result: %x", result);
$display("expect: 4aa2b924\n");

//1,000,000 * 1 = 1,000,000
N1 = 32'h49742400;
N2 = 32'h3f800000;
 #10
$display("T26");
$display("result: %x", result);
$display("expect: 49742400\n");

//1,000,000 * -1 = -1,000,000
N1 = 32'h49742400;
N2 = 32'hbf800000;
 #10
$display("T27");
$display("result: %x", result);
$display("expect: c9742400\n");

//0.001 * 0.00001 = 1e-8
N1 = 32'h3a83126f;
N2 = 32'h3727c5ac;
 #10
$display("T28");
$display("result: %x", result);
$display("expect: 322bcc77\n");

//1000 * 0.001 = 1
N1 = 32'h447a0000;
N2 = 32'h3a83126f;
 #10
$display("T29");
$display("result: %x", result);
$display("expect: 3f800000\n");

//-1000 * 0.001 = -1
N1 = 32'hc47a0000;
N2 = 32'h3a83126f;
 #10
$display("T30");
$display("result: %x", result);
$display("expect: bf800000\n");

end     
endmodule