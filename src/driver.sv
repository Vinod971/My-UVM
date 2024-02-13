class driver;
  
  virtual interface_fifo in;
  
  mailbox gtd;
  mailbox dtg;
  int no_trans;
  
  function new (virtual interface_fifo in,mailbox gtd);
    this.in = in;
    this.gtd = gtd;
  endfunction
    
    task reset();
    in.wclk = 1'b0; in.wrst_n = 1'b0;
    in.w_en = 1'b0;
    in.data_in = 0;
    in.rclk = 1'b0; in.rrst_n = 1'b0;
    in.r_en = 1'b0;
    
    repeat(10) @(posedge in.wclk);
    in.wrst_n = 1'b1;
    in.rrst_n = 1'b1;
    in.w_en =1'b1;
    endtask :reset
    
     task write_read();

    fork
     forever begin
          transcation trans;
          trans = new();
          gtd.get(trans);
          in.w_en =1'b1;
          in.r_en= 1'b1;
          in.data_in = trans.data_in;
          @(posedge in.wclk);
          $display("[Driver] w_en=%d data_in=%d r_en=%d read_data=%d",in.w_en,in.data_in,in.r_en,in.data_out);
      end
    join
    endtask
    
endclass 