rm -rf obj_dir
rm -f Vdut.vcd

verilator -Wall --cc --trace f1_fsm.sv --exe f1_fsm_tb.cpp

make -j -C obj_dir/ -f Vf1_fsm.mk Vf1_fsm

ls /dev/ttyU* > vbuddy.cfg

obj_dir/Vf1_fsm
