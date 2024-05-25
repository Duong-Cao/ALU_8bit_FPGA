`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/16/2024 11:27:45 PM
// Design Name: 
// Module Name: modified_csa_8bit_tb
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


module modified_csa_8bit_tb();


	reg [7:0] a;
	reg [7:0] b;
	reg cin;
	
	wire [7:0] sum;
	wire cout;
	
	
	modified_csa_8bit uut ( .a(a), .b(b), .cin(cin), .sum(sum), .cout(cout) );
	
	initial begin
		
		a <= 0;
		b <= 0;
		cin <= 0;
	
		#20;
		cin = 1'b0;
		a = 8'b10010100;
		b = 8'b10000101;
		
		#20;
		cin = 1'b1;
		a = 8'b11111111;
		b = 8'b11001100;
		
		#20;
		
		$stop;
	
	end
endmodule
