module Mux_2_32_CA #(parameter word_size = 32)(mux_out,data_1,data_0,select);
output [word_size-1:0] mux_out ;
input [word_size-1:0] data_1,data_0 ;
input select;

assign mux_out = select ? data_1 : data_0 ;
endmodule
