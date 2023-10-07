module Conti_Assignment (adder1,adder2,wr,d_in,valid1,valid2,d_out);
input [31:0] adder1,adder2,d_in;
input valid1,valid2,wr;
output [31:0] d_out;

wire valid;
wire [31:0] adder;

assign adder[31:0] = adder1 [31:0] ^ adder2 [31:0] ;
assign valid = valid1 | valid2 ;
assign d_out[31:0] = (valid&wr) ? {d_in[31:2],2'b11} : 32'd0 ;

endmodule 
