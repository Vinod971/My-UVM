class fifo_test_library extends uvm_test;
 `uvm_component_utils(fifo_test_library)
 `NEW
  Env env;

 function void build_phase(uvm_phase phase);
  super.build_phase(phase);
  env= Env::type_id::create("env",this);
 endfunction

 function void end_of_elaboration_phase(uvm_phase phase);
  uvm_top.print_topology();
 endfunction

endclass

class Fifo_wr_rd extends fifo_test_library;
 	`uvm_component_utils(Fifo_wr_rd)
	`NEW
	function void build_phase(uvm_phase phase);
	 super.build_phase(phase);
     uvm_resource_db#(int)::set("GOBAL","GEN",256,this);
	endfunction


 task run_phase(uvm_phase phase);
   write_seq wr_seq;
	 read_seq rd_seq;
 		wr_seq= write_seq::type_id::create("wr_seq",this);
 		rd_seq= read_seq::type_id::create("rd_seq",this);
	 
	   phase.raise_objection(this);
	   phase.phase_done.set_drain_time(this,100);
	    wr_seq.start(env.WR_Agent.wr_sqr);
	    rd_seq.start(env.RD_Agent.rd_sqr);
     phase.drop_objection(this);
	endtask

endclass


class fifo_full extends fifo_test_library;
 	`uvm_component_utils(fifo_full)
	`NEW
	function void build_phase(uvm_phase phase);
	 super.build_phase(phase);
   uvm_resource_db#(int)::set("GOBAL","GEN",17,this);
	endfunction


 task run_phase(uvm_phase phase);
   write_seq wr_seq;
 		wr_seq= write_seq::type_id::create("wr_seq",this);
 			 
	   phase.raise_objection(this);
	   phase.phase_done.set_drain_time(this,100);
	   wr_seq.start(env.WR_Agent.wr_sqr);
     phase.drop_objection(this);
	endtask

endclass

class Fifo_Full_and_Empty extends fifo_test_library;
 	`uvm_component_utils(Fifo_Full_and_Empty)
	`NEW
	function void build_phase(uvm_phase phase);
	 super.build_phase(phase);
   uvm_resource_db#(int)::set("GOBAL","GEN",258,this);
  uvm_resource_db#(int)::set("GOBAL","GEN2",520,this);
	endfunction


 task run_phase(uvm_phase phase);
   write_seq wr_seq;
	 read_seq rd_seq;
 		wr_seq= write_seq::type_id::create("wr_seq",this);
 		rd_seq= read_seq::type_id::create("rd_seq",this);
	 
	   phase.raise_objection(this);
	   phase.phase_done.set_drain_time(this,100);
	    wr_seq.start(env.WR_Agent.wr_sqr);
	    rd_seq.start(env.RD_Agent.rd_sqr);
     phase.drop_objection(this);
	endtask

endclass

class Concurrent_wr_rd_test  extends fifo_test_library;
 	`uvm_component_utils(Concurrent_wr_rd_test )
	`NEW
	function void build_phase(uvm_phase phase);
	 super.build_phase(phase);
   uvm_resource_db#(int)::set("GOBAL","GEN",512,this);
   uvm_resource_db#(int)::set("GOBAL","GEN2",512,this);
	endfunction


 task run_phase(uvm_phase phase);
   write_seq wr_seq;
	 read_seq rd_seq;
 		wr_seq= write_seq::type_id::create("wr_seq",this);
 		rd_seq= read_seq::type_id::create("rd_seq",this);
	 
	   phase.raise_objection(this);
	   phase.phase_done.set_drain_time(this,100);
		 fork
	    wr_seq.start(env.WR_Agent.wr_sqr);
	    rd_seq.start(env.RD_Agent.rd_sqr);
		 join
     phase.drop_objection(this);
	endtask

endclass
