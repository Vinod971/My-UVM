class Env extends uvm_env;

`uvm_component_utils(Env)
`NEW

 Write_Agent WR_Agent;
 Read_Agent RD_Agent; 
 async_scoreboard Sc_rd;

function void build_phase(uvm_phase phase);
  super.build_phase(phase);
  WR_Agent = Write_Agent::type_id::create("WR_Agent",this); 
  RD_Agent = Read_Agent::type_id::create("RD_Agent",this);
  Sc_rd   =  async_scoreboard::type_id::create("Sc_rd",this);
endfunction

function void connect_phase(uvm_phase phase);
  WR_Agent.wr_mon.ap_port.connect(Sc_rd.ap_imp_wr);	//Connecting Write Monitor and Scoreboard
  RD_Agent.rd_mon.ap_port.connect(Sc_rd.ap_imp_rd); //Connectiong Read Monitor and Scoreboard

endfunction

endclass
