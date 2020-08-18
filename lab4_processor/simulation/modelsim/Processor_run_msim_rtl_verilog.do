transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+C:/Users/Anshul/Desktop/ECE\ 385/lab4_sgrover4_ardesai2/processor {C:/Users/Anshul/Desktop/ECE 385/lab4_sgrover4_ardesai2/processor/Synchronizers.sv}
vlog -sv -work work +incdir+C:/Users/Anshul/Desktop/ECE\ 385/lab4_sgrover4_ardesai2/processor {C:/Users/Anshul/Desktop/ECE 385/lab4_sgrover4_ardesai2/processor/Router.sv}
vlog -sv -work work +incdir+C:/Users/Anshul/Desktop/ECE\ 385/lab4_sgrover4_ardesai2/processor {C:/Users/Anshul/Desktop/ECE 385/lab4_sgrover4_ardesai2/processor/Reg_4.sv}
vlog -sv -work work +incdir+C:/Users/Anshul/Desktop/ECE\ 385/lab4_sgrover4_ardesai2/processor {C:/Users/Anshul/Desktop/ECE 385/lab4_sgrover4_ardesai2/processor/HexDriver.sv}
vlog -sv -work work +incdir+C:/Users/Anshul/Desktop/ECE\ 385/lab4_sgrover4_ardesai2/processor {C:/Users/Anshul/Desktop/ECE 385/lab4_sgrover4_ardesai2/processor/Control.sv}
vlog -sv -work work +incdir+C:/Users/Anshul/Desktop/ECE\ 385/lab4_sgrover4_ardesai2/processor {C:/Users/Anshul/Desktop/ECE 385/lab4_sgrover4_ardesai2/processor/compute.sv}
vlog -sv -work work +incdir+C:/Users/Anshul/Desktop/ECE\ 385/lab4_sgrover4_ardesai2/processor {C:/Users/Anshul/Desktop/ECE 385/lab4_sgrover4_ardesai2/processor/Register_unit.sv}
vlog -sv -work work +incdir+C:/Users/Anshul/Desktop/ECE\ 385/lab4_sgrover4_ardesai2/processor {C:/Users/Anshul/Desktop/ECE 385/lab4_sgrover4_ardesai2/processor/Processor.sv}

vlog -sv -work work +incdir+C:/Users/Anshul/Desktop/ECE\ 385/Labs/lab4_processor/../../lab4_sgrover4_ardesai2/processor {C:/Users/Anshul/Desktop/ECE 385/Labs/lab4_processor/../../lab4_sgrover4_ardesai2/processor/testbench_8.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  testbench_8

add wave *
view structure
view signals
run 1000 ns
