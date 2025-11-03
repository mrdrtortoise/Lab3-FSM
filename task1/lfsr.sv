module lfsr(
    input   logic       clk,
    input   logic       rst,
    input   logic       en,
    output  logic [3:0] data_out
);

<<<<<<< HEAD
logic [3:0] sig;

always_ff @ (posedge clk, posedge rst)
    if(rst) 
        sig <= 4'b1;
    else if(en) 
        sig <= {sig[2:0], sig[3] ^ sig[2]};

assign data_out = sig;
=======
logic [3:0] sreg;

always_ff @(posedge clk, posedge rst) begin
    if(rst)
        sreg <= 4'b1;
    else if(en)
        sreg <= {sreg[2:0], sreg[3] ^ sreg[2]};
end
assign data_out = sreg;
>>>>>>> origin/main

endmodule
