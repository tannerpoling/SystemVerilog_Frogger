onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /update_cars_testbench/car2
add wave -noupdate /update_cars_testbench/car5
add wave -noupdate /update_cars_testbench/car7
add wave -noupdate /update_cars_testbench/car9
add wave -noupdate /update_cars_testbench/car11
add wave -noupdate /update_cars_testbench/car12
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
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
WaveRestoreZoom {0 ps} {718 ps}
