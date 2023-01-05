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
    output wire [31:0] alu_result_2,
    output wire br_taken             // 分岐の有無
);

function [31:0] calc;
    input [5:0] alucode_e;
    input [31:0] op1;
    input [31:0] op2;
    reg [31:0] register;
    reg signed [31:0] signed_op1;
    reg signed [31:0] signed_op2;
    reg signed [4:0] signed_op2_4;
    reg signed [63:0] mulss;
    reg signed [63:0] mulsu;
    reg [63:0] mulu;
    begin
        register = op1 + ~op2 + 32'd1;
        signed_op1 = op1;
        signed_op2 = op2;
        // signed_op2_4 = op2[4:0];
        mulss = signed_op1 * signed_op2;
        mulsu = signed_op1 * $signed({1'b0, op2});
        mulu = op1 * op2;
        calc = (alucode_e == `ALU_ADD) ? op1 + op2 : // (alucode_e == `ALU_AUIPC) ? op1 + op2 + 32'h8000 :
        (alucode_e == `ALU_SUB) ? op1 + ~op2 + 32'd1 :
        (alucode_e == `ALU_SLT) ? (register[31] == 1'd1) ? 32'd1 : 32'd0 :
        (alucode_e == `ALU_SLTU) ? (op1 >= op2) ? 32'd0 : 32'd1 :
        (alucode_e == `ALU_XOR) ? op1 ^ op2 :
        (alucode_e == `ALU_OR) ? op1 | op2 :
        (alucode_e == `ALU_AND) ? op1 & op2 :
        (alucode_e == `ALU_SLL) ? op1 << op2[4:0] :
        (alucode_e == `ALU_SRL) ? op1 >> op2[4:0] :
        (alucode_e == `ALU_JAL) ? op2 + 32'd4: // + 32'h8000:
        (alucode_e == `ALU_JALR) ? op2 + 32'd4:
        (alucode_e == `ALU_LB) ? op1 + op2: // - 32'h10000:
        (alucode_e == `ALU_LH) ? op1 + op2:
        (alucode_e == `ALU_LW) ? op1 + op2:
        (alucode_e == `ALU_LBU) ? op1 + op2:
        (alucode_e == `ALU_LHU) ? op1 + op2:
        (alucode_e == `ALU_SB) ? op1 + op2:
        (alucode_e == `ALU_SH) ? op1 + op2:
        (alucode_e == `ALU_SW) ? op1 + op2:
        (alucode_e == `ALU_LUI) ? op2 :
        (alucode_e == `ALU_MUL) ? mulss[31:0] :
        (alucode_e == `ALU_MULH) ? mulss[63:32] :
        (alucode_e == `ALU_MULHsu) ? mulsu[63:32] :
        (alucode_e == `ALU_MULHu) ? mulu[63:32] :
        (alucode_e == `ALU_DIV) ? (op2 == 32'd0) ? {32{1'b1}} : (signed_op1 == {{1'd1}, {31'd0}} && signed_op2 == {32{1'b1}}) ? {{1'd1},{31'd0}} : signed_op1 / signed_op2 :
        (alucode_e == `ALU_DIVu) ? (op2 == 32'd0) ? {32{1'b1}} : op1 / op2 : // エラーここの`?
        (alucode_e == `ALU_REM) ? (op2 == 32'd0) ? signed_op1 : (signed_op1 == {{1'd1}, {31'd0}} && signed_op2 == {32{1'b1}}) ? 32'd0 : signed_op1 % signed_op2 : // ここの最後。
        (alucode_e == `ALU_REMu) ? (op2 == 32'd0) ? op1 : op1 % op2 : // ここの最後。
        32'd0;
        if (alucode_e == `ALU_SRA) begin
            signed_op1 = op1;
            signed_op2_4 = op2[4:0];
            calc = signed_op1 >>> signed_op2;
        end
    end
endfunction

function is_jump;
    input [5:0] alucode_e;
    input [31:0] op1;
    input [31:0] op2;
    reg [31:0] register;
    begin
        register = op1 + ~op2 + 32'd1;
        is_jump = (alucode_e == `ALU_JAL) ? 1'd1 : 
        (alucode_e == `ALU_JALR) ? 1'd1 :
        (alucode_e == `ALU_BEQ) ? (op1 == op2) ? 1'd1 : 1'd0 :
        (alucode_e == `ALU_BNE) ? (op1 == op2) ? 1'd0 : 1'd1 :
        (alucode_e == `ALU_BLT) ? (register[31] == 1'd1) ? 1'd1 : 1'd0 :
        (alucode_e == `ALU_BLTU) ? (op1 < op2) ? 1'd1 : 1'd0 :
        (alucode_e == `ALU_BGE) ? (register[31] == 1'd1) ? 1'd0 : 1'd1 :
        (alucode_e == `ALU_BGEU) ? (op1 < op2) ? 1'd0 : 1'd1 :
        1'd0;
    end
endfunction

assign alu_result = calc(alucode_e, op1, op2);
assign alu_result_2 = calc(alucode_e, op1, op2);
assign br_taken = is_jump(alucode_e, op1, op2);

endmodule
