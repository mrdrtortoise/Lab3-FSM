module delstate #(
    parameter WIDTH = 8
) (
    input logic rst_l,
    input logic en,
    input logic clk,
    input logic rst,
    input logic [4:0] N,
    output logic [WIDTH-1:0] data_out,
    output logic time_out
);

logic tick;
logic cmd_seq;
logic cmd_delay;
logic mux_out;
logic delay_out;
logic [6:0] gen;

clktick u_clktick(
    .clk (clk),
    .rst (rst),
    .en (en),
    .N (N),
    .tick(tick)
);

lfsr_7 u_lfsr_7(
    .clk (clk),
    .rst_l (rst_l),
    .en (en),
    .data_out (gen)
);

delay u_delay(
    .clk (clk),
    .rst (rst),
    .trigger (cmd_delay),
    .n (gen),
    .time_out (delay_out)
);

mux u_mux(
    .tick (tick),
    .time_out (delay_out),
    .cmd_seq (cmd_seq),
    .out (mux_out)
);

f1_fsm u_f1_fsm(
    .rst (rst),
    .en (mux_out),
    .clk (clk),
    .data_out (data_out),
    .cmd_delay (cmd_delay),
    .cmd_seq (cmd_seq)
);

assign time_out = delay_out;
    
endmodule
