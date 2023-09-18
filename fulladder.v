`timescale 1ns/1ns

//Explained in report
module FullAdder(P, Q, cin, sum, cout);

	input P, Q, cin;
	output cout, sum;
	
	wire sum1;
	wire carry1;
	wire carry2;
	
	
        HalfAdder uut (.sum(sum1), .carry(carry1), .A(P), .B(Q));
	
	HalfAdder uut1 (.sum(sum), .carry(carry2), .A(cin), .B(sum1));
	
	or (cout, carry1, carry2);
	
endmodule
