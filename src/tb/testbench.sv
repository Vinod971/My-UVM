import uvm_pkg::*;
`include "uvm_macros.svh"
`include "top.sv"
`include "interface.sv"
`include "common.sv"
`include "Write_tx.sv"
`include "Write_driver.sv"
`include "Write_sqr.sv"
`include "Write_seq_lib.sv"
`include "Read_tx.sv"
`include "Read_driver.sv"
`include "Read_sqr.sv"
`include "Read_seq_lib.sv"
`include "Read_Agent.sv"
`include "Write_Agent.sv"
`include "env.sv"
`include "fifo_test_library.sv"
module async_fifo_TB;

 
 interface_fifo in();

 
 asynchronous_fifo as_fifo (.wclk(in.wclk),.wrst_n(in.wrst_n),.rclk(in.rclk),.rrst_n(in.rrst_n),
                            .w_en(in.w_en),.r_en(in.r_en),.data_in(in.data_in),.data_out(in.data_out),.full(in.full),.empty(in.empty),.write_error(in.write_error),
                            .read_error(in.read_error));


  always #2.083ns in.wclk = ~in.wclk;
  always #1.25ns in.rclk = ~in.rclk;

 initial begin
    in.wclk = 1;
    in.rclk = 1;
    in.wrst_n = 1'b0;
    in.w_en = 1'b0;
    in.data_in = 0;
    in.rclk = 1'b0; 
    in.rrst_n = 1'b0;
    in.r_en = 1'b0; 
    repeat(2) @(posedge in.wclk);
    in.wrst_n = 1'b1;
    in.rrst_n = 1'b1;
 end 

initial begin 
				uvm_resource_db#(virtual interface_fifo)::set("ALL","TB",in,null);
end

initial begin
				run_test();
end

endmodule
