`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/17/2024 02:56:18 PM
// Design Name: 
// Module Name: full_sub_1bit_tb
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


module full_sub_1bit_tb();

	reg a, b, bin;
	wire d, bout;
	
	
	full_sub_1bit uut ( .a(a), .b(b), .bin(bin), .d(d), .bout(bout) );
	
	initial begin
		#10;
		
		bin = 0;
		
		a = 0;
		b = 0;
		#10;
		
		a = 0;
		b = 1;
		#10;
		
		a = 1;
		b = 0;
		#10;
		
		a = 1;
		b = 1;
		#10;

		bin = 1;
		
		a = 0;
		b = 0;
		#10;
		
		a = 0;
		b = 1;
		#10;
		
		a = 1;
		b = 0;
		#10;
		
		a = 1;
		b = 1;
		#10;
		
		$stop;
	end
endmodule
