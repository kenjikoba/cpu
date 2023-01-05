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

module decoder(
    input  wire [31:0]  ir_d,           // 機械語命令列
    output wire  [4:0]	srcreg1_num,  // ソースレジスタ1番号
    output wire  [4:0]	srcreg2_num,  // ソースレジスタ2番号
    output wire  [4:0]	dstreg_num,   // デスティネーションレジスタ番号
    output wire [31:0]	imm,          // 即値
    output wire   [5:0]	alucode,      // ALUの演算種別
    output wire   [1:0]	aluop1_type,  // ALUの入力タイプ 
    output wire   [1:0]	aluop2_type,  // ALUの入力タイプ
    output wire	     	reg_we,       // レジスタ書き込みの有無     
    output wire		    is_load,      // ロード命令判定フラグ       
    output wire		    is_store,     // ストア命令判定フラグ    
    output wire [4:0] addr_d_1,
    output wire [4:0] addr_d_2                                    
);

assign srcreg1_num = (ir_d[6:0] == `LUI) ? 5'd0 :
                     (ir_d[6:0]  == `AUIPC) ? 5'd0 :
                     (ir_d[6:0] == `JAL) ? 5'd0 :
                     ir_d[19:15]; 
assign srcreg2_num = (ir_d[6:0] == `OPIMM) ? 5'd0 :
                     (ir_d[6:0] == `LUI) ? 5'd0 :
                     (ir_d[6:0] == `AUIPC) ? 5'd0 :
                     (ir_d[6:0] == `JAL) ? 5'd0 :
                     (ir_d[6:0] == `JALR) ? 5'd0 :
                     (ir_d[6:0] == `LOAD) ? 5'd0 :
                     ir_d[24:20];
assign dstreg_num = (ir_d[6:0] == `BRANCH) ? 5'd0 :
                    (ir_d[6:0] == `STORE) ? 5'd0 :
                    ir_d[11:7];
assign imm = (ir_d[6:0] == `OPIMM) ? (ir_d[14:12] == `TYPE_U) ? {{27{1'd0}}, ir_d[24:20]} :
             (ir_d[14:12] == `TYPE_S) ? {{27{1'd0}}, ir_d[24:20]} : {{20{ir_d[31]}}, ir_d[31:20]} :
             (ir_d[6:0] == `OP) ? 32'd0 :
             (ir_d[6:0] == `LUI) ? {ir_d[31:12], {12'd0}} :
             (ir_d[6:0] == `AUIPC) ? {ir_d[31:12], {12'd0}} :
             (ir_d[6:0] == `JAL) ? {{11{ir_d[31]}}, ir_d[31], ir_d[19:12], ir_d[20], ir_d[30:21], {1'b0}} :
             (ir_d[6:0] == `JALR) ? {{20{ir_d[31]}}, ir_d[31:20]} :
             (ir_d[6:0] == `BRANCH) ? {{19{ir_d[31]}}, ir_d[31], ir_d[7], ir_d[30:25], ir_d[11:8], {1'd0}} :
             (ir_d[6:0] == `STORE) ? {{20{ir_d[31]}}, ir_d[31:25], ir_d[11:7]} :
             (ir_d[6:0] == `LOAD) ? {{20{ir_d[31]}}, ir_d[31:20]} :
             32'd0;
assign alucode = (ir_d[6:0] == `OPIMM) ? (ir_d[14:12] == `TYPE_NONE) ? 6'd17 :
                (ir_d[14:12] == `TYPE_J) ? 6'd19 :
                (ir_d[14:12] == `TYPE_I) ? 6'd20 :
                (ir_d[14:12] == `TYPE_B) ? 6'd21 :
                (ir_d[14:12] == `TYPE_R) ? 6'd22 :
                (ir_d[14:12] == `TYPE_U) ? 6'd24 :
                (ir_d[14:12] == `TYPE_S) ? (ir_d[30] == 1'd1) ? 6'd26 : 6'd25 :
                6'd23 :
                (ir_d[6:0] == `OP) ? (ir_d[14:12] == `TYPE_NONE) ? (ir_d[25] == 1'd1) ? 6'd27 : 
                (ir_d[30]  == 1'd1) ? 6'd18 : 6'd17 :
                (ir_d[14:12] == `TYPE_U) ? (ir_d[25] == 1'd1) ? 6'd28 : 6'd24 :
                (ir_d[14:12] == `TYPE_J) ? (ir_d[25] == 1'd1) ? 6'd29 : 6'd19 : 
                (ir_d[14:12] == `TYPE_I) ? (ir_d[25] == 1'd1) ? 6'd30 : 6'd20 :
                (ir_d[14:12] == `TYPE_B) ? (ir_d[25] == 1'd1) ? 6'd31 : 6'd21 :
                (ir_d[14:12] == `TYPE_S) ? (ir_d[25] == 1'd1) ? 6'd32 : (ir_d[30]  == 1'd1) ? 6'd26 : 6'd25 :
                (ir_d[14:12] == `TYPE_R) ? (ir_d[25] == 1'd1) ? 6'd33 : 6'd22 :
                (ir_d[25] == 1'd1) ? 6'd34 : 6'd23 :
                (ir_d[6:0] == `LUI) ? 6'd0 :
                (ir_d[6:0] == `AUIPC) ? 6'd17 :
                (ir_d[6:0] == `JAL) ? 6'd1 :
                (ir_d[6:0] == `JALR) ? 6'd2 :
                (ir_d[6:0] == `BRANCH) ? (ir_d[14:12] == `TYPE_NONE) ? 6'd3 :
                (ir_d[14:12] == `TYPE_U) ? 6'd4 :
                (ir_d[14:12] == `TYPE_B) ? 6'd5 :
                (ir_d[14:12] == `TYPE_S) ? 6'd6 :
                (ir_d[14:12] == `TYPE_R) ? 6'd7 :
                6'd8 :
                (ir_d[6:0] == `STORE) ? (ir_d[14:12] == `TYPE_NONE) ? 6'd14 :
                (ir_d[14:12] == `TYPE_U) ? 6'd15 :
                (ir_d[14:12] == `TYPE_J) ? 6'd16 :
                6'd0 :
                (ir_d[6:0] == `LOAD) ? (ir_d[14:12] == `TYPE_NONE) ? 6'd9 :
                (ir_d[14:12] == `TYPE_U) ? 6'd10 :
                (ir_d[14:12] == `TYPE_J) ? 6'd11 :
                (ir_d[14:12] == `TYPE_B) ? 6'd12 :
                (ir_d[14:12] == `TYPE_S) ? 6'd13 :
                6'd0 :
                6'd0;
assign aluop1_type = (ir_d[6:0] == `LUI) ? 2'd0 :
                    (ir_d[6:0] == `AUIPC) ? 2'd2 :
                    (ir_d[6:0] == `JAL) ? 2'd0 :
                    2'd1;
assign aluop2_type = (ir_d[6:0] == `OP) ? 2'd1 :
                    (ir_d[6:0] == `OPIMM) ? 2'd2 :
                    (ir_d[6:0] == `LUI) ? 2'd2 :
                    (ir_d[6:0] == `AUIPC) ? 2'd3 :
                    (ir_d[6:0] == `JAL) ? 2'd3 :
                    (ir_d[6:0] == `JALR) ? 2'd3 :
                    (ir_d[6:0] == `BRANCH) ? 2'd1 :
                    (ir_d[6:0] == `STORE) ? 2'd2 :
                    (ir_d[6:0] == `LOAD) ? 2'd2 :
                    2'd0;
assign reg_we = (ir_d[6:0] == `OP) ? 1'b1 :
                (ir_d[6:0] == `OPIMM) ? 1'b1 :
                (ir_d[6:0] == `LUI) ? 1'b1 : 
                (ir_d[6:0] == `AUIPC) ? 1'b1 :
                (ir_d[6:0] == `JAL) ? (ir_d[11:7] == 5'd0) ? 1'b0 : 1'b1 :
                (ir_d[6:0] == `JALR) ? (ir_d[11:7] == 5'd0) ? 1'b0 : 1'b1 :
                (ir_d[6:0] == `BRANCH) ? 1'b0 :
                (ir_d[6:0] == `STORE) ? 1'b0 :
                (ir_d[6:0] == `LOAD) ? 1'b1 :
                1'b0;
assign is_load = (ir_d[6:0] == `LOAD) ? 1'd1 : 1'd0;
assign is_store = (ir_d[6:0] == `STORE) ? 1'd1 : 1'd0;
assign addr_d_1 = (ir_d[6:0] == `LUI) ? 5'd0 :
                (ir_d[6:0]  == `AUIPC) ? 5'd0 :
                (ir_d[6:0] == `JAL) ? 5'd0 :
                ir_d[19:15]; 
assign addr_d_2 = (ir_d[6:0] == `OPIMM) ? 5'd0 :
                (ir_d[6:0] == `LUI) ? 5'd0 :
                (ir_d[6:0] == `AUIPC) ? 5'd0 :
                (ir_d[6:0] == `JAL) ? 5'd0 :
                (ir_d[6:0] == `JALR) ? 5'd0 :
                (ir_d[6:0] == `LOAD) ? 5'd0 :
                ir_d[24:20];
endmodule
