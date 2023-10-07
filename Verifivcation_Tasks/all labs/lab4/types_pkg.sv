package types_pkg;

import packet_types_pkg::*;

//**********************
// Your code here
// class source and class sink
class source ;
mailbox #(Packet) out_chan ;
pkt_type_1 pkt_to_send1 [];
pkt_type_1_error pkt_to_send2 [];
pkt_type_2 pkt_to_send3 [];
pkt_type_2_error pkt_to_send4 [];
int a , b , c , d ;

/*  i:good packet 1   j:bad packet 1
    k:good packet 2   l:bad packet 2  */     
function new (int i , int j , int k , int l);
  pkt_to_send1 = new [i] ;
  a = i ;
  pkt_to_send2 = new [j] ;
  b = j ;
  pkt_to_send3 = new [k] ;
  c = k ;
  pkt_to_send4 = new [l] ;
  d = l ;
endfunction

task run () ;
  for (int i= 0 ; i < a ; i++ ) begin 
    pkt_to_send1 [i] = new () ;
    pkt_to_send1[i].init_pkt(5) ;
    pkt_to_send1[i].print_payload() ;
    out_chan.put(pkt_to_send1[i]) ;
    $display("source : send packet, id = %0d", i);
    #0;
  end

  for (int i= 0 ; i < b ; i++ ) begin 
    pkt_to_send2 [i] = new () ;
    pkt_to_send2[i].init_pkt(5) ;
    pkt_to_send2[i].print_payload() ;
    out_chan.put(pkt_to_send2[i]) ;
    $display("source : send packet, id = %0d", i+a);
    #0;
  end

  for (int i= 0 ; i < c ; i++ ) begin 
    pkt_to_send3 [i] = new () ; 
    pkt_to_send3[i].init_pkt(5) ;
    pkt_to_send3[i].print_payload() ;
    out_chan.put(pkt_to_send3[i]) ;
    $display("source : send packet, id = %0d", i+a+b);
    #0;
  end

  for (int i= 0 ; i < d ; i++ ) begin 
    pkt_to_send4 [i] = new () ;
    pkt_to_send4[i].init_pkt(5) ;
    pkt_to_send4[i].print_payload() ;
    out_chan.put(pkt_to_send4[i]) ; 
    $display("source : send packet, id = %0d", i+a+b+c); 
    #0;
  end

endtask

endclass

class sink ;
mailbox #(Packet) in_chan ;
Packet stim_pkt [];
bit x ;
Packet good_pkt [*] ;

function new (int i);
  stim_pkt = new [i] ;
endfunction

task run() ;
  for (int i = 0 ; i <= stim_pkt.size ; i++ ) begin
    in_chan.get(stim_pkt[i]) ;
    x = stim_pkt[i].cheeck_crc();
    $display("sink : recieve packet, id = %0d", i);
    if (x==1)
      good_pkt[stim_pkt[i].pkt_id]= stim_pkt[i] ;
    #0; 
  end  
endtask

endclass

//******************
class env;
// create channel between source & sink
mailbox #(Packet) src2snk = new (10); 
/*create source send 5 packet 1 (4 good and 1 with error) 
and 5 packet 2 (3 good and 2 with error)*/
source src = new(4,1,3,2);
sink snk = new(10); // create sink obj - receive 10 Packets

function void connect();
  src.out_chan = src2snk; //connect up src to mailbox 
  snk.in_chan = src2snk; //connect up snk to mailbox
endfunction

task automatic run();
  fork
  snk.run(); // start up sink
  src.run(); // start up source
  join_none
  #0;
endtask

endclass //env

endpackage