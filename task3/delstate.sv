module delstate #(
    parameter WIDTH = 8
) (
    input logic en,
    input logic clk,
    input logic rst,
    input logic [15:0] N,
    output logic [WIDTH-1:0] data_out
);

logic tick;

clktick u_clktick(
    .clk (clk),
    .rst (rst),
    .en (en),
    .N (N),
    .tick(tick)
);

f1_fsm u_f1_fsm(
    .rst (rst),
    .en (tick),
    .clk (clk),
    .data_out (data_out)
);
    
endmodule
