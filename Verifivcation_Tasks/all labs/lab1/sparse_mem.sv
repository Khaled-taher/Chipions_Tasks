module sparse_mem();
  
typedef enum {TRUE,FALSE} boolen ;    //define the boolean data type
typedef bit [0:31] index_bit ;     //define the 32 unsigned bit datatype 
boolen big_mem [index_bit] ;  //declare the big_mem associative array 
index_bit x ;

//write to big_mem using loops
initial begin  
for (int i = 1 ; i<25 ; i++) begin 
  x = $random ;
  big_mem [ x ] = TRUE  ;
end

//Display the following information about big_mem:
$display ("the numbers of entries with value true = %d " , big_mem.num() );                                  //How many entries it has with the value TRUE
$display ("the smallest index with value true = %p ", big_mem.find_first_index with (item == TRUE) );       //What is the smallest index with the value TRUE
$display ("the largest index with value true = %p ", big_mem.find_last_index with (item == TRUE) );        //What is the largest index with the value TRUE
$display ("the indexes of entries are = %P ", big_mem.find_index with (item == TRUE) );                   //The index value of all entries with the value TRUE
end

endmodule