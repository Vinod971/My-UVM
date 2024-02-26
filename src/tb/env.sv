class Env extends uvm_env;

`uvm_component_utils(Env)
`NEW

 Write_Agent WR_Agent;
 Read_Agent RD_Agent; 

function void build_phase(uvm_phase phase);
  super.build_phase(phase);
  WR_Agent = Write_Agent::type_id::create("WR_Agent",this);
  RD_Agent = Read_Agent::type_id::create("RD_Agent",this);
endfunction

endclass
