package packet_types_pkg;

virtual class Packet ;
byte unsigned payload[];
byte unsigned crc;
byte unsigned check_crc;
int pkt_id;
static int num_pkts = 1;

function new();
  pkt_id = num_pkts++;
endfunction

pure virtual function void gen_crc();//endfunction
pure virtual function bit cheeck_crc(); //endfunction

function void print_payload();
  for (int i=0; i<payload.size(); i++)
    $display("payload[%0d] = %p ", i ,payload[i]);
endfunction

virtual function void init_pkt(int sz);
  payload = new[sz];
  for (int i = 0; i<sz; i++)
    payload[i] = $random() % 256;
    gen_crc(); 
// crc++; // insert error by uncommenting this line
endfunction 

endclass
//**************
// Your code here
//packet 1
class pkt_type_1 extends Packet ;

virtual function void gen_crc();
  crc = payload.sum ;
endfunction

virtual function bit cheeck_crc();
  check_crc = payload.sum ;
  if (check_crc == crc)begin 
    $display ("there isn't any error");
    return(1);
  end
  else begin 
    $display ("there is an error");
    return(0);
  end
endfunction

virtual function void init_pkt(int sz);
  super.init_pkt(sz) ; 
endfunction

endclass

//packet 1 with error
class pkt_type_1_error extends pkt_type_1 ;

virtual function void init_pkt(int sz);
  super.init_pkt(sz); 
  crc++;
endfunction

endclass

//packet 2
class pkt_type_2 extends Packet ;

virtual function void gen_crc();
  crc = payload.product ; 
endfunction

virtual function bit cheeck_crc();
  check_crc = payload.product ;
  if (check_crc == crc)begin 
    $display ("there isn't any error");
    return(1);
  end
  else begin 
    $display ("there is an error");
    return(0);
  end
endfunction

virtual function void init_pkt(int sz);
  super.init_pkt(sz) ; 
endfunction

endclass

//packet 2 with error
class pkt_type_2_error extends pkt_type_2 ;

virtual function void init_pkt(int sz);
  super.init_pkt(sz); 
  crc++;
endfunction

endclass

endpackage
