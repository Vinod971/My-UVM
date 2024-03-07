if [file exists "work"] {vdel -all}
vlib work

#Compiling the RTL & Testbench Files
vlog -source -lint -sv +incdir+../src/rtl ../src/tb/testbench.sv

vopt async_fifo_TB -o async_fifo_TB_Opt +acc +cover=sbfec
vsim async_fifo_TB_Opt -coverage +UVM_TESTNAME=Fifo_wr
vcd file async_fifo_TB.vcd
vcd add -r async_fifo_TB/*

set NoQuitOnFinish 1
onbreak {resume}
log /* -r
run -all

coverage save Fifo_wr.ucdb
quit -sim

vopt async_fifo_TB -o async_fifo_TB_Opt +acc +cover=sbfec
vsim async_fifo_TB_Opt -coverage +UVM_TESTNAME=Fifo_rd

set NoQuitOnFinish 1
onbreak {resume}
log /* -r
run -all

coverage save Fifo_rd.ucdb
quit -sim

vopt async_fifo_TB -o async_fifo_TB_Opt +acc +cover=sbfec
vsim async_fifo_TB_Opt -coverage +UVM_TESTNAME=Fifo_wr_rd

set NoQuitOnFinish 1
onbreak {resume}
log /* -r
run -all

coverage save Fifo_wr_rd.ucdb
quit -sim

vopt async_fifo_TB -o async_fifo_TB_Opt +acc +cover=sbfec
vsim async_fifo_TB_Opt -coverage +UVM_TESTNAME=fifo_full

set NoQuitOnFinish 1
onbreak {resume}
log /* -r
run -all

coverage save fifo_full.ucdb
quit -sim

vopt async_fifo_TB -o async_fifo_TB_Opt +acc +cover=sbfec
vsim async_fifo_TB_Opt -coverage +UVM_TESTNAME=Fifo_Full_and_Empty

set NoQuitOnFinish 1
onbreak {resume}
log /* -r
run -all

coverage save Fifo_Full_and_Empty.ucdb
quit -sim

vopt async_fifo_TB -o async_fifo_TB_Opt +acc +cover=sbfec
vsim async_fifo_TB_Opt -coverage +UVM_TESTNAME=Concurrent_wr_rd_test

set NoQuitOnFinish 1
onbreak {resume}
log /* -r
run -all

coverage save Concurrent_wr_rd_test.ucdb
vcover merge output.ucdb Fifo_wr.ucdb Fifo_rd.ucdb Fifo_wr_rd.ucdb fifo_full.ucdb Fifo_Full_and_Empty.ucdb Concurrent_wr_rd_test.ucdb
#vcover report output.ucdb
vcover report output.ucdb -cvg -details

quit