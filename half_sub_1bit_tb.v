`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/17/2024 02:43:11 PM
// Design Name: 
// Module Name: half_sub_1bit_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module half_sub_1bit_tb();

	reg a, b;
	wire d, bout;
	
	half_sub_1bit uut ( .a(a), .b(b), .d(d), .bout(bout) );
	
	initial begin
		
		#20;
		
		a = 0;
		b = 0;
		#20;
		
		a = 0;
		b = 1;
		#20;
		
		a = 1;
		b = 0;
		#20;
		
		a = 1;
		b = 1;
		#20;
		
		$stop;
	end
endmodule
