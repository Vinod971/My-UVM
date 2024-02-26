if [file exists "work"] {vdel -all}
vlib work

#Compiling the RTL & Testbench Files
vlog -source -lint -sv +incdir+../src/rtl ../src/tb/testbench.sv

#Simulation
#vsim -c -voptargs=+acc=npr async_fifo_TB
#vcd file async_fifo_TB.vcd
#vcd add -r async_fifo_TB/*

vopt async_fifo_TB -o async_fifo_TB_Opt +acc +cover=sbfec
vsim async_fifo_TB_Opt -coverage +UVM_TESTNAME=Fifo_wr_rd

set NoQuitOnFinish 1
onbreak {resume}
log /* -r
run -all

coverage save async_fifo_TB_coverage.ucdb
#vcover report async_fifo_TB_coverage.ucdb
#vcover report async_fifo_TB_coverage.ucdb -cvg -details

quit