`timescale 1ns / 1ps
/****************************** C E C S  4 4 0 ******************************
 *
 * File Name:  CPU.v
 * Project:    Senior Design Project
 * Designer:   Joseph Almeida, Peter Huynh
 * Email:      josephnalmeida@gmail.com, peterhuynh75@gmail.com
 * Rev. No.:   Version 1.0
 * Rev. Date:  November 24th, 2018
 *
 * Purpose:    Instantiates the processor modules, including the MCU, input
 *             and IDP. This module will be connected in the top level along
 *             with data memory and I/O memory.
 *
 * Notes:
 *
 ****************************************************************************/

module CPU(input sys_clk,
          input reset,
          input [31:0] Din,
          input INTR,
          output INT_ACK,
          output [31:0] Dout,
          output wire [31:0] Address,
          output IO_cs,
          output IO_rd,
          output IO_wr,
          output DM_cs,
          output DM_rd,
          output DM_wr);

          wire N, Z, C, V;
          wire [4:0] FS;
          wire PC_ld, PC_inc;
          wire IM_cs, IM_wr, IM_rd;
          wire IR_ld;
          wire D_En;
          wire [1:0] T_sel;
          wire HILO_ld, VHILO_ld;
          wire S_sel_wire;
          wire FLAG_ld;
          wire [2:0] Y_sel;
          wire [1:0] PC_sel;
          wire [1:0] D_sel;
          wire psc, psv, psn, psz;
          wire [31:0] SE_16_wire, PC_out_wire, IR_out_wire, SREG_JR_WIRE;


          MCU					  MCU		(.sys_clk(sys_clk),
        										 .reset(reset),
        										 .INTR(INTR),
        										 .C(C),.V(V),.Z(Z),.N(N),
        										 .FS(FS),
        										 .IR(IR_out_wire),
        										 .INT_ACK(INT_ACK),
        										 .PC_sel(PC_sel),
        										 .PC_ld(PC_ld),
        										 .PC_inc(PC_inc),
        										 .IM_cs(IM_cs),
        										 .IM_wr(IM_wr),
                                     .IM_rd(IM_rd),
                                     .IR_ld(IR_ld),
        										 .D_En(D_En),
        										 .D_sel(D_sel),
        										 .T_sel(T_sel),
												 .Y_sel(Y_sel),
        										 .HILO_ld(HILO_ld),
        										 .flag_ld(FLAG_ld),
        										 .DM_cs(DM_cs),
        										 .DM_rd(DM_rd),
        										 .DM_wr(DM_wr),
        										 .io_cs(IO_cs),
        										 .io_wr(IO_wr),
        										 .io_rd(IO_rd),
        										 .psc(psc),.psv(psv),.psn(psn),.psz(psz),
        										 .S_sel(S_sel_wire),
												 .VHILO_ld(VHILO_ld));


        	 Instruction_Unit   IU     (.clk(sys_clk),
                                     .reset(reset),
                                     .PC_ld(PC_ld),
                                     .PC_inc(PC_inc),
                                     .IM_cs(IM_cs),
                                     .IM_wr(IM_wr),
        										 .PC_jr(SREG_JR_WIRE),
                                     .IM_rd(IM_rd),
                                     .IR_ld(IR_ld),
        										 .PC_sel(PC_sel),
                                     .PC_in(Address),
                                     .SE_16(SE_16_wire),
                                     .PC_out(PC_out_wire),
                                     .IR_out(IR_out_wire));

          Integer_Datapath   IDP    (.clk(sys_clk),
        										 .reset(reset),
        										 .D_En(D_En),
                                     .T_Sel(T_sel),
        										 .HILO_ld(HILO_ld),
        										 .FLAG_ld(FLAG_ld),
        										 .D_sel(D_sel),
                                     .Y_Sel(Y_sel),
        										 .RS(SREG_JR_WIRE),
												 .SPLAT(IR_out_wire[10:9]),
                                     .D_Addr(IR_out_wire[15:11]),
                                     .S_Addr(IR_out_wire[25:21]),
                                     .T_Addr(IR_out_wire[20:16]),
                                     .FS(FS),
                                     .DY(Din),
        										 .DT(SE_16_wire),
                                     .PC_In(PC_out_wire),
                                     .N(N), .Z(Z), .C(C), .V(V),
                                     .D_OUT(Dout),
                                     .ALU_OUT(Address),
        										 .shamt(IR_out_wire[10:6]),
        										 .psc(psc),.psv(psv),.psn(psn),.psz(psz),
        										 .S_Sel(S_sel_wire),
												 .VHILO_ld(VHILO_ld));
endmodule
