if [file exists "work"] {vdel -all}
vlib work
vlog ../src/fifo_mem.sv
vlog ../src/rptr_handler_updated.sv
vlog ../src/synchronizer.sv
vlog ../src/wptr_handler.sv
vlog ../src/top.sv

vlog ../src/testbench.sv
vsim -c -voptargs=+acc=npr async_fifo_TB
vcd file async_fifo_TB.vcd
vcd add -r async_fifo_TB/*
run -all
quit