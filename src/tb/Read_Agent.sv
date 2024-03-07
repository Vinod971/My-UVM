class Read_Agent extends uvm_agent;
`uvm_component_utils(Read_Agent)
 `NEW
  read_drv rd_drv;
  read_sqr rd_sqr;
  read_mon rd_mon;
  read_cov rd_cov;

 function void build_phase(uvm_phase phase);
  super.build_phase(phase);
  rd_drv= read_drv::type_id::create("rd_drv",this);
  rd_sqr= read_sqr::type_id::create("rd_sqr",this);
  rd_mon= read_mon::type_id::create("rd_mon",this);
  rd_cov= read_cov::type_id::create("rd_cov",this);
 endfunction

 function void connect_phase(uvm_phase phase);
  rd_drv.seq_item_port.connect(rd_sqr.seq_item_export); // Read Driver to Read Sequencer
  rd_mon.ap_port.connect(rd_cov.analysis_export); // Read Monitor to Read Coverage
 endfunction


endclass