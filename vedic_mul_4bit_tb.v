`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/18/2024 11:43:39 PM
// Design Name: 
// Module Name: vedic_mul_4bit_tb
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


module vedic_mul_4bit_tb();

	reg [3:0] a;
	reg [3:0] b;
	
	wire [7:0] s;
	
	vedic_mul_4bit uut(
						.a(a),
						.b(b),
						.s(s)
						);
	
	initial begin
		a <= 0;
		b <= 0;
		#10;
		
		a = 4;
		b = 4;
		#10;
		
		a = 2;
		b = 9;
		#10;
		
		a = 9;
		b = 9;
		#10;
		
		$stop;
	end
endmodule
