module AOI_5 (input x1,x2,x3,x4,x5 ,output y);

assign y = !((x1&&x2)||(x3&&x4&&x5));

endmodule 
