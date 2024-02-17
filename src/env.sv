`include "transcation.sv"
`include "generator.sv"
`include "driver.sv"


class environment;

  generator gen;
  driver drv;
  mailbox gtd;
  event dtg;

 virtual interface_fifo in;

 function new(virtual interface_fifo in);

    this.in = in;
   endfunction
    
    task build();
    gtd = new();
    gen = new(gtd,dtg);
    drv = new(in,gtd);
   endtask

  task pre_test();
   drv.reset();
  endtask

  
   task write();
    fork
    gen.write();
    drv.write_read();
    join
   endtask


endclass