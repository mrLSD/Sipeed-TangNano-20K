`timescale 1ns/1ns

module lcd_data
( 
	input  wire	 		clk,	
	input  wire			rst_n,	
	input  wire	[11:0]	lcd_xpos,	//lcd horizontal coordinate
	input  wire	[11:0]	lcd_ypos,	//lcd vertical coordinate
	
	output reg  [23:0]	lcd_data	//lcd data
);

`define BLACK 	24'h000000

`define	DISPLAY_IMAGE
// `define	VGA_GRAY_GRAPH

`ifdef DISPLAY_IMAGE

parameter H_DISP = 200;
parameter V_DISP = 154;
parameter SHIFT = 200; 

reg [23:0] counter;
reg [23:0] shift;
reg direction;

reg [23:0] buffer[H_DISP * V_DISP:0];
initial $readmemh("output.hex", buffer);

always@(posedge clk or negedge rst_n)
begin
	if(!rst_n) begin
		lcd_data <= 24'h0;
		counter <= 24'h0;
		shift <= 24'h0;
		direction <= 0;
    end
	else begin
	    if (counter < 24'h100000) begin
	        counter <= counter + 1; 
	    end 
	    else begin
	        counter <= 24'h0;
	        if ((shift == SHIFT-1 && direction == 0) || (shift == 1 && direction == 1)) begin
	            direction <= !direction;
            end
	        if (direction == 0) 
	            shift <= shift + 1;
            else
                shift <= shift - 1;
	    end
	    if (lcd_xpos > shift && lcd_xpos < 3*H_DISP+shift && lcd_ypos < 3*V_DISP)
            lcd_data <= buffer[(lcd_ypos/3)*H_DISP + (lcd_xpos-shift)/3];
        else 
            lcd_data <= `BLACK;
    end
end
`endif


`ifdef VGA_GRAY_GRAPH
parameter H_DISP = 800
parameter V_DISP = 480

always@(posedge clk or negedge rst_n)
begin
	if(!rst_n)
		lcd_data <= 24'h0;
	else
		begin
		if(lcd_ypos < V_DISP/2)
			lcd_data <= {lcd_ypos[7:0], lcd_ypos[7:0], lcd_ypos[7:0]};
		else
			lcd_data <= {lcd_xpos[7:0], lcd_xpos[7:0], lcd_xpos[7:0]};
		end
end
`endif

endmodule
