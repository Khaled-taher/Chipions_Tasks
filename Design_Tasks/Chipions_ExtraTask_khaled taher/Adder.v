module Adder (A,B,c_in,c_out,sum);
input A,B,c_in;
output c_out,sum;

assign sum = A^B^c_in ;
assign c_out = (A&B) | (A&c_in) | (B&c_in) ;

endmodule 


module Full_Adder (A,B,c_in,c_out,sum);
input [3:0] A,B ;
input c_in ;
output [3:0] sum ;
output c_out ;

wire c1,c2,c3;

Adder add1 (A[0],B[0],c_in,c1,sum[0]);
Adder add2 (A[1],B[1],c1,c2,sum[1]);
Adder add3 (A[2],B[2],c2,c3,sum[2]);
Adder add4 (A[3],B[3],c3,c_out,sum[3]);

endmodule 