class generator;

  rand transcation trans;
  mailbox gtd;
  int repeat_count;
  event dtg;

  function new( mailbox gtd, event dtg);
    this.gtd = gtd;
    this.dtg = dtg;  
  endfunction
  

  task write();
    int K;
   repeat(repeat_count) begin
    repeat(512)begin  
    trans = new();
    K = (trans.randomize());
    $display("[Generator] Data_In=%d",trans.data_in);
    gtd.put(trans);
   end 
  end

  #100000 $finish;
  endtask

endclass