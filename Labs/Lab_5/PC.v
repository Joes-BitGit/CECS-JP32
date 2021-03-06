`timescale 1ns / 1ps
/****************************** C E C S  4 4 0 ******************************
 * 
 * File Name:  PC.v
 * Project:    Lab_Assignment_5
 * Designer:   Joseph Almeida
 * Email:      Josephnalmeida@gmail.com
 * Rev. No.:   Version 1.0
 * Rev. Date:  October 9, 2018 
 *
 * Purpose: Datapath that stitches the register file and ALU together
 *				to allow data to come in from sources such as memory, I/O,
 *				or applicable IR fields
 *         
 * Notes:
 *
 ****************************************************************************/
module PC(
    input clk,
    input reset,
    input [31:0] PC_in,
    input PC_ld,
    input PC_inc,
    output reg [31:0] PC_out
    );
	
	always@(posedge clk, posedge reset)
	begin
		if(reset) PC_out <= 0;
		else if (PC_inc) PC_out <= PC_out + 32'h4;
		else if (PC_ld)  PC_out <= PC_in;
		else				  PC_out <= PC_out;
		
		/*
		case({PC_inc, PC_ld})
			2'b01  : PC_out <= PC_in;
			2'b10  : PC_out <= PC_out + 32'h4;
			default: PC_out <= PC_out
		*/
	end

endmodule
