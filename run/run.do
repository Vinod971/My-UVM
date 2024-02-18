if [file exists "work"] {vdel -all}
vlib work
vlog ../src/fifo_mem.sv
vlog ../src/rptr_handler_updated.sv
vlog ../src/synchronizer.sv
vlog ../src/wptr_handler.sv
vlog ../src/top.sv

vlog ../src/testbench.sv
#vsim -c -voptargs=+acc=npr async_fifo_TB
#vcd file async_fifo_TB.vcd
#vcd add -r async_fifo_TB/*

vopt async_fifo_TB -o async_fifo_TB_opt +acc +cover=sbfec
vsim async_fifo_TB_opt -coverage

set NoQuitOnFinish 1
onbreak {resume}
log /* -r
run -all


coverage save async_fifo_cov.ucdb
vcover report async_fifo_cov.ucdb 
vcover report async_fifo_cov.ucdb -cvg -details

quit