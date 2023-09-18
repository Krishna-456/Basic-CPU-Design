`timescale 1ns/1ns

//This is a 8 bit orca with a carry in(cin) and a carry out(cout)
module rca8(
	
  input [7:0] A, B,
  input cin,
  output [7:0] sum,
  output cout
);
	
  wire [7:1] carry;//used to represent the carry between the full adders
  FullAdder abc (A[0], B[0], cin, sum[0], carry[1]); //The first bit 
  FullAdder uut[6:1] ( A[6:1], B[6:1], carry[6:1], sum[6:1], carry[7:2]);
  FullAdder bcd (A[7], B[7], carry[7], sum[7], cout); //The last bit
	
endmodule