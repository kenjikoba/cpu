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

module alu(
    input wire [5:0] alucode_e,       // 演算種別
    input wire [31:0] op1,          // 入力データ1
    input wire [31:0] op2,          // 入力データ2
    output wire [31:0] alu_result,   // 演算結果
    output wire br_taken             // 分岐の有無
);

function [31:0] calc;
    input [5:0] alucode_e;
    input [31:0] op1;
    input [31:0] op2;
    reg [31:0] register;
    reg signed [31:0] signed_op1;
    reg signed [4:0] signed_op2;
    begin
        case(alucode_e)
            `ALU_ADD: calc = op1 + op2;
            `ALU_SUB: calc = op1 + ~op2 + 32'd1;
            `ALU_SLT: begin
                register = op1 + ~op2 + 32'd1;
                if (register[31] == 1'd1) calc = 32'd1;
                else calc = 32'd0;
            end
            `ALU_SLTU: begin
                if (op1 >= op2) calc = 32'd0; // これどっち。
                else calc = 32'd1;
            end
            `ALU_XOR: calc = op1 ^ op2;
            `ALU_OR: calc = op1 | op2;
            `ALU_AND: calc = op1 & op2;
            `ALU_SLL: calc = op1 << op2[4:0];
            `ALU_SRL: calc = op1 >> op2[4:0];
            `ALU_SRA: begin
                signed_op1 = op1;
                signed_op2 = op2[4:0];
                calc = signed_op1 >>> signed_op2;
            end
            `ALU_JAL: calc = op2 + 32'd4;
            `ALU_JALR: calc = op2 + 32'd4;
            `ALU_LB: calc = op1 + op2 - 32'h10000;
            `ALU_LH: calc = op1 + op2 - 32'h10000;
            `ALU_LW: calc = op1 + op2 - 32'h10000;
            `ALU_LBU: calc = op1 + op2 - 32'h10000;
            `ALU_LHU: calc = op1 + op2 - 32'h10000;
            `ALU_SB: calc = op1 + op2 - 32'h10000;
            `ALU_SH: calc = op1 + op2 - 32'h10000;
            `ALU_SW: calc = op1 + op2 - 32'h10000;
            `ALU_LUI: calc = op2;
            default: calc = 32'd0;
        endcase
    end
endfunction

function is_jump;
    input [5:0] alucode_e;
    input [31:0] op1;
    input [31:0] op2;
    reg [31:0] register;
    begin
        case(alucode_e)
            // `ALU_AUIPC: is_jump = 1'd1;
            `ALU_JAL: is_jump = 1'd1;
            `ALU_JALR: is_jump = 1'd1;
            `ALU_BEQ: begin
                if (op1 == op2) is_jump = 1'd1;
                else is_jump = 1'd0;
            end
            `ALU_BNE: begin
                if (op1 == op2) is_jump = 1'd0;
                else is_jump = 1'd1;
            end
            `ALU_BLT: begin
                register = op1 + ~op2 + 32'd1;
                if (register[31] == 1'd1) is_jump = 1'd1;
                else is_jump = 1'd0;
            end
            `ALU_BLTU: begin
                if (op1 < op2) is_jump = 1'd1;
                else is_jump = 1'd0;
            end
            `ALU_BGE: begin
                register = op1 + ~op2 + 32'd1;
                if (register[31] == 1'd1) is_jump = 1'd0;
                else is_jump = 1'd1;
            end
            `ALU_BGEU: begin
                if (op1 < op2) is_jump = 1'd0;
                else is_jump = 1'd1;
            end
            default: is_jump = 1'd0;
        endcase
    end
endfunction

assign alu_result = calc(alucode_e, op1, op2);
assign br_taken = is_jump(alucode_e, op1, op2);

endmodule
