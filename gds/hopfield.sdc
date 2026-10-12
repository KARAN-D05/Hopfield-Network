create_clock -name clock -period 25 [get_ports clk]
set_input_delay 1.0 -clock clock [get_ports {start initial_state[*]}]
set_output_delay 1.0 -clock clock [get_ports {final_state[*] busy  done converged}]
