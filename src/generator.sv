class generator;

  rand transcation trans;
  mailbox gtd;
  int repeat_count;
  event ended;
  int repeat_gen = 0;
 
  function new( mailbox gtd, event ended);
    this.gtd = gtd;
    this.ended = ended;  
  endfunction
  

  task write();
  int Temp1;
  int Temp2 = 1;
   repeat(repeat_count) begin
    repeat(512)begin  
    trans = new();
    Temp1 = (trans.randomize());
    if(Temp2==1) $display("[Generator] Brust_id=%d >>Data_In=%d",Temp2,trans.data_in);
    gtd.put(trans);
    repeat_gen++;
    end 
    Temp2 = Temp2+1; 
  end
   -> ended;
  #2055 $finish;
  endtask

endclass