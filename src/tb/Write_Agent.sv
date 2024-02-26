class Write_Agent extends uvm_agent;
`uvm_component_utils(Write_Agent)
 write_drv wr_drv;
 write_sqr wr_sqr;
 `NEW

 function void build_phase(uvm_phase phase);
  super.build_phase(phase);
  wr_drv= write_drv::type_id::create("wr_drv",this);
  wr_sqr= write_sqr::type_id::create("wr_sqr",this);
 endfunction

 function void connect_phase(uvm_phase phase);
  wr_drv.seq_item_port.connect(wr_sqr.seq_item_export);
 endfunction



endclass
