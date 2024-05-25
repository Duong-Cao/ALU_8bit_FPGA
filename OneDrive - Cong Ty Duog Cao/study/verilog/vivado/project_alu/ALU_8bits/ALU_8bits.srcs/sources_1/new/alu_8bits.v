`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/19/2024 09:43:50 PM
// Design Name: 
// Module Name: alu_8bits
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


module alu_8bit(

    );
endmodule

// -------------------Begin: Modified CSA-------------------
module modified_csa_8bit(
	input [7:0] a,
	input [7:0] b,
	input cin,
	output [7:0] sum,
	output cout
    );
	
	wire [1:0] cout_i;
	wire [3:0] sum_bec;
	wire [4:0] x_bec;
	
	rca_4bits ic1 ( .a(a[3:0]), .b(b[3:0]), .cin(cin), .sum(sum[3:0]), .cout(cout_i[0]) );
	
	rca_4bits ic2 ( .a(a[7:4]), .b(b[7:4]), .cin(1'b0), .sum(sum_bec[3:0]), .cout(cout_i[1]) );
	
	bec_5bit ic3 ( .b(cout_i[1]), .a(sum_bec), .x(x_bec) );
	
	mux_2to1 ic4 ( .a(sum_bec[0]), .b(x_bec[0]), .o(sum[4]), .sel(cout_i[0]) );
	
	mux_2to1 ic5 ( .a(sum_bec[1]), .b(x_bec[1]), .o(sum[5]), .sel(cout_i[0]) );
	
	mux_2to1 ic6 ( .a(sum_bec[2]), .b(x_bec[2]), .o(sum[6]), .sel(cout_i[0]) );
	
	mux_2to1 ic7 ( .a(sum_bec[3]), .b(x_bec[3]), .o(sum[7]), .sel(cout_i[0]) );
	
	mux_2to1 ic8 ( .a(cout_i[1]), .b(x_bec[4]), .o(cout), .sel(cout_i[0]) );
	
endmodule


module bec_5bit(
	input [3:0] a,
	input b,
	output [4:0] x
    );
	
	assign x[0] = ~a[0];
	assign x[1] = a[0]^a[1];
	assign x[2] = (a[0]&a[1])^a[2];
	assign x[3] = (a[0]&a[1]&a[2])^a[3];
	assign x[4] = (a[0]&a[1]&a[2]&a[3])^b;
	
endmodule


module mux_2to1(
	input a, b,
	input sel,
	output o
	);
	
	assign o = sel ? b : a; 
	
endmodule


module rca_4bits(
	input [3:0] a, b,
	input cin,
	output cout,
	output [3:0] sum
    );
	
	wire [2:0] cout_rca; 
	
	full_adder_1bit ins0 ( .a(a[0]), .b(b[0]), .cin(cin), .sum(sum[0]), .cout(cout_rca[0]) );
	full_adder_1bit ins1 ( .a(a[1]), .b(b[1]), .cin(cout_rca[0]), .sum(sum[1]), .cout(cout_rca[1]) );
	full_adder_1bit ins2 ( .a(a[2]), .b(b[2]), .cin(cout_rca[1]), .sum(sum[2]), .cout(cout_rca[2]) );
	full_adder_1bit ins3 ( .a(a[3]), .b(b[3]), .cin(cout_rca[2]), .sum(sum[3]), .cout(cout) );

endmodule


module full_adder_1bit(
	input a, b,
	input cin,
	output cout,
	output sum
	);
	
	assign sum = a^b^cin;
	assign cout = (a&b)|((a^b)&cin);
	
endmodule
// -------------------End: Modified CSA-------------------


// -------------------Begin: Subtractor-------------------
module subtractor_8bit(
	input [7:0] a,
	input [7:0] b,
	output [7:0] d,
	output bout
    );
    
    wire [7:0] bin_w1;
    
    half_sub_1bit ic1 ( .a(a[0]), .b(b[0]), .d(d[0]), .bout(bin_w1[0]) );
    genvar i;
    generate
    	for(i=1; i<8; i=i+1) begin: full_sub_1bit
    		full_sub_1bit ic2 ( .a(a[i]), .b(b[i]), .bin(bin_w1[i-1]), .bout(bin_w1[i]), .d(d[i]) );
    	end
    	
    	assign bout = bin_w1[7];
    	
    endgenerate
    
endmodule


module tr_gate(
	input a, b, c,
	output p, q, r
	);
	
	assign p = a;
	assign q = a^b;
	assign r = (a&(~b))^c;
	
endmodule


module half_sub_1bit(
	input a, b,
	output bout, d
	);
	
	wire w1;
	wire w2;
	assign w2 = 0;
	
	tr_gate ic1 ( .a(a), .b(b), .c(0), .q(d), .p(w1), .r(w2) ); // not use port "r"
	assign bout = b&(~w1);
	
endmodule


module full_sub_1bit(
	input a, b, bin,
	output d, bout
	);
	
	wire w1, w2, w3;
	assign w3 = 0;
	
	half_sub_1bit ic1 ( .a(a), .b(b), .d(w1), .bout(w2) );
	tr_gate ic2 ( .a(bin), .b(w1), .c(w2), .q(d), .r(bout), .p(w3) );  // not use port "p"
	
endmodule
// -------------------End: Subtractor-------------------

// -------------------Begin: Vedic 8 bit-------------------
module vedic_mul_8bit(
	input [7:0] a,
	input [7:0] b,
	output [15:0] s
    );
    
    wire [7:0] w1; // instance ic1
    wire [7:0] w2; // instance ic2
    wire [7:0] w3; // instance ic3
    wire [7:0] w4; // instance ic4
    wire CA1; // cout of instance ic5
    wire CA2; // cout of instance ic6
    wire C_or; // CA1 or CA2
    
    wire [7:0] sum_csa_ic5;
    wire [7:0] sum_csa_ic6;
    wire [7:0] sum_csa_ic7;
    
    wire gnd;
	assign gnd = 0;
	
    vedic_mul_4bit ic1 ( .a(a[3:0]), .b(b[3:0]), .s(w1) );
    vedic_mul_4bit ic2 ( .a(a[3:0]), .b(b[7:4]), .s(w2) );
    vedic_mul_4bit ic3 ( .a(a[7:4]), .b(b[3:0]), .s(w3) );
    vedic_mul_4bit ic4 ( .a(a[7:4]), .b(b[7:4]), .s(w4) );
    
    assign s[3:0] = w1[3:0];
    
    modified_csa_8bit ic5 ( .a(w2), .b(w3), .cin(0), .cout(CA1), .sum(sum_csa_ic5) );
    modified_csa_8bit ic6 ( .a(sum_csa_ic5), .b( {4'b0000, w1[7:4]} ), .cin(0), .cout(CA2), .sum(sum_csa_ic6) );
    
    assign s[7:4] = sum_csa_ic6[3:0];
    assign C_or = CA1 | CA2;
    
    modified_csa_8bit ic7 ( .a(w4), .b( {4'b000, C_or, sum_csa_ic6[7:4]} ), .cin(0), .cout(gnd), .sum(sum_csa_ic7) );
    
    assign s[15:8] = sum_csa_ic7;
    
endmodule


module half_adder_1bit(
	input a, b,
	output sum, cout
	);

	assign sum = a^b;
	assign cout = a&b;
	
endmodule


module vedic_mul_2bit(
	input [1:0] a,
	input [1:0] b,
	output [3:0] s
	);
	
	wire w1, w2, w3, w4;
	
	assign w2 = a[1]&b[0];
	assign w3 = a[0]&b[1];
	assign w4 = a[1]&b[1];
	
	assign s[0] = a[0]&b[0];
	half_adder_1bit ic1 ( .a(w2), .b(w3), .cout(w1), .sum(s[1]) );
	half_adder_1bit ic2 ( .a(w4), .b(w1), .cout(s[3]), .sum(s[2]) );
	
endmodule


module vedic_mul_4bit(
	input [3:0] a,
	input [3:0] b,
	output [7:0] s
	);
	
	wire [15:0] w1; // store outputs of Vedic 2 bit
	wire [7:0] w2; // store outputs of RCA 4 bit
	wire CA1; // Carry out instance ic5
	wire CA2; // Carry out instance ic6
	wire [3:0] sum_rca1; // instance ic5
	wire [3:0] sum_rca2; // instance ic6
	wire [3:0] sum_rca3; // instance ic7
	wire w3; // store CA1 | CA2
	
	wire gnd;
	assign gnd = 0;
	
	vedic_mul_2bit ic1 ( .a(a[1:0]), .b(b[1:0]), .s(w1[3:0]) );
	vedic_mul_2bit ic2 ( .a(a[1:0]), .b(b[3:2]), .s(w1[7:4]) );
	vedic_mul_2bit ic3 ( .a(a[3:2]), .b(b[1:0]), .s(w1[11:8]) );
	vedic_mul_2bit ic4 ( .a(a[3:2]), .b(b[3:2]), .s(w1[15:12]) );
	
	assign s[0] = w1[0];
	assign s[1] = w1[1];
	
	rca_4bits ic5 ( .a(w1[7:4]), .b(w1[11:8]), .cin(0), .cout(CA1), .sum(sum_rca1) );
	rca_4bits ic6 ( .a( {1'b0, 1'b0, w1[3], w1[2]} ), .b(sum_rca1), .cin(0), .cout(CA2), .sum(sum_rca2) );
	
	assign s[2] = sum_rca2[0];
	assign s[3] = sum_rca2[1];
	
	assign w3 = CA1 | CA2; 
	
	rca_4bits ic7 ( .a( {1'b0, w3, sum_rca2[3], sum_rca2[2]} ), .b(w1[15:12]), .cin(0), .cout(gnd), .sum(sum_rca3) );
	
	assign s[7:4] = sum_rca3;
	
endmodule
// -------------------End: Vedic 8 bit-------------------


// -------------------Begin: Divider 8 bit-------------------
module divider_8bit(
	input [7:0] a,
	input [3:0] b,
	output [4:0] r,
	output [7:0] q
	);
	
	wire gnd;
	assign gnd = 0;
	
	wire [35:0] cout_temp;
	wire [35:0] sum_temp;
//	output wire [7:0] sel_temp;
	
	process_unit ic1 ( .a(a[7]), .b(b[0]), .cin(1'b1), .cout(cout_temp[0]), .r(sum_temp[0]), .sel(cout_temp[3]) );
	process_unit ic2 ( .a(1'b0), .b(b[1]), .cin(cout_temp[0]), .cout(cout_temp[1]), .r(sum_temp[1]), .sel(cout_temp[3]) );
	process_unit ic3 ( .a(1'b0), .b(b[2]), .cin(cout_temp[1]), .cout(cout_temp[2]), .r(sum_temp[2]), .sel(cout_temp[3]) );
	process_unit ic4 ( .a(1'b0), .b(b[3]), .cin(cout_temp[2]), .cout(cout_temp[3]), .r(sum_temp[3]), .sel(cout_temp[3]) );
	
	assign q[7] = cout_temp[3];
	
	process_unit ic5 ( .a(a[6]), .b(b[0]), .cin(1'b1), .cout(cout_temp[4]), .r(sum_temp[4]), .sel(cout_temp[7]) );
	process_unit ic6 ( .a(sum_temp[0]), .b(b[1]), .cin(cout_temp[4]), .cout(cout_temp[5]), .r(sum_temp[5]), .sel(cout_temp[7]) );
	process_unit ic7 ( .a(sum_temp[1]), .b(b[2]), .cin(cout_temp[5]), .cout(cout_temp[6]), .r(sum_temp[6]), .sel(cout_temp[7]) );
	process_unit ic8 ( .a(sum_temp[2]), .b(b[3]), .cin(cout_temp[6]), .cout(cout_temp[7]), .r(sum_temp[7]), .sel(cout_temp[7]) );
	
	assign q[6] = cout_temp[7];
	
	process_unit ic9 ( .a(a[5]), .b(b[0]), .cin(1'b1), .cout(cout_temp[8]), .r(sum_temp[8]), .sel(cout_temp[11]) );
	process_unit ic10 ( .a(sum_temp[4]), .b(b[1]), .cin(cout_temp[8]), .cout(cout_temp[9]), .r(sum_temp[9]), .sel(cout_temp[11]) );
	process_unit ic11 ( .a(sum_temp[5]), .b(b[2]), .cin(cout_temp[9]), .cout(cout_temp[10]), .r(sum_temp[10]), .sel(cout_temp[11]) );
	process_unit ic12 ( .a(sum_temp[6]), .b(b[3]), .cin(cout_temp[10]), .cout(cout_temp[11]), .r(sum_temp[11]), .sel(cout_temp[11]) );
	
	assign q[5] = cout_temp[11];
	
	process_unit ic13 ( .a(a[4]), .b(b[0]), .cin(1'b1), .cout(cout_temp[12]), .r(sum_temp[12]), .sel(cout_temp[15]) );
	process_unit ic14 ( .a(sum_temp[8]), .b(b[1]), .cin(cout_temp[12]), .cout(cout_temp[13]), .r(sum_temp[13]), .sel(cout_temp[15]) );
	process_unit ic15 ( .a(sum_temp[9]), .b(b[2]), .cin(cout_temp[13]), .cout(cout_temp[14]), .r(sum_temp[14]), .sel(cout_temp[15]) );
	process_unit ic16 ( .a(sum_temp[10]), .b(b[3]), .cin(cout_temp[14]), .cout(cout_temp[15]), .r(sum_temp[15]), .sel(cout_temp[15]) );
	
	assign q[4] = cout_temp[15];
	
	process_unit ic17 ( .a(a[3]), .b(b[0]), .cin(1'b1), .cout(cout_temp[16]), .r(sum_temp[16]), .sel(cout_temp[20]) );
	process_unit ic18 ( .a(sum_temp[12]), .b(b[1]), .cin(cout_temp[16]), .cout(cout_temp[17]), .r(sum_temp[17]), .sel(cout_temp[20]) );
	process_unit ic19 ( .a(sum_temp[13]), .b(b[2]), .cin(cout_temp[17]), .cout(cout_temp[18]), .r(sum_temp[18]), .sel(cout_temp[20]) );
	process_unit ic20 ( .a(sum_temp[14]), .b(b[3]), .cin(cout_temp[18]), .cout(cout_temp[19]), .r(sum_temp[19]), .sel(cout_temp[20]) );
	process_unit ic21 ( .a(sum_temp[15]), .b(1'b0), .cin(cout_temp[19]), .cout(cout_temp[20]), .r(sum_temp[20]), .sel(cout_temp[20]) );
	
	assign q[3] = cout_temp[20];
	
	process_unit ic22 ( .a(a[2]), .b(b[0]), .cin(1'b1), .cout(cout_temp[21]), .r(sum_temp[21]), .sel(cout_temp[25]) );
	process_unit ic23 ( .a(sum_temp[16]), .b(b[1]), .cin(cout_temp[21]), .cout(cout_temp[22]), .r(sum_temp[22]), .sel(cout_temp[25]) );
	process_unit ic24 ( .a(sum_temp[17]), .b(b[2]), .cin(cout_temp[22]), .cout(cout_temp[23]), .r(sum_temp[23]), .sel(cout_temp[25]) );
	process_unit ic25 ( .a(sum_temp[18]), .b(b[3]), .cin(cout_temp[23]), .cout(cout_temp[24]), .r(sum_temp[24]), .sel(cout_temp[25]) );
	process_unit ic26 ( .a(sum_temp[19]), .b(1'b0), .cin(cout_temp[24]), .cout(cout_temp[25]), .r(sum_temp[25]), .sel(cout_temp[25]) );

	assign q[2] = cout_temp[25];	
	
	process_unit ic27 ( .a(a[1]), .b(b[0]), .cin(1'b1), .cout(cout_temp[26]), .r(sum_temp[26]), .sel(cout_temp[30]) );
	process_unit ic28 ( .a(sum_temp[21]), .b(b[1]), .cin(cout_temp[26]), .cout(cout_temp[27]), .r(sum_temp[27]), .sel(cout_temp[30]) );
	process_unit ic29 ( .a(sum_temp[22]), .b(b[2]), .cin(cout_temp[27]), .cout(cout_temp[28]), .r(sum_temp[28]), .sel(cout_temp[30]) );
	process_unit ic30 ( .a(sum_temp[23]), .b(b[3]), .cin(cout_temp[28]), .cout(cout_temp[29]), .r(sum_temp[29]), .sel(cout_temp[30]) );
	process_unit ic31 ( .a(sum_temp[24]), .b(1'b0), .cin(cout_temp[29]), .cout(cout_temp[30]), .r(sum_temp[30]), .sel(cout_temp[30]) );
	
	assign q[1] = cout_temp[30];	
	
	process_unit ic32 ( .a(a[1]), .b(b[0]), .cin(1'b1), .cout(cout_temp[31]), .r(sum_temp[31]), .sel(cout_temp[35]) );
	process_unit ic33 ( .a(sum_temp[26]), .b(b[1]), .cin(cout_temp[31]), .cout(cout_temp[32]), .r(sum_temp[32]), .sel(cout_temp[35]) );
	process_unit ic34 ( .a(sum_temp[27]), .b(b[2]), .cin(cout_temp[32]), .cout(cout_temp[33]), .r(sum_temp[33]), .sel(cout_temp[35]) );
	process_unit ic35 ( .a(sum_temp[28]), .b(b[3]), .cin(cout_temp[33]), .cout(cout_temp[34]), .r(sum_temp[34]), .sel(cout_temp[35]) );
	process_unit ic36 ( .a(sum_temp[29]), .b(1'b0), .cin(cout_temp[34]), .cout(cout_temp[35]), .r(sum_temp[35]), .sel(cout_temp[35]) );
	
	assign q[0] = cout_temp[35];	

	assign r = sum_temp[35:31];

//	assign sel_temp[0] = cout_temp[3];
//	assign q[7] = cout_temp[3];
	
//	assign sel_temp[1] = cout_temp[7];
//	assign q[6] = cout_temp[7];
	
//	assign sel_temp[2] = cout_temp[11];
//	assign q[5] = cout_temp[11];
	
//	assign sel_temp[3] = cout_temp[15];
//	assign q[4] = cout_temp[15];
	
//	assign sel_temp[4] = cout_temp[20];
//	assign q[3] = cout_temp[20];
	
//	assign sel_temp[5] = cout_temp[25];
//	assign q[2] = cout_temp[25];
	
//	assign sel_temp[6] = cout_temp[30];
//	assign q[1] = cout_temp[30];
endmodule


module process_unit(
	input a, b, cin, sel,
	output cout, 
	output r
	);
	wire w1;
	
	wire w2;
	assign w2 = ~b;
	
	full_adder_1bit ic1 ( .a(a), .b(w2), .cin(cin), .cout(cout), .sum(w1) );
	
	assign r = sel ? w1 : a;
//	always @(sel) begin
//		if(sel)	r <= w1;
//		else	r <= a;
//	end
	
endmodule
// -------------------End: Divider 8 bit-------------------

