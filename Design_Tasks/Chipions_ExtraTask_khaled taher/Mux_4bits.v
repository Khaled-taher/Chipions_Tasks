module Mux_4bits (y,a,b,c,d,sel);
input [3:0] a,b,c,d;
input [1:0] sel;
output [3:0] y;

assign y =
(sel==0) ? a :
(sel==1) ? b :
(sel==2) ? c :
(sel==3) ? d : 4'bx;
endmodule
