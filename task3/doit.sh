rm -rf obj_dir
rm -f Vdelstate.vcd

verilator -Wall --cc --trace f1_fsm.sv delstate.sv clktick.sv --top-module delstate --exe clktick_tb.cpp

make -j -C obj_dir/ -f Vdelstate.mk Vdelstate

ls /dev/ttyU* > vbuddy.cfg

obj_dir/Vdelstate