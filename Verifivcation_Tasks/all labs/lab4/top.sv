module top();
  
import types_pkg::*;

env test_env = new();  

initial begin
test_env.connect();
test_env.run();
end
     
endmodule
