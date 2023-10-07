module frame_decoder (clk,word_in,reset,vss,vdd,address,data,error);
input clk,reset,vss,vdd ;
input [7:0] word_in ;
output error ;
output [7:0] address,data ;

reg error ;
reg [7:0] address , data ;
reg ctrl_b , ctrl_a , ctrl_e ;
reg [1:0] ctrl_ip ;

initial begin 
ctrl_b=0 ; ctrl_ip =0 ; ctrl_a =0 ; ctrl_e =0 ; error =0 ; address =0 ; data =0 ;
end

always @(posedge clk) begin
	if (reset==1 || vss==0 || vdd==1) begin
		data = 0 ;
		address =0 ; end

	else begin
	case (word_in) 
	8'hc9 : begin 
		if ((ctrl_b ==0) && (ctrl_ip ==0) && (ctrl_a ==0) && (ctrl_e ==0)) begin
			ctrl_b =1 ;
		end
		else if ((ctrl_b ==1) &&( (ctrl_ip ==1) || (ctrl_ip== 2 ))&& (ctrl_a ==0) && (ctrl_e == 0)) begin
			address = word_in ; ctrl_a =1 ;
		end
		else if ((ctrl_b ==1) && (ctrl_ip ==1) && (ctrl_a ==1) && (ctrl_e ==0)) begin
			data = word_in; ctrl_e =1 ;
		end
		else if ((ctrl_b ==1) && (ctrl_ip ==2) && (ctrl_a ==1) && (ctrl_e ==0)) begin
			data = word_in ;
			@(posedge clk)
			data = word_in ; ctrl_e =1 ;
		end
		else if (error ==1) begin
			ctrl_a =0 ; ctrl_ip =0 ; ctrl_b =0 ; ctrl_e =0 ; error =0 ;
		end
		else begin
			ctrl_a =0 ; ctrl_ip =0 ; ctrl_b =0 ; ctrl_e =0 ; error=1 ;
		end
		end

	8'h60 : begin 
		if (ctrl_b ==1 && ctrl_ip ==0 && ctrl_a ==0 && ctrl_e ==0) begin
			ctrl_ip =1;
		end
		else if (ctrl_b ==1 && (ctrl_ip ==1|| ctrl_ip==2) && ctrl_a ==0 && ctrl_e ==0)begin
			address = word_in ; 
			ctrl_a =1 ;
		end
		else if (ctrl_b ==1 && ctrl_ip ==1 && ctrl_a ==1 && ctrl_e ==0)begin
			data = word_in ;
			ctrl_e =1 ;
		end
		else if (ctrl_b ==1 && ctrl_ip ==2 && ctrl_a ==1 && ctrl_e ==0)begin
			data = word_in ;
			@(posedge clk)
			data = word_in ; ctrl_e = 1 ;
		end
		else if (error ==1) begin
			ctrl_a =0 ; ctrl_ip =0 ; ctrl_b =0 ; ctrl_e = 0 ; error =0 ;
		end
		else begin
			ctrl_a =0 ; ctrl_ip =0 ; ctrl_b =0 ; ctrl_e =0 ; error=1 ;
		end
		end

	8'h61 : begin 
		if (ctrl_b ==1 && ctrl_ip ==0 && ctrl_a ==0 && ctrl_e ==0) begin
			ctrl_ip =2;
		end
		else if (ctrl_b ==1 && (ctrl_ip ==1|| ctrl_ip==2) && ctrl_a ==0 && ctrl_e ==0) begin
			address = word_in ; 
			ctrl_a =1 ;
		end
		else if (ctrl_b ==1 && ctrl_ip ==1 && ctrl_a ==1 && ctrl_e ==0)begin
			data = word_in ;
			ctrl_e = 1 ;
		end
		else if (ctrl_b ==1 && ctrl_ip ==2 && ctrl_a ==1 && ctrl_e ==0) begin
			data = word_in ;
			@(posedge clk)
			data = word_in ; ctrl_e = 1 ;
		end
		else if (error ==1) begin
			ctrl_a =0 ; ctrl_ip =0 ; ctrl_b =0 ; ctrl_e =0 ; error =0 ;
		end
		else begin
			ctrl_a =0 ; ctrl_ip =0 ; ctrl_b =0 ; ctrl_e =0 ; error=1 ;
		end
		end

	8'h9c : begin 
		if (ctrl_b ==1 && (ctrl_ip ==1|| ctrl_ip==2) && ctrl_a ==0 && ctrl_e ==0)begin
			address = word_in ; 
			ctrl_a =1 ;
		end
		else if (ctrl_b ==1 && ctrl_ip ==1 && ctrl_a ==1 && ctrl_e ==0)begin
			data = word_in ;
			ctrl_e = 1 ;
		end
		else if (ctrl_b ==1 && ctrl_ip ==2 && ctrl_a ==1 && ctrl_e ==0)begin
			data = word_in ;
			@(posedge clk)
			data = word_in ; ctrl_e = 1 ;
		end
		else if (ctrl_b ==1 && (ctrl_ip ==1|| ctrl_ip==2) && ctrl_a ==1 && ctrl_e ==1)begin
			ctrl_b =0 ; ctrl_ip =0 ; ctrl_a =0 ; ctrl_e =0 ; error =0 ;
		end
		else if (error ==1) begin
			ctrl_a =0 ; ctrl_ip =0 ; ctrl_b =0 ; ctrl_e =0 ; error =0 ;
		end
		else begin
			ctrl_a =0 ; ctrl_ip =0 ; ctrl_b =0 ; ctrl_e =0 ; error=1 ;
		end
		end

	default : begin 
		if (ctrl_b ==1 && (ctrl_ip ==1|| ctrl_ip==2) && ctrl_a ==0 && ctrl_e ==0)begin
			address = word_in ; ctrl_a =1 ;
		end
		else if (ctrl_b ==1 && ctrl_ip ==1 && ctrl_a ==1 && ctrl_e ==0)begin
			data = word_in ; ctrl_e = 1 ;
		end
		else if (ctrl_b ==1 && ctrl_ip ==2 && ctrl_a ==1 && ctrl_e ==0)begin
			data = word_in ;
			@(posedge clk)
			data = word_in ; ctrl_e = 1 ;
		end
		else if (error ==1) begin
			ctrl_a =0 ; ctrl_ip =0 ; ctrl_b =0 ; ctrl_e =0 ; error =0 ;
		end
		else begin
			ctrl_a =0 ; ctrl_ip =0 ; ctrl_b =0 ; ctrl_e =0 ; error=1 ;
		end
		end 

	endcase
	end
end
endmodule

