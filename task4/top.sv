module top (
    input logic         clk,
    input logic         rst,
    input logic         trigger,
    input logic [6:0]   n,
    output logic [7:0]  data_out,
    output logic        time_out
);

logic cmd_delay;
logic cmd_seq;
logic mux_out;
logic tick;
logic internal_timeout;
logic [6:0] lfsr_out;

lfsr_7 u_lfsr_7(
    .clk (clk),
    .rst (rst),
    .data_out (lfsr_out)
);

f1_fsm u_f1_fsm(
    .rst (rst),
    .en (mux_out),
    .clk (clk),
    .trigger (trigger),
    .cmd_seq (cmd_seq),
    .cmd_delay (cmd_delay),
    .data_out (data_out)
);

mux u_mux(
    .a (tick),
    .b (internal_timeout),
    .s (cmd_seq),
    .c (mux_out)
);

clktick u_clktick(
    .clk (clk),
    .rst (rst),
    .en (cmd_seq),
    .N (n),
    .tick (tick)
);

delay u_delay(
    .clk (clk),
    .rst (rst),
    .trigger (cmd_delay),
    .n (lfsr_out),
    .time_out (internal_timeout)
);

assign time_out = internal_timeout;

endmodule
