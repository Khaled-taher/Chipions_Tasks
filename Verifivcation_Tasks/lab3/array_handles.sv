module array_handles;
	
class Packet;
int field1;

function new(int i);
  field1 = i;
endfunction

endclass : Packet
	
class sink;
mailbox #(Packet) in_chan;
Packet stim_pkt;
int id;
		
function new(int i);
  id = i;
endfunction
	
task run();
  for(int i = 0; i <= id; i++) begin
    in_chan.get(stim_pkt);
    $display("sink[%0d]: Received packet with field1 = (%0d)",id, stim_pkt.field1);
	end 
endtask

endclass : sink

class source;
mailbox #(Packet) out_chan; // null handle
Packet pkt_to_send;
int id;

function new(int i);
  id = i;
endfunction

task run();
  for(int i = 0; i <= id; i++) begin
    pkt_to_send = new(i);
		out_chan.put(pkt_to_send);
		$display("source[%0d]: send packet with field1 = (%0d)",id, pkt_to_send.field1);
	end
endtask

endclass : source

sink snk[];
source src[];
mailbox #(Packet) src2snk[];

initial begin 
// add your code here
snk = new [5] ;
src = new [5] ;
src2snk = new [5] ;

for (int i= 0 ; i <5 ; i++) begin 
  snk [i] = new (i);
  src [i] = new (i);
  src2snk [i] = new (i);
  snk[i].in_chan = src2snk [i];
  src[i].out_chan = src2snk [i];
end

for (int i= 0 ; i <5 ; i++) begin
  fork
  src[i].run() ;
  snk[i].run() ;
  join_none
  #0;
end

end

endmodule : array_handles