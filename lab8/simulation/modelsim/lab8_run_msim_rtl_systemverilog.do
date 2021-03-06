transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/Anshul/Desktop/ECE385/Labs/lab8 {C:/Users/Anshul/Desktop/ECE385/Labs/lab8/vga_clk.v}
vlog -vlog01compat -work work +incdir+C:/Users/Anshul/Desktop/ECE385/Labs/lab8/lab8_soc/synthesis {C:/Users/Anshul/Desktop/ECE385/Labs/lab8/lab8_soc/synthesis/lab8_soc.v}
vlog -vlog01compat -work work +incdir+C:/Users/Anshul/Desktop/ECE385/Labs/lab8/db {C:/Users/Anshul/Desktop/ECE385/Labs/lab8/db/vga_clk_altpll.v}
vlib lab8_soc
vmap lab8_soc lab8_soc
vlog -vlog01compat -work lab8_soc +incdir+C:/Users/Anshul/Desktop/ECE385/Labs/lab8/lab8_soc/synthesis/submodules {C:/Users/Anshul/Desktop/ECE385/Labs/lab8/lab8_soc/synthesis/submodules/altera_reset_controller.v}
vlog -vlog01compat -work lab8_soc +incdir+C:/Users/Anshul/Desktop/ECE385/Labs/lab8/lab8_soc/synthesis/submodules {C:/Users/Anshul/Desktop/ECE385/Labs/lab8/lab8_soc/synthesis/submodules/altera_reset_synchronizer.v}
vlog -vlog01compat -work lab8_soc +incdir+C:/Users/Anshul/Desktop/ECE385/Labs/lab8/lab8_soc/synthesis/submodules {C:/Users/Anshul/Desktop/ECE385/Labs/lab8/lab8_soc/synthesis/submodules/lab8_soc_mm_interconnect_0.v}
vlog -vlog01compat -work lab8_soc +incdir+C:/Users/Anshul/Desktop/ECE385/Labs/lab8/lab8_soc/synthesis/submodules {C:/Users/Anshul/Desktop/ECE385/Labs/lab8/lab8_soc/synthesis/submodules/lab8_soc_mm_interconnect_0_avalon_st_adapter.v}
vlog -vlog01compat -work lab8_soc +incdir+C:/Users/Anshul/Desktop/ECE385/Labs/lab8/lab8_soc/synthesis/submodules {C:/Users/Anshul/Desktop/ECE385/Labs/lab8/lab8_soc/synthesis/submodules/altera_avalon_sc_fifo.v}
vlog -vlog01compat -work lab8_soc +incdir+C:/Users/Anshul/Desktop/ECE385/Labs/lab8/lab8_soc/synthesis/submodules {C:/Users/Anshul/Desktop/ECE385/Labs/lab8/lab8_soc/synthesis/submodules/lab8_soc_sysid_qsys_0.v}
vlog -vlog01compat -work lab8_soc +incdir+C:/Users/Anshul/Desktop/ECE385/Labs/lab8/lab8_soc/synthesis/submodules {C:/Users/Anshul/Desktop/ECE385/Labs/lab8/lab8_soc/synthesis/submodules/lab8_soc_sdram_pll.v}
vlog -vlog01compat -work lab8_soc +incdir+C:/Users/Anshul/Desktop/ECE385/Labs/lab8/lab8_soc/synthesis/submodules {C:/Users/Anshul/Desktop/ECE385/Labs/lab8/lab8_soc/synthesis/submodules/lab8_soc_sdram.v}
vlog -vlog01compat -work lab8_soc +incdir+C:/Users/Anshul/Desktop/ECE385/Labs/lab8/lab8_soc/synthesis/submodules {C:/Users/Anshul/Desktop/ECE385/Labs/lab8/lab8_soc/synthesis/submodules/lab8_soc_otg_hpi_data.v}
vlog -vlog01compat -work lab8_soc +incdir+C:/Users/Anshul/Desktop/ECE385/Labs/lab8/lab8_soc/synthesis/submodules {C:/Users/Anshul/Desktop/ECE385/Labs/lab8/lab8_soc/synthesis/submodules/lab8_soc_otg_hpi_cs.v}
vlog -vlog01compat -work lab8_soc +incdir+C:/Users/Anshul/Desktop/ECE385/Labs/lab8/lab8_soc/synthesis/submodules {C:/Users/Anshul/Desktop/ECE385/Labs/lab8/lab8_soc/synthesis/submodules/lab8_soc_otg_hpi_address.v}
vlog -vlog01compat -work lab8_soc +incdir+C:/Users/Anshul/Desktop/ECE385/Labs/lab8/lab8_soc/synthesis/submodules {C:/Users/Anshul/Desktop/ECE385/Labs/lab8/lab8_soc/synthesis/submodules/lab8_soc_onchip_memory2_0.v}
vlog -vlog01compat -work lab8_soc +incdir+C:/Users/Anshul/Desktop/ECE385/Labs/lab8/lab8_soc/synthesis/submodules {C:/Users/Anshul/Desktop/ECE385/Labs/lab8/lab8_soc/synthesis/submodules/lab8_soc_nios2_gen2_0.v}
vlog -vlog01compat -work lab8_soc +incdir+C:/Users/Anshul/Desktop/ECE385/Labs/lab8/lab8_soc/synthesis/submodules {C:/Users/Anshul/Desktop/ECE385/Labs/lab8/lab8_soc/synthesis/submodules/lab8_soc_nios2_gen2_0_cpu.v}
vlog -vlog01compat -work lab8_soc +incdir+C:/Users/Anshul/Desktop/ECE385/Labs/lab8/lab8_soc/synthesis/submodules {C:/Users/Anshul/Desktop/ECE385/Labs/lab8/lab8_soc/synthesis/submodules/lab8_soc_nios2_gen2_0_cpu_debug_slave_sysclk.v}
vlog -vlog01compat -work lab8_soc +incdir+C:/Users/Anshul/Desktop/ECE385/Labs/lab8/lab8_soc/synthesis/submodules {C:/Users/Anshul/Desktop/ECE385/Labs/lab8/lab8_soc/synthesis/submodules/lab8_soc_nios2_gen2_0_cpu_debug_slave_tck.v}
vlog -vlog01compat -work lab8_soc +incdir+C:/Users/Anshul/Desktop/ECE385/Labs/lab8/lab8_soc/synthesis/submodules {C:/Users/Anshul/Desktop/ECE385/Labs/lab8/lab8_soc/synthesis/submodules/lab8_soc_nios2_gen2_0_cpu_debug_slave_wrapper.v}
vlog -vlog01compat -work lab8_soc +incdir+C:/Users/Anshul/Desktop/ECE385/Labs/lab8/lab8_soc/synthesis/submodules {C:/Users/Anshul/Desktop/ECE385/Labs/lab8/lab8_soc/synthesis/submodules/lab8_soc_nios2_gen2_0_cpu_test_bench.v}
vlog -vlog01compat -work lab8_soc +incdir+C:/Users/Anshul/Desktop/ECE385/Labs/lab8/lab8_soc/synthesis/submodules {C:/Users/Anshul/Desktop/ECE385/Labs/lab8/lab8_soc/synthesis/submodules/lab8_soc_keycode.v}
vlog -vlog01compat -work lab8_soc +incdir+C:/Users/Anshul/Desktop/ECE385/Labs/lab8/lab8_soc/synthesis/submodules {C:/Users/Anshul/Desktop/ECE385/Labs/lab8/lab8_soc/synthesis/submodules/lab8_soc_jtag_uart_0.v}
vlog -vlog01compat -work lab8_soc +incdir+C:/Users/Anshul/Desktop/ECE385/Labs/lab8/lab8_soc/synthesis/submodules {C:/Users/Anshul/Desktop/ECE385/Labs/lab8/lab8_soc/synthesis/submodules/lab8_soc_accumulate.v}
vlog -sv -work work +incdir+C:/Users/Anshul/Desktop/ECE385/Labs/lab8 {C:/Users/Anshul/Desktop/ECE385/Labs/lab8/hpi_io_intf.sv}
vlog -sv -work work +incdir+C:/Users/Anshul/Desktop/ECE385/Labs/lab8 {C:/Users/Anshul/Desktop/ECE385/Labs/lab8/VGA_controller.sv}
vlog -sv -work work +incdir+C:/Users/Anshul/Desktop/ECE385/Labs/lab8 {C:/Users/Anshul/Desktop/ECE385/Labs/lab8/HexDriver.sv}
vlog -sv -work work +incdir+C:/Users/Anshul/Desktop/ECE385/Labs/lab8 {C:/Users/Anshul/Desktop/ECE385/Labs/lab8/Color_Mapper.sv}
vlog -sv -work work +incdir+C:/Users/Anshul/Desktop/ECE385/Labs/lab8 {C:/Users/Anshul/Desktop/ECE385/Labs/lab8/ball.sv}
vlog -sv -work work +incdir+C:/Users/Anshul/Desktop/ECE385/Labs/lab8 {C:/Users/Anshul/Desktop/ECE385/Labs/lab8/lab8.sv}
vlog -sv -work lab8_soc +incdir+C:/Users/Anshul/Desktop/ECE385/Labs/lab8/lab8_soc/synthesis/submodules {C:/Users/Anshul/Desktop/ECE385/Labs/lab8/lab8_soc/synthesis/submodules/lab8_soc_irq_mapper.sv}
vlog -sv -work lab8_soc +incdir+C:/Users/Anshul/Desktop/ECE385/Labs/lab8/lab8_soc/synthesis/submodules {C:/Users/Anshul/Desktop/ECE385/Labs/lab8/lab8_soc/synthesis/submodules/lab8_soc_mm_interconnect_0_avalon_st_adapter_error_adapter_0.sv}
vlog -vlog01compat -work lab8_soc +incdir+C:/Users/Anshul/Desktop/ECE385/Labs/lab8/lab8_soc/synthesis/submodules {C:/Users/Anshul/Desktop/ECE385/Labs/lab8/lab8_soc/synthesis/submodules/altera_avalon_st_handshake_clock_crosser.v}
vlog -vlog01compat -work lab8_soc +incdir+C:/Users/Anshul/Desktop/ECE385/Labs/lab8/lab8_soc/synthesis/submodules {C:/Users/Anshul/Desktop/ECE385/Labs/lab8/lab8_soc/synthesis/submodules/altera_avalon_st_clock_crosser.v}
vlog -vlog01compat -work lab8_soc +incdir+C:/Users/Anshul/Desktop/ECE385/Labs/lab8/lab8_soc/synthesis/submodules {C:/Users/Anshul/Desktop/ECE385/Labs/lab8/lab8_soc/synthesis/submodules/altera_std_synchronizer_nocut.v}
vlog -sv -work lab8_soc +incdir+C:/Users/Anshul/Desktop/ECE385/Labs/lab8/lab8_soc/synthesis/submodules {C:/Users/Anshul/Desktop/ECE385/Labs/lab8/lab8_soc/synthesis/submodules/lab8_soc_mm_interconnect_0_rsp_mux_001.sv}
vlog -sv -work lab8_soc +incdir+C:/Users/Anshul/Desktop/ECE385/Labs/lab8/lab8_soc/synthesis/submodules {C:/Users/Anshul/Desktop/ECE385/Labs/lab8/lab8_soc/synthesis/submodules/altera_merlin_arbitrator.sv}
vlog -sv -work lab8_soc +incdir+C:/Users/Anshul/Desktop/ECE385/Labs/lab8/lab8_soc/synthesis/submodules {C:/Users/Anshul/Desktop/ECE385/Labs/lab8/lab8_soc/synthesis/submodules/lab8_soc_mm_interconnect_0_rsp_mux.sv}
vlog -sv -work lab8_soc +incdir+C:/Users/Anshul/Desktop/ECE385/Labs/lab8/lab8_soc/synthesis/submodules {C:/Users/Anshul/Desktop/ECE385/Labs/lab8/lab8_soc/synthesis/submodules/lab8_soc_mm_interconnect_0_rsp_demux_001.sv}
vlog -sv -work lab8_soc +incdir+C:/Users/Anshul/Desktop/ECE385/Labs/lab8/lab8_soc/synthesis/submodules {C:/Users/Anshul/Desktop/ECE385/Labs/lab8/lab8_soc/synthesis/submodules/lab8_soc_mm_interconnect_0_rsp_demux.sv}
vlog -sv -work lab8_soc +incdir+C:/Users/Anshul/Desktop/ECE385/Labs/lab8/lab8_soc/synthesis/submodules {C:/Users/Anshul/Desktop/ECE385/Labs/lab8/lab8_soc/synthesis/submodules/lab8_soc_mm_interconnect_0_cmd_mux_001.sv}
vlog -sv -work lab8_soc +incdir+C:/Users/Anshul/Desktop/ECE385/Labs/lab8/lab8_soc/synthesis/submodules {C:/Users/Anshul/Desktop/ECE385/Labs/lab8/lab8_soc/synthesis/submodules/lab8_soc_mm_interconnect_0_cmd_mux.sv}
vlog -sv -work lab8_soc +incdir+C:/Users/Anshul/Desktop/ECE385/Labs/lab8/lab8_soc/synthesis/submodules {C:/Users/Anshul/Desktop/ECE385/Labs/lab8/lab8_soc/synthesis/submodules/lab8_soc_mm_interconnect_0_cmd_demux_001.sv}
vlog -sv -work lab8_soc +incdir+C:/Users/Anshul/Desktop/ECE385/Labs/lab8/lab8_soc/synthesis/submodules {C:/Users/Anshul/Desktop/ECE385/Labs/lab8/lab8_soc/synthesis/submodules/lab8_soc_mm_interconnect_0_cmd_demux.sv}
vlog -sv -work lab8_soc +incdir+C:/Users/Anshul/Desktop/ECE385/Labs/lab8/lab8_soc/synthesis/submodules {C:/Users/Anshul/Desktop/ECE385/Labs/lab8/lab8_soc/synthesis/submodules/lab8_soc_mm_interconnect_0_router_003.sv}
vlog -sv -work lab8_soc +incdir+C:/Users/Anshul/Desktop/ECE385/Labs/lab8/lab8_soc/synthesis/submodules {C:/Users/Anshul/Desktop/ECE385/Labs/lab8/lab8_soc/synthesis/submodules/lab8_soc_mm_interconnect_0_router_002.sv}
vlog -sv -work lab8_soc +incdir+C:/Users/Anshul/Desktop/ECE385/Labs/lab8/lab8_soc/synthesis/submodules {C:/Users/Anshul/Desktop/ECE385/Labs/lab8/lab8_soc/synthesis/submodules/lab8_soc_mm_interconnect_0_router_001.sv}
vlog -sv -work lab8_soc +incdir+C:/Users/Anshul/Desktop/ECE385/Labs/lab8/lab8_soc/synthesis/submodules {C:/Users/Anshul/Desktop/ECE385/Labs/lab8/lab8_soc/synthesis/submodules/lab8_soc_mm_interconnect_0_router.sv}
vlog -sv -work lab8_soc +incdir+C:/Users/Anshul/Desktop/ECE385/Labs/lab8/lab8_soc/synthesis/submodules {C:/Users/Anshul/Desktop/ECE385/Labs/lab8/lab8_soc/synthesis/submodules/altera_merlin_slave_agent.sv}
vlog -sv -work lab8_soc +incdir+C:/Users/Anshul/Desktop/ECE385/Labs/lab8/lab8_soc/synthesis/submodules {C:/Users/Anshul/Desktop/ECE385/Labs/lab8/lab8_soc/synthesis/submodules/altera_merlin_burst_uncompressor.sv}
vlog -sv -work lab8_soc +incdir+C:/Users/Anshul/Desktop/ECE385/Labs/lab8/lab8_soc/synthesis/submodules {C:/Users/Anshul/Desktop/ECE385/Labs/lab8/lab8_soc/synthesis/submodules/altera_merlin_master_agent.sv}
vlog -sv -work lab8_soc +incdir+C:/Users/Anshul/Desktop/ECE385/Labs/lab8/lab8_soc/synthesis/submodules {C:/Users/Anshul/Desktop/ECE385/Labs/lab8/lab8_soc/synthesis/submodules/altera_merlin_slave_translator.sv}
vlog -sv -work lab8_soc +incdir+C:/Users/Anshul/Desktop/ECE385/Labs/lab8/lab8_soc/synthesis/submodules {C:/Users/Anshul/Desktop/ECE385/Labs/lab8/lab8_soc/synthesis/submodules/altera_merlin_master_translator.sv}

vlog -sv -work work +incdir+C:/Users/Anshul/Desktop/ECE385/Labs/lab8 {C:/Users/Anshul/Desktop/ECE385/Labs/lab8/testbench.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -L lab8_soc -voptargs="+acc"  testbench

add wave *
view structure
view signals
run 10000 ns
