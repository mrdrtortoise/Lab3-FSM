module lfsr(
    input   logic       clk,
    input   logic       rst,
    input   logic       en,
    output  logic [3:0] data_out
);

logic [3:0] sig;

always_ff @ (posedge clk, posedge rst)
    if(rst) 
        sig <= 4'b1;
    else if(en) 
        sig <= {sig[2:0], sig[3] ^ sig[2]};

assign data_out = sig;

endmodule
