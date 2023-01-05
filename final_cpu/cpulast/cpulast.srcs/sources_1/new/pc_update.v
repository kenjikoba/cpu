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

// module pc_div( // 完成。
//     input clk,
//     input cpu_resetn,
//     input wire [31:0] new_pc,
//     output wire [31:0] next_pc,
//     output wire [31:0] pc
// );
//     reg [31:0] reg_pc;
//     // initial reg_pc <= 32'h00008000;
//     initial reg_pc <= 32'd0;
//     always @(posedge clk) begin
//         if (!cpu_resetn) reg_pc <= 32'd1;
//         else reg_pc <= new_pc;
//         // $display(reg_pc);
//         // $display("hello");
//     end

//     assign next_pc = reg_pc;
//     assign pc = reg_pc;
// endmodule

module pc_update( // 完成。
    input wire br,
    input wire [31:0] imm_e2,
    input wire [31:0] pc_e2,
    input wire [5:0] alucode_pc,
    input wire [31:0] rs1_value_pc,
    output wire [31:0] new_pc
);
    function [31:0] find_pc;
    input br;
    input [31:0] imm_e2;
    input [31:0] pc_e2;
    input [5:0] alucode_pc;
    input [31:0] rs1_value_pc;
    begin
        if (br) begin
            if (alucode_pc == 6'd2) find_pc = rs1_value_pc + imm_e2; //  - 32'h8000
            else find_pc = pc_e2 + imm_e2;
        end
        else find_pc = pc_e2 + +32'h4;
        // $display("next instruction");
        // $display(imm_e2);
    end
    endfunction

    assign new_pc = find_pc(br, imm_e2, pc_e2, alucode_pc, rs1_value_pc);

endmodule
