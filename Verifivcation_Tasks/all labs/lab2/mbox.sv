module mbox;

import types::*;

int x ;
//Declare two mailboxes here
mailbox #(packet) exp_mb = new(1);
mailbox #(packet) act_mb = new(1);

// This task supplies stimulus to the two mailboxes
task stimulus();
  packet stim_pkt ;
  for (int i = 0; i < 256; i++) begin
    stim_pkt.pid <= i;
    //*** Write stim_pkt to both mailboxes here
    exp_mb.put(stim_pkt) ;
    act_mb.put(stim_pkt) ;
    $display("Sending pkt: ",i);
  end
endtask

// Add task checker here
task cheecker () ;
  packet exp , act ;
  for (int i = 0; i < 256; i++) begin
    exp_mb.get(exp) ;
    act_mb.get(act) ;
    if ( exp.pid < 3 ) 
      x <= compare (exp.pid , act.pid) ;
    else 
      $stop;
  end
endtask

// Add function compare here
function compare (int i , int j) ;
  if (i == j) begin
    $display("packets are the same ");
    return (1);
  end
  else begin
    $display("packets aren't the same ");
    return (0);
  end 
endfunction 
  
// Add an intial block to run stimulus & checker tasks simultaneously    
initial begin
fork 
stimulus() ;
cheecker () ;
join_none
#0 ;  
end

endmodule
