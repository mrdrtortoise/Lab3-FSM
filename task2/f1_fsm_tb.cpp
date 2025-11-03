#include "Vf1_fsm.h"
#include "verilated.h"
#include "verilated_vcd_c.h"

#include "../vbuddy.cpp"
#define MAX_SYM_CYCLE 1000000

int main(int argc, char **argv, char **env)
{
    int symsyc;
    int clk;

    Verilated::commandArgs(argc, argv);

    // init top verilog instance
    Vf1_fsm *top = new Vf1_fsm;
    // init trace dump
    Verilated::traceEverOn(true);
    VerilatedVcdC *tfp = new VerilatedVcdC;
    top->trace(tfp, 99);
    tfp->open("Vdut.vcd");

    // init Vbuddy
    if (vbdOpen() != 1)
    {
        return -1;
    }
    vbdHeader("L3: F1");
    vbdSetMode(1);

    // init sim inputs
    top->en = 0;
    top->rst = 0;
    top->clk = 1;

    // run simulations for MAX_SYM_CYCLES
    for (symsyc = 0; symsyc < MAX_SYM_CYCLE; symsyc++)
    {
        // dump variables into tfp and toggle clk
        for (clk = 0; clk < 2; clk++)
        {
            tfp->dump(2 * symsyc + clk);
            top->clk = !top->clk;
            top->eval();
        }
        top->rst = symsyc < 2;
        top->en = vbdFlag();
        vbdBar(top->data_out & 0xFF);

        if (Verilated::gotFinish() || vbdGetkey() == 'q')
        {
            exit(0);
        }
    }
    vbdClose();
    tfp->close();
    exit(0);
}