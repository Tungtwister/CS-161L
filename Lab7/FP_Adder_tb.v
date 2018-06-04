`timescale 1ns / 1ps

module FP_Adder_tb;


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
	FP_Adder uut (
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
		

//16.25 + 2.75 = 19.0
$display("T0");
N1 = 32'h41820000;
N2 = 32'h40300000; #10
 if ( result != 32'h41980000) begin 
$display("result: %x", result);
$display("expect: 41980000\n");
 end
 
//10.5 + 11.24 = 21.74
$display("T1");
N1 = 32'h41280000;
N2 = 32'h4133d70a; #10
 if ( result != 32'h41adeb85) begin 
$display("result: %x", result);
$display("expect: 41adeb85\n");
 end 

//10.5 + -11.24 = -0.74
$display("T2");
N1 = 32'h41280000;
N2 = 32'hc133d70a; #10
 if ( result != 32'hbf3d70a0) begin 
$display("result: %x", result);
$display("expect: bf3d70a0\n");
 end 

//-10.5 + 11.24 = 0.74
$display("T3");
N1 = 32'hc1280000;
N2 = 32'h4133d70a; #10
 if ( result != 32'h3f3d70a0) begin 
$display("result: %x", result);
$display("expect: 3f3d70a0\n");
 end 

//-10.5 + -11.24 = -21.74
$display("T4");
N1 = 32'hc1280000;
N2 = 32'hc133d70a; #10
 if ( result != 32'hc1adeb85) begin 
$display("result: %x", result);
$display("expect: c1adeb85\n");
 end 

//10 + -10 = 0
$display("T5");
N1 = 32'h41200000;
N2 = 32'hc1200000; #10
 if ( result != 32'h0) begin 
$display("result: %x", result);
$display("expect: 00000000\n");
 end 

//-10 + 10 = 0
$display("T6");
N1 = 32'hc1200000;
N2 = 32'h41200000; #10
 if ( result != 32'h0) begin 
$display("result: %x", result);
$display("expect: 00000000\n");
 end 

//1e+06 + -5 = 999995
$display("T7");
N1 = 32'h49742400;
N2 = 32'hc0a00000; #10
 if ( result != 32'h497423b0) begin 
$display("result: %x", result);
$display("expect: 497423b0\n");
 end 

//1e+06 + 5 = 1e+06
$display("T8");
N1 = 32'h49742400;
N2 = 32'h40a00000; #10
 if ( result != 32'h49742450) begin 
$display("result: %x", result);
$display("expect: 49742450\n");
 end 

//5 + 1e+06 = 1e+06
$display("T9");
N1 = 32'h40a00000;
N2 = 32'h49742400; #10
 if ( result != 32'h49742450) begin 
$display("result: %x", result);
$display("expect: 49742450\n");
 end 

//-5 + 1e+06 = 999995
$display("T10");
N1 = 32'hc0a00000;
N2 = 32'h49742400; #10
 if ( result != 32'h497423b0) begin 
$display("result: %x", result);
$display("expect: 497423b0\n");
 end 

//1.67772e+07 + 1 = 1.67772e+07
$display("T11");
N1 = 32'h4b800000;
N2 = 32'h3f800000; #10
 if ( result != 32'h4b800000) begin 
$display("result: %x", result);
$display("expect: 4b800000\n");
 end 

//1.67772e+07 + -1 = 1.67772e+07
$display("T12");
N1 = 32'h4b800000;
N2 = 32'hbf800000; #10
 if ( result != 32'h4b7fffff) begin 
$display("result: %x", result);
$display("expect: 4b7fffff\n");
 end 

//200 + 50 = 250
$display("T13");
N1 = 32'h43480000;
N2 = 32'h42480000; #10
 if ( result != 32'h437a0000) begin 
$display("result: %x", result);
$display("expect: 437a0000\n");
 end 

//19.7554 + 700.623 = 720.378
$display("T14");
N1 = 32'h419e0b0f;
N2 = 32'h442f27df; #10
 if ( result != 32'h44341837) begin 
$display("result: %x", result);
$display("expect: 44341837\n");
 end 

//19.7554 + -700.623 = -680.868
$display("T15");
N1 = 32'h419e0b0f;
N2 = 32'hc42f27df; #10
 if ( result != 32'hc42a3787) begin 
$display("result: %x", result);
$display("expect: c42a3787\n");
 end 

//-19.7554 + 700.623 = 680.868
$display("T16");
N1 = 32'hc19e0b0f;
N2 = 32'h442f27df; #10
 if ( result != 32'h442a3787) begin 
$display("result: %x", result);
$display("expect: 442a3787\n");
 end 

//-19.7554 + -700.623 = -720.378
$display("T17");
N1 = 32'hc19e0b0f;
N2 = 32'hc42f27df; #10
 if ( result != 32'hc4341837) begin 
$display("result: %x", result);
$display("expect: c4341837\n");
 end 

//7.88861e-31 + 3.9443e-31 = 1.18329e-30
$display("T18");
N1 = 32'h0d800000;
N2 = 32'h0d000000; #10
 if ( result != 32'hdc00000) begin 
$display("result: %x", result);
$display("expect: 0dc00000\n");
 end 

//1998 + 2001 = 3999
$display("T19");
N1 = 32'h44f9c000;
N2 = 32'h44fa2000; #10
 if ( result != 32'h4579f000) begin 
$display("result: %x", result);
$display("expect: 4579f000\n");
 end 

//2012 + 2010 = 4022
$display("T20");
N1 = 32'h44fb8000;
N2 = 32'h44fb4000; #10
 if ( result != 32'h457b6000) begin 
$display("result: %x", result);
$display("expect: 457b6000\n");
 end 

//2008 + 2010 = 4018
$display("T21");
N1 = 32'h44fb0000;
N2 = 32'h44fb4000; #10
 if ( result != 32'h457b2000) begin 
$display("result: %x", result);
$display("expect: 457b2000\n");
 end 

//2001 + 1997 = 3998
$display("T22");
N1 = 32'h44fa2000;
N2 = 32'h44f9a000; #10
 if ( result != 32'h4579e000) begin 
$display("result: %x", result);
$display("expect: 4579e000\n");
 end 

//1994 + 1986 = 3980
$display("T23");
N1 = 32'h44f94000;
N2 = 32'h44f84000; #10
 if ( result != 32'h4578c000) begin 
$display("result: %x", result);
$display("expect: 4578c000\n");
 end 

//1987 + 1992 = 3979
$display("T24");
N1 = 32'h44f86000;
N2 = 32'h44f90000; #10
 if ( result != 32'h4578b000) begin 
$display("result: %x", result);
$display("expect: 4578b000\n");
 end 

//2005 + 2004 = 4009
$display("T25");
N1 = 32'h44faa000;
N2 = 32'h44fa8000; #10
 if ( result != 32'h457a9000) begin 
$display("result: %x", result);
$display("expect: 457a9000\n");
 end 

//2008 + 2001 = 4009
$display("T26");
N1 = 32'h44fb0000;
N2 = 32'h44fa2000; #10
 if ( result != 32'h457a9000) begin 
$display("result: %x", result);
$display("expect: 457a9000\n");
 end 

//1985 + 1991 = 3976
$display("T27");
N1 = 32'h44f82000;
N2 = 32'h44f8e000; #10
 if ( result != 32'h45788000) begin 
$display("result: %x", result);
$display("expect: 45788000\n");
 end 

//2007 + 2001 = 4008
$display("T28");
N1 = 32'h44fae000;
N2 = 32'h44fa2000; #10
 if ( result != 32'h457a8000) begin 
$display("result: %x", result);
$display("expect: 457a8000\n");
 end 

//1996 + 1993 = 3989
$display("T29");
N1 = 32'h44f98000;
N2 = 32'h44f92000; #10
 if ( result != 32'h45795000) begin 
$display("result: %x", result);
$display("expect: 45795000\n");
 end 

//2012 + 1994 = 4006
$display("T30");
N1 = 32'h44fb8000;
N2 = 32'h44f94000; #10
 if ( result != 32'h457a6000) begin 
$display("result: %x", result);
$display("expect: 457a6000\n");
 end 

//1987 + 2005 = 3992
$display("T31");
N1 = 32'h44f86000;
N2 = 32'h44faa000; #10
 if ( result != 32'h45798000) begin 
$display("result: %x", result);
$display("expect: 45798000\n");
 end 

//1987 + 1998 = 3985
$display("T32");
N1 = 32'h44f86000;
N2 = 32'h44f9c000; #10
 if ( result != 32'h45791000) begin 
$display("result: %x", result);
$display("expect: 45791000\n");
 end 

//1992 + 2010 = 4002
$display("T33");
N1 = 32'h44f90000;
N2 = 32'h44fb4000; #10
 if ( result != 32'h457a2000) begin 
$display("result: %x", result);
$display("expect: 457a2000\n");
 end 

//2014 + 1997 = 4011
$display("T34");
N1 = 32'h44fbc000;
N2 = 32'h44f9a000; #10
 if ( result != 32'h457ab000) begin 
$display("result: %x", result);
$display("expect: 457ab000\n");
 end 

//1997 + 2003 = 4000
$display("T35");
N1 = 32'h44f9a000;
N2 = 32'h44fa6000; #10
 if ( result != 32'h457a0000) begin 
$display("result: %x", result);
$display("expect: 457a0000\n");
 end 

//2014 + 2012 = 4026
$display("T36");
N1 = 32'h44fbc000;
N2 = 32'h44fb8000; #10
 if ( result != 32'h457ba000) begin 
$display("result: %x", result);
$display("expect: 457ba000\n");
 end 

//1998 + 2001 = 3999
$display("T37");
N1 = 32'h44f9c000;
N2 = 32'h44fa2000; #10
 if ( result != 32'h4579f000) begin 
$display("result: %x", result);
$display("expect: 4579f000\n");
 end 

//1986 + 2007 = 3993
$display("T38");
N1 = 32'h44f84000;
N2 = 32'h44fae000; #10
 if ( result != 32'h45799000) begin 
$display("result: %x", result);
$display("expect: 45799000\n");
 end 

//1994 + 1988 = 3982
$display("T39");
N1 = 32'h44f94000;
N2 = 32'h44f88000; #10
 if ( result != 32'h4578e000) begin 
$display("result: %x", result);
$display("expect: 4578e000\n");
 end 

//2006 + 2014 = 4020
$display("T40");
N1 = 32'h44fac000;
N2 = 32'h44fbc000; #10
 if ( result != 32'h457b4000) begin 
$display("result: %x", result);
$display("expect: 457b4000\n");
 end 

//1999 + 1992 = 3991
$display("T41");
N1 = 32'h44f9e000;
N2 = 32'h44f90000; #10
 if ( result != 32'h45797000) begin 
$display("result: %x", result);
$display("expect: 45797000\n");
 end 

//1993 + 1999 = 3992
$display("T42");
N1 = 32'h44f92000;
N2 = 32'h44f9e000; #10
 if ( result != 32'h45798000) begin 
$display("result: %x", result);
$display("expect: 45798000\n");
 end 

//1990 + 1985 = 3975
$display("T43");
N1 = 32'h44f8c000;
N2 = 32'h44f82000; #10
 if ( result != 32'h45787000) begin 
$display("result: %x", result);
$display("expect: 45787000\n");
 end 

//2008 + 2001 = 4009
$display("T44");
N1 = 32'h44fb0000;
N2 = 32'h44fa2000; #10
 if ( result != 32'h457a9000) begin 
$display("result: %x", result);
$display("expect: 457a9000\n");
 end 

//1986 + 2005 = 3991
$display("T45");
N1 = 32'h44f84000;
N2 = 32'h44faa000; #10
 if ( result != 32'h45797000) begin 
$display("result: %x", result);
$display("expect: 45797000\n");
 end 

//2011 + 1988 = 3999
$display("T46");
N1 = 32'h44fb6000;
N2 = 32'h44f88000; #10
 if ( result != 32'h4579f000) begin 
$display("result: %x", result);
$display("expect: 4579f000\n");
 end 

//1987 + 2005 = 3992
$display("T47");
N1 = 32'h44f86000;
N2 = 32'h44faa000; #10
 if ( result != 32'h45798000) begin 
$display("result: %x", result);
$display("expect: 45798000\n");
 end 

//2001 + 1986 = 3987
$display("T48");
N1 = 32'h44fa2000;
N2 = 32'h44f84000; #10
 if ( result != 32'h45793000) begin 
$display("result: %x", result);
$display("expect: 45793000\n");
 end 

//2000 + 2000 = 4000
$display("T49");
N1 = 32'h44fa0000;
N2 = 32'h44fa0000; #10
 if ( result != 32'h457a0000) begin 
$display("result: %x", result);
$display("expect: 457a0000\n");
 end 

//1999 + 2012 = 4011
$display("T50");
N1 = 32'h44f9e000;
N2 = 32'h44fb8000; #10
 if ( result != 32'h457ab000) begin 
$display("result: %x", result);
$display("expect: 457ab000\n");
 end 

//2011 + 1990 = 4001
$display("T51");
N1 = 32'h44fb6000;
N2 = 32'h44f8c000; #10
 if ( result != 32'h457a1000) begin 
$display("result: %x", result);
$display("expect: 457a1000\n");
 end 

//2001 + 1994 = 3995
$display("T52");
N1 = 32'h44fa2000;
N2 = 32'h44f94000; #10
 if ( result != 32'h4579b000) begin 
$display("result: %x", result);
$display("expect: 4579b000\n");
 end 

//1998 + 2002 = 4000
$display("T53");
N1 = 32'h44f9c000;
N2 = 32'h44fa4000; #10
 if ( result != 32'h457a0000) begin 
$display("result: %x", result);
$display("expect: 457a0000\n");
 end 

//2009 + 2000 = 4009
$display("T54");
N1 = 32'h44fb2000;
N2 = 32'h44fa0000; #10
 if ( result != 32'h457a9000) begin 
$display("result: %x", result);
$display("expect: 457a9000\n");
 end 

//1997 + 2000 = 3997
$display("T55");
N1 = 32'h44f9a000;
N2 = 32'h44fa0000; #10
 if ( result != 32'h4579d000) begin 
$display("result: %x", result);
$display("expect: 4579d000\n");
 end 

//1999 + 2012 = 4011
$display("T56");
N1 = 32'h44f9e000;
N2 = 32'h44fb8000; #10
 if ( result != 32'h457ab000) begin 
$display("result: %x", result);
$display("expect: 457ab000\n");
 end 

//1999 + 1999 = 3998
$display("T57");
N1 = 32'h44f9e000;
N2 = 32'h44f9e000; #10
 if ( result != 32'h4579e000) begin 
$display("result: %x", result);
$display("expect: 4579e000\n");
 end 

//1988 + 2005 = 3993
$display("T58");
N1 = 32'h44f88000;
N2 = 32'h44faa000; #10
 if ( result != 32'h45799000) begin 
$display("result: %x", result);
$display("expect: 45799000\n");
 end 

//1992 + 2003 = 3995
$display("T59");
N1 = 32'h44f90000;
N2 = 32'h44fa6000; #10
 if ( result != 32'h4579b000) begin 
$display("result: %x", result);
$display("expect: 4579b000\n");
 end 

//1991 + 1993 = 3984
$display("T60");
N1 = 32'h44f8e000;
N2 = 32'h44f92000; #10
 if ( result != 32'h45790000) begin 
$display("result: %x", result);
$display("expect: 45790000\n");
 end 

//1993 + 2009 = 4002
$display("T61");
N1 = 32'h44f92000;
N2 = 32'h44fb2000; #10
 if ( result != 32'h457a2000) begin 
$display("result: %x", result);
$display("expect: 457a2000\n");
 end 

//1988 + 1996 = 3984
$display("T62");
N1 = 32'h44f88000;
N2 = 32'h44f98000; #10
 if ( result != 32'h45790000) begin 
$display("result: %x", result);
$display("expect: 45790000\n");
 end 

//1999 + 2004 = 4003
$display("T63");
N1 = 32'h44f9e000;
N2 = 32'h44fa8000; #10
 if ( result != 32'h457a3000) begin 
$display("result: %x", result);
$display("expect: 457a3000\n");
 end 

//1997 + 1985 = 3982
$display("T64");
N1 = 32'h44f9a000;
N2 = 32'h44f82000; #10
 if ( result != 32'h4578e000) begin 
$display("result: %x", result);
$display("expect: 4578e000\n");
 end 

//2011 + 2003 = 4014
$display("T65");
N1 = 32'h44fb6000;
N2 = 32'h44fa6000; #10
 if ( result != 32'h457ae000) begin 
$display("result: %x", result);
$display("expect: 457ae000\n");
 end 

//2004 + 2007 = 4011
$display("T66");
N1 = 32'h44fa8000;
N2 = 32'h44fae000; #10
 if ( result != 32'h457ab000) begin 
$display("result: %x", result);
$display("expect: 457ab000\n");
 end 

//2001 + 1991 = 3992
$display("T67");
N1 = 32'h44fa2000;
N2 = 32'h44f8e000; #10
 if ( result != 32'h45798000) begin 
$display("result: %x", result);
$display("expect: 45798000\n");
 end 

//2009 + 2014 = 4023
$display("T68");
N1 = 32'h44fb2000;
N2 = 32'h44fbc000; #10
 if ( result != 32'h457b7000) begin 
$display("result: %x", result);
$display("expect: 457b7000\n");
 end 

enable = 0; #10
enable = 1; #10 ; 

end
	
     
endmodule

