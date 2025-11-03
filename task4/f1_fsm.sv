module f1_fsm (
    input   logic       rst,
    input   logic       en,
    input   logic       clk,
    input   logic       trigger,
    output  logic       cmd_seq,
    output  logic       cmd_delay,
    output  logic [7:0] data_out
);


typedef enum {S0, S1, S2, S3, S4, S5, S6, S7, S8} my_state;
my_state current_state, next_state;

// state registers
always_ff @( posedge clk ) begin
    if(rst)
        current_state <= S0;
    else if(en) begin
        $display("setting current state to next state (%d to %d)", current_state, next_state);
        current_state <= next_state;
    end
end
// next state logic
always_comb
    case (current_state)
        S0: if(trigger == 1'b1) next_state = S1;
        S1: next_state = S2;
        S2: next_state = S3;
        S3: next_state = S4;
        S4: next_state = S5;
        S5: next_state = S6;
        S6: next_state = S7;
        S7: next_state = S8;
        S8: next_state = S0;
    endcase

always_comb
    case(current_state)
        S0: begin
            cmd_delay = 0;
            cmd_seq = 1;
            data_out = 8'b0;
        end
        S1: begin
            cmd_delay = 0;
            cmd_seq = 1;
            data_out = 8'b1;
        end
        S2: begin
            cmd_delay = 0;
            cmd_seq = 1;
            data_out = 8'b11;
        end
        S3: begin
            cmd_delay = 0;
            cmd_seq = 1;
            data_out = 8'b111;
        end
        S4: begin
            cmd_delay = 0;
            cmd_seq = 1;
            data_out = 8'b1111;
        end
        S5: begin
            cmd_delay = 0;
            cmd_seq = 1;
            data_out = 8'b1_1111;
        end
        S6: begin
            cmd_delay = 0;
            cmd_seq = 1;
            data_out = 8'b11_1111;
        end
        S7: begin
            cmd_delay = 0;
            cmd_seq = 1;
            data_out = 8'b111_1111;
        end
        S8: begin
            cmd_delay = 1;
            cmd_seq = 0;
            data_out = 8'b1111_1111;
        end
        default: begin
                    cmd_delay = 0;
                    cmd_seq = 1;
                    next_state = S0;
        end
    endcase
endmodule
