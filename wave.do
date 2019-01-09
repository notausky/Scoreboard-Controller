onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /t_ScoreboardController/Done
add wave -noupdate /t_ScoreboardController/seg7_points_2
add wave -noupdate /t_ScoreboardController/seg7_points_1
add wave -noupdate /t_ScoreboardController/seg7_points_0
add wave -noupdate /t_ScoreboardController/seg7_timer_1
add wave -noupdate /t_ScoreboardController/seg7_timer_0
add wave -noupdate /t_ScoreboardController/seg7_level
add wave -noupdate /t_ScoreboardController/clk
add wave -noupdate /t_ScoreboardController/St
add wave -noupdate /t_ScoreboardController/Pt
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {650 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 288
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
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {839 ns}
