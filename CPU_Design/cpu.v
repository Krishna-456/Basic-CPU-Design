`timescale 1ns/1ns
//no is frequently used to denote numbers:just a note

// specadd is useful to choose the particular function we want to perform
//We do the and of the particular bit(d) with a 8 bit no.If d is 1 it remains same, else it becomes zero
module specadd(
  input [7:0]op,
  input d,
  output [7:0]res
);
  and(res[0],d,op[0]);
  and(res[1],d,op[1]);
  and(res[2],d,op[2]);
  and(res[3],d,op[3]);
  and(res[4],d,op[4]);
  and(res[5],d,op[5]);
  and(res[6],d,op[6]);
  and(res[7],d,op[7]);
endmodule

//The main module where both the operations of all and cu happen
module cu(
  input[18:0] instruction,
  output [7:0] result
);
  //These 8 bits numbers are used to store the intermediate values, thus wire.
  wire [7:0]select;
  wire [7:0]add,addres;
  wire [7:0]subtract,subtr,subres;
  wire [7:0]increment,incres;
  wire [7:0]decrement,decres;
  wire [7:0]andt,andres;
  wire [7:0]ort,orres;
  wire [7:0]nott,notsec,notres;

  //These wires are used to represent carry outs from 8 bit addition operation
  wire cout,cout1,cout2,cout3,cout4,cout5;
  
  //inc,dec,n and x represent constant bit values
  wire [7:0]inc=8'b00000001;
  wire [7:0]dec=8'b11111111;
  wire [7:0]n=8'b00000000;
  wire x=1'b0;
  
  //This is the only operation performed in CU and is a decoder for converting 3 bit opcode to 8 bit select
  decoder uut(instruction[18:16],select[7:0]);
  
  //From here forth only ALU operations
  //instruction[15:8] is operand 1
  //instruction[7:0] is operand 2
  rca8 uut00(instruction[15:8],instruction[7:0],x,add[7:0],cout);//8 bit ripple carry addition to calculate the result of adding the two 8 bit no
  not uut0[7:0](nott[7:0],instruction[15:8]);                    //Used to calculate not of first operand(nott)
  and uut1[7:0](andt[7:0],instruction[15:8],instruction[7:0]);   //Used to calculate and of operands 1 and 2
  or uut2[7:0](ort[7:0],instruction[15:8],instruction[7:0]);     //Calculating or of operands 1 and 2
  rca8 uut3(instruction[15:8],inc[7:0],x,increment[7:0],cout1);  //incrementing the 8 bit no using orca
  rca8 uut4(instruction[15:8],dec[7:0],x,decrement[7:0],cout2);	 //decrementing by adding 2's complement of 8bit 1 with operand1
  /*
  The next 3 lines are used to find subtraction result where notsec is not of operand 2
  Then 8 bit 1 is added to subtr[7:0] to get subtraction result
  */
  not uut6[7:0](notsec[7:0],instruction[7:0]);
  rca8 uut7(instruction[15:8],notsec[7:0],x,subtr[7:0],cout4);
  rca8 uut8(subtr[7:0],inc[7:0],x,subtract[7:0],cout5);

  //Out of the 7 results, specadd converts all the other results to 0 except the one bit in select with 1
  specadd uut9(add[7:0],select[1],addres[7:0]);       //add uses bit 1
  specadd uut10(subtract[7:0],select[2],subres[7:0]); //subtract uses bit 2
  specadd uut11(increment[7:0],select[3],incres[7:0]);//increment uses bit 3
  specadd uut12(decrement[7:0],select[4],decres[7:0]);//decrement uses bit 4
  specadd uut13(andt[7:0],select[5],andres[7:0]);     //and uses bit 5
  specadd uut14(ort[7:0],select[6],orres[7:0]);       //or uses bit 6
  specadd uut15(nott[7:0],select[7],notres[7:0]);     //not uses bit 7
  /*
   For example if select is 8'b00000010
   Then except add's result everything else becomes zero,since only bit 1 has value 1
  */

  //Finally or operation on all the results after specadd so that only the selected result is given as output
  wire [7:0]or1,or2,or3,or4,or5;
  or uut16[7:0](or1[7:0],addres[7:0],subres[7:0]);
  or uut17[7:0](or2[7:0],incres[7:0],or1[7:0]);
  or uut18[7:0](or3[7:0],decres[7:0],or2[7:0]);
  or uut19[7:0](or4[7:0],andres[7:0],or3[7:0]);
  or uut20[7:0](or5[7:0],orres[7:0],or4[7:0]);
  or uut21[7:0](result[7:0],notres[7:0],or5[7:0]);
endmodule