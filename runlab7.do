# Create work library
vlib work

# Compile Verilog
#     All Verilog files that are part of this design should have
#     their own "vlog" line below.
vlog "./lab7_implement_test.sv"
vlog "./tug_display7.sv"
vlog "./flipflop.sv"
vlog "./button_press.sv"
vlog "./seg7.sv"
vlog "./count_3.sv"
vlog "./comparator_10.sv"
vlog "./LFSR_10.sv"


# Call vsim to invoke simulator
#     Make sure the last item on the line is the name of the
#     testbench module you want to execute.
vsim -voptargs="+acc" -t 1ps -lib work lab7_implement_test_testbench

# Source the wave do file
#     This should be the file that sets up the signal window for
#     the module you are testing.
do lab7_implement_test_wave.do

# Set the window types
view wave
view structure
view signals

# Run the simulation
run -all

# End
