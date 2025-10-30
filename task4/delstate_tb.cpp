#include "verilated.h"
#include "verilated_vcd_c.h"
#include "Vdelstate.h"

#include "../vbuddy.cpp" // include vbuddy code
#define MAX_SIM_CYC 100000

int main(int argc, char **argv, char **env)
{
    int simcyc;       // simulation clock count
    int tick;         // each clk cycle has two ticks for two edges
    int lights = 511; // state to toggle LED lights

    Verilated::commandArgs(argc, argv);
    // init top verilog instance
    Vdelstate *top = new Vdelstate;
    // init trace dump
    Verilated::traceEverOn(true);
    VerilatedVcdC *tfp = new VerilatedVcdC;
    top->trace(tfp, 99);
    tfp->open("delstate.vcd");

    // init Vbuddy
    if (vbdOpen() != 1)
        return (-1);
    vbdHeader("L3T2:Delay");
    vbdSetMode(1); // Flag mode set to one-shot

    // initialize simulation inputs
    top->clk = 1;
    top->rst = 0;
    top->en = 1;
    top->N = vbdValue();
    top->rst_l = 1;

    // run simulation for MAX_SIM_CYC clock cycles
    for (simcyc = 0; simcyc < MAX_SIM_CYC; simcyc++)
    {
        // dump variables into VCD file and toggle clock
        for (tick = 0; tick < 2; tick++)
        {
            std::cout << "dumping into tfp" << std::endl;
            top->clk = !top->clk;
            top->eval();
            tfp->dump(2 * simcyc + tick);
        }

        // Display toggle neopixel
        if (top->time_out)
        {
            vbdInitWatch();
        }
        // set up input signals of testbench
        std::cout << int(top->data_out) << std::endl;
        vbdBar(top->data_out & 0xFF);
        top->rst = (simcyc < 2); // assert reset for 1st cycle
        top->rst_l = 0;
        std::cout << "\n\n reset in top (from c++ tb) is set to: " << int(top->rst) << "\n\n"
                  << std::endl;
        top->en = 1;
        top->N = vbdValue();
        int time = vbdElapsed();
        vbdHex(4, (int(time) >> 16) & 0xF);
        vbdHex(3, (int(time) >> 8) & 0xF);
        vbdHex(2, (int(time) >> 4) & 0xF);
        vbdHex(1, int(time) & 0xF);
        vbdCycle(simcyc);

        if (Verilated::gotFinish() || vbdGetkey() == 'q')
            exit(0);
    }

    vbdClose(); // ++++
    tfp->close();
    exit(0);
}
