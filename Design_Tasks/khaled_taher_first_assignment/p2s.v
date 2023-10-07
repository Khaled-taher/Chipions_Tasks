module p2s (d_in , d_out , load , shift , clk );
input [7:0] d_in ; 
output reg d_out ;
input load , shift , clk ;

reg [7:0] flpflp ;

always @( posedge clk)
begin
if (load&&shift) 
	d_out = 1'hx ;
else if (load) 
	flpflp [7:0] = d_in [7:0] ;
else if (shift) begin
	d_out = flpflp [0] ;
	flpflp [0] = flpflp [1] ;
	flpflp [1] = flpflp [2] ;
	flpflp [2] = flpflp [3] ;
	flpflp [3] = flpflp [4] ;
	flpflp [4] = flpflp [5] ;
	flpflp [5] = flpflp [6] ;
	flpflp [6] = flpflp [7] ;
end
else 
	d_out = d_out ;
end 

endmodule

