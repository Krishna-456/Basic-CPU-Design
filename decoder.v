`timescale 1ns/1ns

//A simple 3X8 decoder
module decoder(
  input wire [2:0]code,
  output wire [7:0]d
);
  wire not_a,not_b,not_c;
  wire a,b,c;
  // a,b,c represent the bits from left hand side respectively
  buf d1(a,code[2]);
  buf d2(b,code[1]);
  buf d3(c,code[0]);
  
  //Finding nots of three bits
  not a1(not_a,code[2]);
  not b1(not_b,code[1]);
  not c1(not_c,code[0]);

  and l0(d[0],not_a,not_b,not_c);//d0=a'b'c'
  and l1(d[1],not_a,not_b,c);	 //d1=a'b'c
  and l2(d[2],not_a,b,not_c);	 //d2=a'bc'
  and l4(d[3],not_a,b,c);	 //d3=a'bc
  and l3(d[4],a,not_b,not_c);	 //d4=ab'c'
  and l5(d[5],a,not_b,c);	 //d5=ab'c
  and l6(d[6],a,b,not_c);	 //d6=abc'
  and l7(d[7],a,b,c);		 //d7=abc
  
endmodule