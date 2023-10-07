module Comp_2__A2 (output A_lt_B,A_gt_B,A_eq_B, input [1:0] A,B);

assign A_lt_B = (A<B);
assign A_gt_B = (A>B);
assign A_eq_B = (A==B);

endmodule 