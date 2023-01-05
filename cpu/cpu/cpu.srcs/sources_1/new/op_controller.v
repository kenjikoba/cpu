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

module op_controller( // 完成。
    input wire [31:0] rs1_value_e,
    input wire [31:0] rs2_value_e,
    input wire [31:0] imm_e1,
    input wire [1:0] aluop1_type_e,
    input wire [1:0] aluop2_type_e,
    input wire [31:0] pc_e1,

    output wire [31:0] rs2_data,
    output wire [31:0] op1,
    output wire [31:0] op2,
    output wire [31:0] imm_e2,
    output wire [31:0] pc_e2
);
    function [31:0] choose_op1;
    input [31:0] rs1_value_e;
    input [31:0] rs2_value_e;
    input [31:0] imm_e1;
    input [1:0] aluop1_type_e;
    input [31:0] pc_e1;
    begin
        case (aluop1_type_e)
            2'd0: choose_op1 = 32'd0;
            2'd1: choose_op1 = rs1_value_e;
            2'd2: choose_op1 = imm_e1;
            2'd3: choose_op1 = pc_e1; // 実際はこれない。
        endcase
    end
    endfunction

    function [31:0] choose_op2;
    input [31:0] rs1_value_e;
    input [31:0] rs2_value_e;
    input [31:0] imm_e1;
    input [1:0] aluop2_type_e;
    input [31:0] pc_e1;
    begin
        case (aluop2_type_e)
            2'd0: choose_op2 = 32'd0; // 実際はこれない。
            2'd1: choose_op2 = rs2_value_e;
            2'd2: choose_op2 = imm_e1;
            2'd3: choose_op2 = pc_e1;
        endcase
    end
    endfunction

    assign rs2_data = rs2_value_e;
    assign op1 = choose_op1(rs1_value_e, rs2_value_e, imm_e1, aluop1_type_e, pc_e1);
    assign op2 = choose_op2(rs1_value_e, rs2_value_e, imm_e1, aluop2_type_e, pc_e1);
    assign imm_e2 = imm_e1;
    assign pc_e2 = pc_e1;

endmodule
