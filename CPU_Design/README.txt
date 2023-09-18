To simulate the working of the program, after unzipping open a terminal and cd into the folder.
1)Type the following code:
 
	iverilog cpu_tb.v cpu.v decoder.v fulladder.v halfadder.v rca8.v

2)Next type
 
	vvp a.out
	Now it should print "Test Completed"

3) Finally type

	gtkwave cu_testbench.vcd

Gtkwave should be accessible for graph