`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/22/2024 08:51:16 PM
// Design Name: 
// Module Name: process_unit_TB
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


module process_unit_TB();

	reg a;
	reg b;
	reg sel;
	reg cin;
	
	wire cout;
	wire r;
	
	process_unit uut ( .a(a), .b(b), .sel(sel), .cout(cout), .r(r), .cin(cin) );
	
	initial begin
		#10;
		
		sel = 0;
		cin = 0;
		
		a = 0;
		b = 0;
		#10;
		
		a = 0;
		b = 1;
		#10;
		
		a = 1;
		b = 1;
		#10;
		
		sel = 1;
		cin = 1;
		
		a = 0;
		b = 1;
		#10;
		
		$stop;
	end

endmodule
