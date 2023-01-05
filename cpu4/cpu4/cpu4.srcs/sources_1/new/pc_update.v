`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/11/29 16:14:54
// Design Name: 
// Module Name: decoder
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
`include "define.vh"

module pc_update( // 完成。
    input wire br,
    input wire [31:0] imm_e2,
    input wire [31:0] pc_e2,
    input wire [5:0] alucode_pc,
    input wire [31:0] rs1_value_pc,
    output wire [31:0] new_pc,
    output wire [2:0] stall,
    output wire fetch_stall,
    output wire decode_stall,
    output wire execute_stall,
    output wire memory_stall,
    output wire write_stall
);
    function [31:0] find_pc;
    input br;
    input [31:0] imm_e2;
    input [31:0] pc_e2;
    input [5:0] alucode_pc;
    input [31:0] rs1_value_pc;
    begin
        if (br) begin
            // stall = (stall + 1) % 6;
            // if ((stall + 3'd6) % 6 == 3'd0) begin
            // end
            if (alucode_pc == 6'd2) find_pc = rs1_value_pc + imm_e2; //  - 32'h8000
            else find_pc = pc_e2 + imm_e2;
        end
        else find_pc = pc_e2 + +32'h20;
    end
    endfunction

    assign new_pc = find_pc(br, imm_e2, pc_e2, alucode_pc, rs1_value_pc);
    assign stall = (br) ? (stall + 3'd1) % 3'd6 : 3'd0;
    assign fetch_stall = (stall == 3'd1) ? 1'd1 : (stall == 3'd2) ? 1'd1 : 1'd0;
    assign decode_stall = (stall == 3'd1) ? 1'd1 : (stall == 3'd2) ? 1'd1: (stall == 3'd3) ? 1'd1: 1'd0;
    assign execute_stall = (stall == 3'd1) ? 1'd1 : (stall == 3'd2) ? 1'd1: (stall == 3'd3) ? 1'd1: (stall == 3'd4) ? 1'd1 : 1'd0;
    assign memory_stall = (stall == 3'd2) ? 1'd1 : (stall == 3'd3) ? 1'd1 : (stall == 3'd4) ? 1'd1 : (stall == 3'd5) ? 1'd1 : 1'd0;
    assign write_stall = (stall == 3'd3) ? 1'd1 : (stall == 3'd4) ? 1'd1 : (stall == 3'd5) ? 1'd1 : 1'd0;

endmodule
