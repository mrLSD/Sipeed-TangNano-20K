add_file src/lcd.cst
add_file src/top.v
add_file src/lcd_ctrl.v
add_file src/lcd_data.v
add_file src/gowin_rpll/pll_40m.v
set_device -name GW2AR-18C GW2AR-LV18QN88C8/I7 
set_option -top_module top
set_option -output_base_name app
run all
