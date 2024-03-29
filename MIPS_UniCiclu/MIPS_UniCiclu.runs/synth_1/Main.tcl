# 
# Synthesis run script generated by Vivado
# 

set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000
create_project -in_memory -part xc7a35tcpg236-1

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_property webtalk.parent_dir C:/Users/ioana/Vivado_pro/MIPS_UniCiclu/MIPS_UniCiclu.cache/wt [current_project]
set_property parent.project_path C:/Users/ioana/Vivado_pro/MIPS_UniCiclu/MIPS_UniCiclu.xpr [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language VHDL [current_project]
set_property ip_output_repo c:/Users/ioana/Vivado_pro/MIPS_UniCiclu/MIPS_UniCiclu.cache/ip [current_project]
set_property ip_cache_permissions {read write} [current_project]
read_vhdl -library xil_defaultlib {
  C:/Users/ioana/Vivado_pro/MIPS_UniCiclu/MIPS_UniCiclu.srcs/sources_1/new/RF.vhd
  C:/Users/ioana/Vivado_pro/MIPS_UniCiclu/MIPS_UniCiclu.srcs/sources_1/new/UC.vhd
  C:/Users/ioana/Vivado_pro/MIPS_UniCiclu/MIPS_UniCiclu.srcs/sources_1/new/SSD.vhd
  C:/Users/ioana/Vivado_pro/MIPS_UniCiclu/MIPS_UniCiclu.srcs/sources_1/new/MPG.vhd
  C:/Users/ioana/Vivado_pro/MIPS_UniCiclu/MIPS_UniCiclu.srcs/sources_1/new/MEM.vhd
  C:/Users/ioana/Vivado_pro/MIPS_UniCiclu/MIPS_UniCiclu.srcs/sources_1/new/IFF.vhd
  C:/Users/ioana/Vivado_pro/MIPS_UniCiclu/MIPS_UniCiclu.srcs/sources_1/new/EXX.vhd
  C:/Users/ioana/Vivado_pro/MIPS_UniCiclu/MIPS_UniCiclu.srcs/sources_1/new/IDD.vhd
  C:/Users/ioana/Vivado_pro/MIPS_UniCiclu/MIPS_UniCiclu.srcs/sources_1/new/Main.vhd
}
foreach dcp [get_files -quiet -all *.dcp] {
  set_property used_in_implementation false $dcp
}
read_xdc C:/Users/ioana/Vivado_pro/MIPS_UniCiclu/MIPS_UniCiclu.srcs/constrs_1/new/Basys3_mipsUniciclu.xdc
set_property used_in_implementation false [get_files C:/Users/ioana/Vivado_pro/MIPS_UniCiclu/MIPS_UniCiclu.srcs/constrs_1/new/Basys3_mipsUniciclu.xdc]


synth_design -top Main -part xc7a35tcpg236-1


write_checkpoint -force -noxdef Main.dcp

catch { report_utilization -file Main_utilization_synth.rpt -pb Main_utilization_synth.pb }
