`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/17/2024 10:44:48 PM
// Design Name: 
// Module Name: subtractor_8bit_tb
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


module subtractor_8bit_tb();

	reg [7:0] a;
	reg [7:0] b;

	wire [7:0] d;
	wire bout;
	
	subtractor_8bit uut (
		.a(a),
		.b(b),
		.bout(bout),
		.d(d)
		);
	
	initial begin
	
		#10;
		
		a = 8'b10100101;
		b = 8'b10010011;
		#10;
	
		a = 8'b11110000;
		b = 8'b11100000;
		#10;
		
		$stop;
	end

endmodule
