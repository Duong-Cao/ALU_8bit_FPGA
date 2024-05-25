`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/18/2024 10:02:21 PM
// Design Name: 
// Module Name: vedic_mul_2bit_tb
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


module vedic_mul_2bit_tb();

	reg [1:0] a;
	reg [1:0] b;
	
	wire [3:0] s;
	
	vedic_mul_2bit uut ( .a(a), .b(b), .s(s) );
	
	initial begin
		#10;
		
		a = 2'b00;
		b = 2'b01;
		#10;
		
		a = 2'b01;
		b = 2'b10;
		#10;
		
		a = 2'b10;
		b = 2'b01;
		#10;
		
		a = 2'b11;
		b = 2'b11;
		#10;
		
		$stop;
	end

endmodule
