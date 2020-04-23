onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -group {P1 DFF1} /lab6_implement_testbench/dut/p1_raw/D
add wave -noupdate -group {P1 DFF1} /lab6_implement_testbench/dut/p1_raw/Q
add wave -noupdate -group {P1 DFF2} /lab6_implement_testbench/dut/p1_stable/D
add wave -noupdate -group {P1 DFF2} /lab6_implement_testbench/dut/p1_stable/Q
add wave -noupdate -group {P1 BTN[1]} /lab6_implement_testbench/dut/p1_input/in
add wave -noupdate -group {P1 BTN[1]} /lab6_implement_testbench/dut/p1_input/out
add wave -noupdate -group {P2 DFF1} /lab6_implement_testbench/dut/p2_raw/D
add wave -noupdate -group {P2 DFF1} /lab6_implement_testbench/dut/p2_raw/Q
add wave -noupdate -group {P2 DFF2} /lab6_implement_testbench/dut/p2_stable/D
add wave -noupdate -group {P2 DFF2} /lab6_implement_testbench/dut/p2_stable/Q
add wave -noupdate -group {P2 BTN[1]} /lab6_implement_testbench/dut/p2_input/in
add wave -noupdate -group {P2 BTN[1]} /lab6_implement_testbench/dut/p2_input/out
add wave -noupdate -group {GAME[1]} /lab6_implement_testbench/dut/game/reset
add wave -noupdate -group {GAME[1]} /lab6_implement_testbench/dut/game/p1
add wave -noupdate -group {GAME[1]} /lab6_implement_testbench/dut/game/p2
add wave -noupdate -group {GAME[1]} /lab6_implement_testbench/dut/game/lights
add wave -noupdate -group {GAME[1]} /lab6_implement_testbench/dut/game/bcd
add wave -noupdate -group {GAME[1]} /lab6_implement_testbench/dut/game/ps
add wave -noupdate -group {GAME[1]} /lab6_implement_testbench/dut/game/ns
add wave -noupdate -group HEX -expand /lab6_implement_testbench/dut/hex_driver/bcd
add wave -noupdate -group HEX /lab6_implement_testbench/dut/hex_driver/leds
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {682 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 177
configure wave -valuecolwidth 40
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {5817 ps}
