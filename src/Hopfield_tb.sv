`timescale 1ns/1ns
`include "Hopfield.sv"

module testbench;

    parameter N = 25;
    parameter MAX_PASSES = 16;

    reg clk, rst_n, start;
    reg [N-1:0] initial_state;

    wire [N-1:0] final_state;
    wire busy, done, converged;

    integer test_count, pass_count, fail_count;
    integer cycles, finished;

    localparam [N-1:0] STORED_PATTERN = 25'b01001_01010_01100_01010_01001;

    hopfield_network #(
        .N(N),
        .MAX_PASSES(MAX_PASSES)
    ) dut (
        .clk(clk),
        .rst_n(rst_n),
        .start(start),
        .initial_state(initial_state),
        .final_state(final_state),
        .busy(busy),
        .done(done),
        .converged(converged)
    );

    initial clk = 0;
    always #5 clk = ~clk;

    always @(dut.state_reg) begin
        if (rst_n && busy) begin
            $display("Time= %0t | State: %b", $time, dut.state_reg
            );
        end
    end

    task automatic run_test(
        input logic [N-1:0] test_input,
        input logic [N-1:0] expected_output
    );

        begin
            test_count++;

            $display("\n----------------------------------------");
            $display("TEST %0d", test_count);
            $display("Input    : %b", test_input);
            $display("Expected : %b", expected_output);
            $display("----------------------------------------");

            @(negedge clk);
            initial_state = test_input;
            start = 1;

            @(negedge clk);
            start = 0;

            cycles = 0;
            finished = 0;

            while (!done && cycles < N*MAX_PASSES + 5) begin
                @(posedge clk);
                #1;
                cycles++;
            end

            if (done)
                finished = 1;

            if (finished && !busy && converged && final_state === expected_output) begin
                $display("RESULT   : PASS");
                $display("Final    : %b", final_state);
                $display("Cycles   : %0d", cycles);
                pass_count++;

            end else begin

                $display("RESULT   : FAIL");
                $display("Final    : %b", final_state);
                $display("Expected : %b", expected_output);
                $display("Busy     : %b", busy);
                $display("Done     : %b", done);
                $display("Converged: %b", converged);
                $display("Cycles   : %0d", cycles);

                fail_count++;

            end

            @(posedge clk);
            #1;

            if (done !== 1'b0)
                $display("WARNING: done did not return low.");

        end

    endtask

    initial begin

        $dumpfile("Sim.vcd");
        $dumpvars(0, testbench);

        rst_n = 0;
        start = 0;
        initial_state = '0;

        test_count = 0;
        pass_count = 0;
        fail_count = 0;

        cycles = 0;
        finished = 0;

        repeat (2) @(negedge clk);
        rst_n = 1;

        run_test(25'b01001_01000_01100_01010_00001, STORED_PATTERN);
        run_test(25'b01001_01010_01100_01010_01000, STORED_PATTERN);
        run_test(25'b01001_01010_00100_01010_01001, STORED_PATTERN);
        run_test(25'b01001_00010_01100_01010_01000, STORED_PATTERN);
        run_test(25'b00001_01000_01100_00010_01001, STORED_PATTERN);
        run_test(25'b11001_01010_01100_01010_01001, STORED_PATTERN);
        run_test(25'b00000_01010_01100_01010_01001, STORED_PATTERN);
        run_test(25'b01101_01110_01110_01010_01001, STORED_PATTERN);
        run_test(25'b01001_11010_11100_01010_01001, STORED_PATTERN);
        run_test(25'b01011_01000_01100_01110_01001, STORED_PATTERN);
        run_test(25'b11101_11011_01100_01010_01001, STORED_PATTERN);
        run_test(25'b00000_01000_01000_01010_11001, STORED_PATTERN);
        run_test(25'b01011_00010_11101_01000_01011, STORED_PATTERN);
        run_test(25'b11000_01110_00100_00010_01001, STORED_PATTERN);
        run_test(25'b01101_11011_01110_01110_00001, STORED_PATTERN);
        run_test(25'b10011_00010_11101_01011_01001, STORED_PATTERN);
        run_test(25'b00000_01110_00100_11000_01100, STORED_PATTERN);
        run_test(25'b11101_11000_01000_00010_11011, STORED_PATTERN);
        run_test(25'b00011_00011_01000_11000_00000, STORED_PATTERN);
        run_test(25'b11100_00000_11001_00000_01001, STORED_PATTERN);

        $display("\n========================================");
        $display("           SIMULATION SUMMARY");
        $display("========================================");
        $display("Total tests : %0d", test_count);
        $display("Passed      : %0d", pass_count);
        $display("Failed      : %0d", fail_count);
        $display("========================================");

        $finish;

    end

endmodule
