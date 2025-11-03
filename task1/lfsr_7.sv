module lfsr_7 (
    input   logic       clk,
    input   logic       rst,
    input   logic       en,
    output  logic [6:0] data_out
);

<<<<<<< HEAD
logic [6:0] sig;

always_ff @ (posedge clk, posedge rst)
    if(rst) sig <= 4'b1;
    else if(en) sig <= {data_out[5:0], data_out[6] ^ data_out[2]};

assign data_out = sig;

=======
logic [6:0] sreg;

always_ff @( posedge clk, posedge rst ) begin
    if(rst)
        sreg <= 7'b1;
    else if(en)
        sreg <= {sreg[5:0], sreg[6] ^ sreg[2]};
    
end
assign data_out = sreg;
>>>>>>> origin/main
endmodule
