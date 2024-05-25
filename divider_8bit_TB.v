`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/22/2024 08:40:23 PM
// Design Name: 
// Module Name: divider_8bit_TB
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


module divider_8bit_TB();

	reg [7:0] a;
	reg [3:0] b;
	
	wire [4:0] r;
	wire [7:0] q;
	
	divider_8bit uut ( .a(a), .b(b), .r(r), .q(q) );
	
	initial begin
	
		#10;
		
		a = 15;
		b = 3;
		#10;
		
		a = 9;
		b = 3;
		#10;
		
		a = 20;
		b = 3;
		#10;
		
		a = 20;
		b = 5;
		#10;
		
		a = 155;
		b = 15;
		#10;
		
		a = 12;
		b = 3;
		#10;
		
		a = 8;
		b = 3;
		#10;
		
		$stop;
	
	end

endmodule
