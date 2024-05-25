`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/19/2024 10:41:54 PM
// Design Name: 
// Module Name: vedic_mul_8bit_TB
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


module vedic_mul_8bit_TB();

	reg [7:0] a;
	reg [7:0] b;
	
	wire [15:0] s;
	
	vedic_mul_8bit uut ( .a(a), .b(b), .s(s) );
	
//	function init (void)
//		a <= 0;
//		b <= 0;
//	endfunction
	
	initial begin
		//init();
		#10;
		
		a = 15;
		b = 15;
		#10;
		
		a = 29;
		b = 28;
		#10;
		
		a = 158;
		b = 157;
		#10;
		
		a = 9;
		b = 9;
		#10;
		
		$stop;
	end

endmodule
