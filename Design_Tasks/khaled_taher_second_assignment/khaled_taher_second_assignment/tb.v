`timescale 100ns/10ns 
module test_bench ();
reg clk,reset,vss,vdd ;
reg [7:0] word_in , word1;
wire [7:0] data, address ;
wire error ;

frame_decoder M1(clk,word_in,reset,vss,vdd,address,data,error);

initial
begin 
clk =1'b0 ; word_in =1'b0 ; reset =1'b0 ; vss =0; vdd =1'b0;
end

always begin
#5 clk=!clk ;
end
initial begin
$display ("/t/ttime,\tclk,\tword_in,\tvss,\tvdd,\treset");
$monitor ("%d,\t%b,\t%h,\t%b,\t%b,\t%b" ,$time,clk,word_in,vss,vdd,reset) ;
end

event resettrig ;
event end_resettrig ;

always begin
@(resettrig)
@(negedge clk) 
reset = 1'b1 ;
@(negedge clk) 
reset =1'b0 ; 
-> end_resettrig ;
end

always @(posedge clk) begin
vss =1'b1 ;
-> resettrig ;
@(end_resettrig) 
#1 word_in = 8'hc9 ;
@(posedge clk)
#1 word_in = 8'h60 ;
@(posedge clk) 
#1 word_in = 8'h60 ;
@(posedge clk) 
#1 word_in = 8'h61 ;
@(posedge clk) 
#1 word_in = 8'h9c ;
if (data==8'h61 && address ==8'h60 && error ==1'b0) 
$display ("code is correct");
else 
$display ("code is incorrect");
end

always @(posedge clk) begin
vss =1'b0 ;
-> resettrig ;
@(end_resettrig) 
#1 word_in = 8'hc9 ;
@(posedge clk)
#1 word_in = 8'h60 ;
@(posedge clk) 
#1 word_in = 8'h60 ;
@(posedge clk) 
#1 word_in = 8'h61 ;
@(posedge clk) 
#1 word_in = 8'h9c ;
if (data==8'h0 && address ==8'h0 && error ==1'b0) 
$display ("code is correct");
else 
$display ("code is incorrect");
end

always @(posedge clk) begin
vss =1'b1 ;
-> resettrig ;
@(end_resettrig) 
#1 word_in = 8'h9c ;
@(posedge clk)
#1 word_in = 8'h60 ;
@(posedge clk) 
#1 word_in = 8'h60 ;
@(posedge clk) 
#1 word_in = 8'h61 ;
@(posedge clk) 
#1 word_in = 8'h9c ;
if (data==8'h0 && address ==8'h0 && error ==1'b1) 
$display ("code is correct");
else 
$display ("code is incorrect");
end

always @(posedge clk) begin
vss =1'b1 ;
-> resettrig;
@(end_resettrig) 
#1 word_in = 8'hc9 ;
@(posedge clk)
#1 word_in = 8'h60 ;
@(posedge clk) 
#1 word_in = 8'h60 ;
@(posedge clk) 
#1 word_in = 8'h61 ;
@(posedge clk) 
#1 word_in = 8'h69 ;
if (data==8'h0 && address ==8'h0 && error ==1'b1) 
$display ("code is correct");
else 
$display ("code is incorrect");
end

always @(posedge clk) begin
vss =1'b1 ;
-> resettrig;
@(end_resettrig) 
#1 word_in = 8'hc9 ;
@(posedge clk)
#1 word_in = 8'h61 ;
@(posedge clk) 
#1 word_in = 8'h88 ;
@(posedge clk) 
#1 word_in = 8'h2 ;
#1 word1 = data ;
@(posedge clk) 
#1 word_in = 8'h10 ;
@(posedge clk) 
#1 word_in = 8'h9c ;
if (data==8'h10 && word1==8'h2 && address ==8'h88 && error ==1'b0) 
$display ("code is correct");
else 
$display ("code is incorrect");
end
endmodule 
