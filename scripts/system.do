onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /system_tb/CLK
add wave -noupdate /system_tb/nRST
add wave -noupdate -group Datapath /system_tb/DUT/CPU/DP/dpif/ihit
add wave -noupdate -group Datapath /system_tb/DUT/CPU/DP/dpif/imemload
add wave -noupdate -group Datapath /system_tb/DUT/CPU/DP/dpif/dhit
add wave -noupdate -group Datapath /system_tb/DUT/CPU/DP/dpif/dmemload
add wave -noupdate -group Datapath -divider Outputs
add wave -noupdate -group Datapath /system_tb/DUT/CPU/DP/CU/opcode
add wave -noupdate -group Datapath /system_tb/DUT/CPU/DP/CU/rtype
add wave -noupdate -group Datapath /system_tb/DUT/CPU/DP/dpif/halt
add wave -noupdate -group Datapath /system_tb/DUT/CPU/DP/dpif/imemREN
add wave -noupdate -group Datapath /system_tb/DUT/CPU/DP/dpif/imemaddr
add wave -noupdate -group Datapath /system_tb/DUT/CPU/DP/dpif/dmemREN
add wave -noupdate -group Datapath /system_tb/DUT/CPU/DP/dpif/dmemWEN
add wave -noupdate -group Datapath /system_tb/DUT/CPU/DP/dpif/flushed
add wave -noupdate -group Datapath /system_tb/DUT/CPU/DP/dpif/dmemstore
add wave -noupdate -group Datapath /system_tb/DUT/CPU/DP/dpif/dmemaddr
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP/cuif/halt
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP/cuif/instruction
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP/cuif/dwen
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP/cuif/dren
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP/cuif/aluOp
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP/cuif/aluSrc
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP/cuif/memToRegSel
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP/cuif/extndOp
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP/cuif/imm
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP/cuif/shamt
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP/cuif/instrType
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP/cuif/rd
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP/cuif/rs
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP/cuif/rt
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP/cuif/wen
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP/cuif/pcSel
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP/cuif/jump
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP/cuif/branchEnable
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP/cuif/branchSel
add wave -noupdate -group ccif /system_tb/DUT/CPU/ccif/iwait
add wave -noupdate -group ccif /system_tb/DUT/CPU/ccif/dwait
add wave -noupdate -group ccif /system_tb/DUT/CPU/ccif/iREN
add wave -noupdate -group ccif /system_tb/DUT/CPU/ccif/dREN
add wave -noupdate -group ccif /system_tb/DUT/CPU/ccif/dWEN
add wave -noupdate -group ccif /system_tb/DUT/CPU/ccif/iload
add wave -noupdate -group ccif /system_tb/DUT/CPU/ccif/dload
add wave -noupdate -group ccif /system_tb/DUT/CPU/ccif/dstore
add wave -noupdate -group ccif /system_tb/DUT/CPU/ccif/iaddr
add wave -noupdate -group ccif /system_tb/DUT/CPU/ccif/daddr
add wave -noupdate -group ccif /system_tb/DUT/CPU/ccif/ramWEN
add wave -noupdate -group ccif /system_tb/DUT/CPU/ccif/ramREN
add wave -noupdate -group ccif /system_tb/DUT/CPU/ccif/ramstate
add wave -noupdate -group ccif /system_tb/DUT/CPU/ccif/ramaddr
add wave -noupdate -group ccif /system_tb/DUT/CPU/ccif/ramstore
add wave -noupdate -group ccif /system_tb/DUT/CPU/ccif/ramload
add wave -noupdate -group Alu /system_tb/DUT/CPU/DP/aluif/z_flag
add wave -noupdate -group Alu /system_tb/DUT/CPU/DP/aluif/n_flag
add wave -noupdate -group Alu /system_tb/DUT/CPU/DP/aluif/v_flag
add wave -noupdate -group Alu /system_tb/DUT/CPU/DP/aluif/aluop
add wave -noupdate -group Alu /system_tb/DUT/CPU/DP/aluif/porta
add wave -noupdate -group Alu /system_tb/DUT/CPU/DP/aluif/portb
add wave -noupdate -group Alu /system_tb/DUT/CPU/DP/aluif/porto
add wave -noupdate -group {Program Counter} /system_tb/DUT/CPU/DP/pcif/updatePC
add wave -noupdate -group {Program Counter} /system_tb/DUT/CPU/DP/pcif/pcSel
add wave -noupdate -group {Program Counter} /system_tb/DUT/CPU/DP/pcif/npc
add wave -noupdate -group {Program Counter} /system_tb/DUT/CPU/DP/pcif/pc
add wave -noupdate -group {Program Counter} /system_tb/DUT/CPU/DP/pcif/rdat1
add wave -noupdate -group {Program Counter} /system_tb/DUT/CPU/DP/pcif/jump
add wave -noupdate -group {Register File} /system_tb/DUT/CPU/DP/RF/rfif/WEN
add wave -noupdate -group {Register File} /system_tb/DUT/CPU/DP/RF/rfif/wsel
add wave -noupdate -group {Register File} /system_tb/DUT/CPU/DP/RF/rfif/rsel1
add wave -noupdate -group {Register File} /system_tb/DUT/CPU/DP/RF/rfif/rsel2
add wave -noupdate -group {Register File} /system_tb/DUT/CPU/DP/RF/rfif/wdat
add wave -noupdate -group {Register File} /system_tb/DUT/CPU/DP/RF/rfif/rdat1
add wave -noupdate -group {Register File} /system_tb/DUT/CPU/DP/RF/rfif/rdat2
add wave -noupdate -group {Register File} /system_tb/DUT/CPU/DP/RF/register
add wave -noupdate -group {Request Unit} /system_tb/DUT/CPU/DP/RU/ruif/ihit
add wave -noupdate -group {Request Unit} /system_tb/DUT/CPU/DP/RU/ruif/dhit
add wave -noupdate -group {Request Unit} /system_tb/DUT/CPU/DP/RU/ruif/CUdren
add wave -noupdate -group {Request Unit} /system_tb/DUT/CPU/DP/RU/ruif/CUdwen
add wave -noupdate -group {Request Unit} /system_tb/DUT/CPU/DP/RU/ruif/CUhalt
add wave -noupdate -group {Request Unit} /system_tb/DUT/CPU/DP/RU/ruif/updatePC
add wave -noupdate -group {Request Unit} /system_tb/DUT/CPU/DP/RU/ruif/iren
add wave -noupdate -group {Request Unit} /system_tb/DUT/CPU/DP/RU/ruif/dwen
add wave -noupdate -group {Request Unit} /system_tb/DUT/CPU/DP/RU/ruif/dren
add wave -noupdate -group RAM /system_tb/DUT/RAM/ramif/ramREN
add wave -noupdate -group RAM /system_tb/DUT/RAM/ramif/ramWEN
add wave -noupdate -group RAM /system_tb/DUT/RAM/ramif/ramaddr
add wave -noupdate -group RAM /system_tb/DUT/RAM/ramif/ramstore
add wave -noupdate -group RAM /system_tb/DUT/RAM/ramif/ramload
add wave -noupdate -group RAM /system_tb/DUT/RAM/ramif/ramstate
add wave -noupdate -group RAM /system_tb/DUT/RAM/ramif/memREN
add wave -noupdate -group RAM /system_tb/DUT/RAM/ramif/memWEN
add wave -noupdate -group RAM /system_tb/DUT/RAM/ramif/memaddr
add wave -noupdate -group RAM /system_tb/DUT/RAM/ramif/memstore
add wave -noupdate -group {Datapath Cache} /system_tb/DUT/CPU/dcif/halt
add wave -noupdate -group {Datapath Cache} /system_tb/DUT/CPU/dcif/ihit
add wave -noupdate -group {Datapath Cache} /system_tb/DUT/CPU/dcif/imemREN
add wave -noupdate -group {Datapath Cache} /system_tb/DUT/CPU/dcif/imemload
add wave -noupdate -group {Datapath Cache} /system_tb/DUT/CPU/dcif/imemaddr
add wave -noupdate -group {Datapath Cache} /system_tb/DUT/CPU/dcif/dhit
add wave -noupdate -group {Datapath Cache} /system_tb/DUT/CPU/dcif/datomic
add wave -noupdate -group {Datapath Cache} /system_tb/DUT/CPU/dcif/dmemREN
add wave -noupdate -group {Datapath Cache} /system_tb/DUT/CPU/dcif/dmemWEN
add wave -noupdate -group {Datapath Cache} /system_tb/DUT/CPU/dcif/flushed
add wave -noupdate -group {Datapath Cache} /system_tb/DUT/CPU/dcif/dmemload
add wave -noupdate -group {Datapath Cache} /system_tb/DUT/CPU/dcif/dmemstore
add wave -noupdate -group {Datapath Cache} /system_tb/DUT/CPU/dcif/dmemaddr
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1311856094 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
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
WaveRestoreZoom {0 ps} {941424 ps}
