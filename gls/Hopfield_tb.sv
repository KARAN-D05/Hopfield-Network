`timescale 1ns/1ns

module testbench;

    reg clk;
    reg rst_n;
    reg start;
    reg [3:0] initial_state;

    wire [3:0] final_state;
    wire busy;
    wire done;
    wire converged;

    integer test_count;
    integer pass_count;
    integer fail_count;

    integer cycles;
    integer finished;
    integer errors_before;

    hopfield_network dut (
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


    task automatic run_test(
        input logic [3:0] test_input,
        input logic [3:0] expected_output
    );

        begin

            test_count = test_count + 1;
            errors_before = fail_count;

            @(negedge clk);
            initial_state = test_input;
            start = 1'b1;

            @(negedge clk);
            start = 1'b0;

            cycles = 0;
            finished = 0;

            while ((cycles < (4 * 16 + 5)) && (finished == 0)) begin
                if (done === 1'b1) begin
                    finished = 1;
                end else begin
                    @(negedge clk);
                    cycles = cycles + 1;
                end
            end

            if (finished == 0) begin
                $display("FAIL | Input=%b | Timeout", test_input);
                fail_count = fail_count + 1;
            end else if (busy !== 1'b0) begin
                $display( "FAIL | Input=%b | Busy still high", test_input);
                fail_count = fail_count + 1;
            end else if (converged !== 1'b1) begin
                $display("FAIL | Input=%b | No convergence | Final=%b", test_input, final_state);
                fail_count = fail_count + 1;
            end else if (final_state !== expected_output) begin
                $display("FAIL | Input=%b | Expected=%b | Actual=%b", test_input, expected_output, final_state);
                fail_count = fail_count + 1;
            end else begin
                $display("PASS | Input=%b | Expected=%b | Actual=%b | Cycles=%0d", test_input, expected_output, final_state, cycles);
                pass_count = pass_count + 1;
            end

            @(posedge clk);
            #1;

            if (done !== 1'b0) begin
                $display("FAIL | Input=%b | done did not return low", test_input);
                fail_count = fail_count + 1;
            end
        end
    endtask

    initial begin

        $dumpfile("Sim.vcd");
        $dumpvars(0, testbench);

        $monitor("t=%0t | input=%b | state=%b | busy=%b | done=%b | converged=%b",$time, initial_state, final_state,busy, done, converged);

        rst_n = 1'b0;
        start = 1'b0;
        initial_state = '0;

        test_count = 0;
        pass_count = 0;
        fail_count = 0;

        repeat (2) @(negedge clk);
        rst_n = 1'b1;

        run_test(4'b0000, 4'b0001);
        run_test(4'b0001, 4'b0001);
        run_test(4'b0010, 4'b1110);
        run_test(4'b0011, 4'b0001);

        run_test(4'b0100, 4'b1110);
        run_test(4'b0101, 4'b0001);
        run_test(4'b0110, 4'b1110);
        run_test(4'b0111, 4'b1110);

        run_test(4'b1000, 4'b0001);
        run_test(4'b1001, 4'b0001);
        run_test(4'b1010, 4'b1110);
        run_test(4'b1011, 4'b0001);

        run_test(4'b1100, 4'b1110);
        run_test(4'b1101, 4'b0001);
        run_test(4'b1110, 4'b1110);
        run_test(4'b1111, 4'b1110);

        $display("");
        $display("======================================");
        $display("       SIMULATION SUMMARY");
        $display("======================================");
        $display("Total tests : %0d", test_count);
        $display("Passed      : %0d", pass_count);
        $display("Failed      : %0d", fail_count);
        $display("======================================");

        if (fail_count == 0)
            $display("ALL TESTS PASSED");
        else
            $display("SOME TESTS FAILED");

        $display("Simulation Complete!");

        $finish;

    end

endmodule
