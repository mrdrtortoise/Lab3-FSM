rm -rf obj_dir
rm -f Vtop.vcd

verilator -Wall --cc --trace clktick.sv delay.sv f1_fsm.sv lfsr_7.sv mux.sv top.sv --top-module top --exe top_tb.cpp

make -j -C obj_dir/ -f Vtop.mk Vtop

ls /dev/ttyU* > vbuddy.cfg

obj_dir/Vtop