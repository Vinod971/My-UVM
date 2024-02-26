class Read_Agent extends uvm_agent;
`uvm_component_utils(Read_Agent)
 `NEW
  read_drv rd_drv;
  read_sqr rd_sqr;

 function void build_phase(uvm_phase phase);
  super.build_phase(phase);
  rd_drv= read_drv::type_id::create("rd_drv",this);
  rd_sqr= read_sqr::type_id::create("rd_sqr",this);
 endfunction

 function void connect_phase(uvm_phase phase);
  rd_drv.seq_item_port.connect(rd_sqr.seq_item_export);
 endfunction


endclass