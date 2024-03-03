class write_drv extends uvm_driver#(write_tx);
 `uvm_component_utils(write_drv)
 `NEW
 virtual interface_fifo inf;

 function void build_phase(uvm_phase phase);
 super.build_phase(phase);
 if(!uvm_resource_db#(virtual interface_fifo)::read_by_name("ALL","TB",inf,this))
 begin
 `uvm_error("WRITE_DRIVER","Problem with the interface")
 end
 
 endfunction

 task run_phase(uvm_phase phase);
  wait(inf.wrst_n == 1);
  forever begin 
	seq_item_port.get_next_item(req);
    drive_tx(req);
	// req.print();
    seq_item_port.item_done;
   end
 endtask

task drive_tx(write_tx tx);
		@(posedge inf.wclk);
		inf.w_en =1;
		inf.data_in = tx.data;
  `uvm_info("WRITE_DRIVER", $sformatf("Write_EN = %0d, Data_in = %2h", inf.w_en, tx.data), UVM_NONE)
endtask

endclass