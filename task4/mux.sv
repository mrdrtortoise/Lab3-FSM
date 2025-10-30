module mux (
    input logic tick,
    input logic time_out,
    input logic cmd_seq,
    output logic out
);

always_comb begin
    if(cmd_seq) begin
        $display("input set to one and mux output is %0d", tick);
        out = tick;
    end
    else begin
        $display("input set to zero and mux output is %0d", time_out);
        out = time_out;
    end
end
    
endmodule
