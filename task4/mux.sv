module mux (
    input logic     a,
    input logic     b,
    input logic     s,
    output logic    c
);

always_comb begin
    if(s == 1'b1) begin
        c = a;
    end
    else if(s == 1'b0) begin
        c = b;
    end
    else
        c = a;
end
    
endmodule
