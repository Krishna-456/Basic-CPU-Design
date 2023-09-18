
//Explained in report

module HalfAdder(sum, carry, A, B);
	input A, B;
	output sum, carry;
	
	xor (sum, A, B);
	and (carry, A, B);
	
endmodule