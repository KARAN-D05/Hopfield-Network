module hopfield_network #(
    parameter int N = 25,
    parameter int MAX_PASSES = 16
) (
    input  logic         clk,
    input  logic         rst_n,
    input  logic         start,
    input  logic [N-1:0] initial_state,
    output logic [N-1:0] final_state,
    output logic         busy,
    output logic         done,
    output logic         converged
);

    logic signed [7:0] weights [0:N-1][0:N-1];

    initial begin
     $readmemh("weights.mem", weights);
    end

    logic [N-1:0] state_reg;
    localparam int IDX_W = (N <= 1) ? 1 : $clog2(N);

    logic [IDX_W-1:0] neuron_idx;
    localparam int PASS_W = (MAX_PASSES <= 1) ? 1 : $clog2(MAX_PASSES);

    logic [PASS_W-1:0] pass_count;

    logic pass_changed;
    integer signed total_input;
    logic next_neuron_state;

    always_comb begin
        total_input = 0;
        next_neuron_state = state_reg[N-1-neuron_idx];

        for (int i = 0; i < N; i++) begin
            if (state_reg[N-1-i] == 1'b1) begin
                total_input = total_input + $signed(weights[neuron_idx][i]);
            end else begin
                total_input = total_input - $signed(weights[neuron_idx][i]);
            end
        end

        if (total_input > 0) begin
            next_neuron_state = 1'b1;
        end else if (total_input < 0) begin
            next_neuron_state = 1'b0;
        end
    end

    assign final_state = state_reg;

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state_reg    <= '0;
            neuron_idx   <= '0;
            pass_count   <= '0;
            pass_changed <= 1'b0;
            busy         <= 1'b0;
            done         <= 1'b0;
            converged    <= 1'b0;
        end else begin
            done <= 1'b0;

            if (start && !busy) begin
                state_reg    <= initial_state;
                neuron_idx   <= '0;
                pass_count   <= '0;
                pass_changed <= 1'b0;
                busy         <= 1'b1;
                converged    <= 1'b0;
            end else if (busy) begin
                state_reg[N-1-neuron_idx] <= next_neuron_state;

                if (next_neuron_state != state_reg[N-1-neuron_idx])
                    pass_changed <= 1'b1;

                if (neuron_idx == N-1) begin
                    if (!(pass_changed ||
                          (next_neuron_state != state_reg[N-1-neuron_idx]))) begin
                        busy      <= 1'b0;
                        done      <= 1'b1;
                        converged <= 1'b1;
                    end else if (pass_count == MAX_PASSES-1) begin
                        busy      <= 1'b0;
                        done      <= 1'b1;
                        converged <= 1'b0;
                    end else begin
                        neuron_idx   <= '0;
                        pass_count   <= pass_count + 1'b1;
                        pass_changed <= 1'b0;
                    end
                end else begin
                    neuron_idx <= neuron_idx + 1'b1;
                end
            end
        end
    end
endmodule
