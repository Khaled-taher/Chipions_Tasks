module dual_ram (chip_sel1,chip_sel2,data_bus1,data_bus2,addr1,addr2,wr1,wr2,rd1,rd2,clk,out1,out2);
input [7:0] addr1,addr2;  // input address port
input chip_sel1,chip_sel2,wr1,wr2,rd1,rd2,clk; //contro; signals
inout [7:0] data_bus1,data_bus2; //in-out data port

output reg [7:0] out1,out2; //output of ram
reg [7:0] ram1 [0:255]; //ram 1 declearation
reg [7:0] ram2 [0:255]; //ram 2 declearation

//code of ram 1
always @(posedge clk) begin
if (wr1&&rd1) //to be sure there is read-write in the same time
	out1[7:0]=8'hxx;
else if (chip_sel1&&rd1&&(addr1!=((8'hxx)||(8'hzz)))) //to be sure there is an input address while readind data
	out1[7:0]=ram1[addr1];
else if (chip_sel1&&wr1) //write data
	ram1[addr1]=data_bus1[7:0];
else 
	out1=8'hxx; //to avoid any latch
end

assign data_bus1[7:0]= (chip_sel1&&rd1&& !wr1)?out1[7:0]:8'hzz ; //buffer to put output in the in-out port

//code of ram 2
always @(posedge clk) begin
if (wr2&&rd2) //to be sure there is read-write in the same time
	out2[7:0]=8'hxx;
else if (chip_sel2&&rd2&&(addr2!=((8'hxx)||(8'hzz)))) //to be sure there is an input address while readind data
	out2[7:0]=ram2[addr2];
else if (chip_sel2&&wr2) //write data
	ram2[addr2]=data_bus2[7:0];
else 
	out2=8'hxx; //to avoid any latch
end

assign data_bus2[7:0]= (chip_sel2&&rd1&& !wr2)?out2[7:0]:8'hzz ; //buffer to put output in the in-out port


endmodule
