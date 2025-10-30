module f1_fsm (
    input   logic       rst,
    input   logic       en,
    input   logic       clk,
    output  logic [7:0] data_out,
    output  logic cmd_seq,
    output  logic cmd_delay
);


typedef enum {S0, S1, S2, S3, S4, S5, S6, S7, S8} my_state;
my_state current_state, next_state;

// state registers
always_ff @( posedge clk ) begin

    if(rst)
        current_state <= S0;
    else if(en) begin
        $display("current state: %0d", current_state);
        current_state <= next_state;
    end
end
// next state logic
always_comb
    case (current_state)
        S0: next_state = S1;
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
        S0:begin
            data_out = 8'b0;
            cmd_seq = 1'b1; // select the inut for the tick to come from clktick again
            cmd_delay = 1'b0; // set delay trigger to zero so delay goes IDLE
            $display("current state: S0");
            $display("data_out: %0d", data_out);
            $display("cmd_seq: %0d", cmd_seq);
            $display("cmd_delay: %0d", cmd_delay);
        end
        S1: begin
            data_out = 8'b1;
            cmd_seq = 1'b1; // for the rest until S8 we want to select clktick for determining f1-fsm en signal
            cmd_delay = 1'b0; // delay trigger is low until we reach S8
            $display("current state: S1");
            $display("data_out: %0d", data_out);
            $display("cmd_seq: %0d", cmd_seq);
            $display("cmd_delay: %0d", cmd_delay);
        end
        S2: begin
            data_out = 8'b11;
            cmd_seq = 1'b1;
            cmd_delay = 1'b0;
            $display("current state: S2");
            $display("data_out: %0d", data_out);
            $display("cmd_seq: %0d", cmd_seq);
            $display("cmd_delay: %0d", cmd_delay);
        end
        S3: begin
            data_out = 8'b111;
            cmd_seq = 1'b1;
            cmd_delay = 1'b0;
            $display("current state: S3");
            $display("data_out: %0d", data_out);
            $display("cmd_seq: %0d", cmd_seq);
            $display("cmd_delay: %0d", cmd_delay);
        end
        S4: begin
            data_out = 8'b1111;
            cmd_seq = 1'b1;
            cmd_delay = 1'b0;
            $display("current state: S4");
            $display("data_out: %0d", data_out);
            $display("cmd_seq: %0d", cmd_seq);
            $display("cmd_delay: %0d", cmd_delay);
        end
        S5: begin
            data_out = 8'b11111;
            cmd_seq = 1'b1;
            cmd_delay = 1'b0;
            $display("current state: S5");
            $display("data_out: %0d", data_out);
            $display("cmd_seq: %0d", cmd_seq);
            $display("cmd_delay: %0d", cmd_delay);
        end
        S6: begin
            data_out = 8'b111111;
            cmd_seq = 1'b1;
            cmd_delay = 1'b0;
            $display("current state: S6");
            $display("data_out: %0d", data_out);
            $display("cmd_seq: %0d", cmd_seq);
            $display("cmd_delay: %0d", cmd_delay);
        end
        S7: begin
            data_out = 8'b1111111;
            cmd_seq = 1'b1;
            cmd_delay = 1'b0;
            $display("current state: S7");
            $display("data_out: %0d", data_out);
            $display("cmd_seq: %0d", cmd_seq);
            $display("cmd_delay: %0d", cmd_delay);
        end
        S8: begin
            data_out = 8'b11111111;
            cmd_seq = 1'b0; // select the tick for the next state to come from the time out
            cmd_delay = 1'b1; //trigger the delay so it starts counting
            $display("current state: S8");
            $display("data_out: %0d", data_out);
            $display("cmd_seq: %0d", cmd_seq);
            $display("cmd_delay: %0d", cmd_delay);
        end
    endcase
endmodule
