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
    output wire         is_halt                                     
);

// assign srcreg1_num = 5'd10;

function [4:0] get_r1;
    input [6:0] opcode;
    input [4:0] r1;
    begin
        case (opcode)
            `LUI: get_r1 = 5'd0;
            `AUIPC: get_r1 = 5'd0;
            `JAL: get_r1 = 5'd0;
            default: get_r1 = r1;
        endcase
        // $display(get_r1);
    end
endfunction

function [4:0] get_r2;
    input [6:0] opcode;
    input [4:0] r2;
    begin
        case (opcode)
            `OPIMM: get_r2 = 5'd0;
            `LUI: get_r2 = 5'd0;
            `AUIPC: get_r2 = 5'd0;
            `JAL: get_r2 = 5'd0;
            `JALR: get_r2 = 5'd0;
            `LOAD: get_r2 = 5'd0;
            default: get_r2 = r2;
        endcase
        // $display(get_r2);
    end
endfunction

function [4:0] get_rd;
    input [6:0] opcode;
    input [4:0] rd;
    begin
        case (opcode)
            `BRANCH: get_rd = 5'd0;
            `STORE: get_rd = 5'd0;
            default: get_rd = rd;
        endcase
        // $display("rd");
        // $display(get_rd);
    end
endfunction

function [31:0] get_imm;
    input [6:0] opcode;
    input [31:0] ir_d;
    input [2:0] func_rec;
    begin
        case (opcode)
            `OPIMM: begin
                case(func_rec)
                    `TYPE_U: begin
                        get_imm[4:0] = ir_d[24:20];
                        get_imm[31:5] = 27'd0;
                    end
                    `TYPE_S: begin
                        get_imm[4:0] = ir_d[24:20];
                        get_imm[31:5] = 27'd0;
                    end
                    default: begin
                        get_imm[11:0] = ir_d[31:20];
                        case(get_imm[11])
                            1'd0: get_imm[31:12] = 20'd0;
                            1'd1: get_imm[31:12] = 20'b11111111111111111111;
                        endcase
                    end
                endcase
            end
            `OP: get_imm = 32'd0;
            `LUI: begin
                get_imm[31:12] = ir_d[31:12];
                get_imm[11:0] = 12'd0;
            end
            `AUIPC: begin
                get_imm[31:12] = ir_d[31:12];
                get_imm[11:0] = 12'd0;
            end
            `JAL: begin
                get_imm[20] = ir_d[31];
                get_imm[10:1] = ir_d[30:21];
                get_imm[11] = ir_d[20];
                get_imm[19:12] = ir_d[19:12];
                get_imm[0] = 1'd0;
                if (ir_d[31]) get_imm[31:21] = 11'b11111111111;
                else get_imm[31:21] = 11'd0;
            end
            `JALR: begin
                get_imm[31:12] = 20'd0;
                get_imm[11:0] = ir_d[31:20];
                if (ir_d[31]) get_imm[31:12] = 20'b11111111111111111111;
                else get_imm[31:12] = 20'd0;
            end
            `BRANCH: begin
                get_imm[12] = ir_d[31];
                get_imm[10:5] = ir_d[30:25];
                get_imm[4:1] = ir_d[11:8];
                get_imm[11] = ir_d[7];
                get_imm[0] = 1'd0;
                case(get_imm[12])
                    1'd0: get_imm[31:13] = 19'd0;
                    1'd1: get_imm[31:13] = 19'b1111111111111111111;
                    default:;
                endcase
            end
            `STORE: begin
                get_imm[11:5] = ir_d[31:25];
                get_imm[4:0] = ir_d[11:7];
                case(get_imm[11])
                    1'd0: get_imm[31:12] = 20'd0;
                    1'd1: get_imm[31:12] = 20'b11111111111111111111;
                    default:;
                endcase
            end
            `LOAD: begin
                get_imm[11:0] = ir_d[31:20];
                case(get_imm[11])
                    1'd0: get_imm[31:12] = 20'd0;
                    1'd1: get_imm[31:12] = 20'b11111111111111111111;
                    default:;
                endcase
            end
            default: get_imm = 32'd0;
        endcase
        // $display("imm");
        // $display(get_imm);
    end
endfunction

function [5:0] get_alucode;
    input [6:0] opcode;
    input [2:0] func_rec;
    input lastbit;
    begin
        case (opcode)
            `OPIMM: begin
                case(func_rec)
                    `TYPE_NONE: get_alucode = 6'd17; // ADDi
                    `TYPE_J: get_alucode = 6'd19; // SLTi
                    `TYPE_I: get_alucode = 6'd20; // SLTiu
                    `TYPE_B: get_alucode = 6'd21; // XORi
                    `TYPE_R: get_alucode = 6'd22; // ORi
                    `TYPE_U: get_alucode = 6'd24; // SLLi
                    `TYPE_S: begin // SRLi&SRAi
                        case(lastbit)
                            1'b0: get_alucode = 6'd25; // SRLi
                            1'b1: get_alucode = 6'd26; // SRAi
                        endcase
                    end
                    default: get_alucode = 6'd23; // ANDi
                endcase
            end
            `OP: begin
                case(func_rec)
                    `TYPE_NONE: begin // ADD&SUB
                        case(lastbit)
                            1'b0: get_alucode = 6'd17; // ADD
                            1'b1: get_alucode = 6'd18; // SUB
                        endcase
                    end
                    `TYPE_U: get_alucode = 6'd24; // SLL
                    `TYPE_J: get_alucode = 6'd19; // SLT
                    `TYPE_I: get_alucode = 6'd20; // SLTu
                    `TYPE_B: get_alucode = 6'd21; // XOR
                    `TYPE_S: begin // SRL&SRA
                        case(lastbit)
                            1'b0: get_alucode = 6'd25; // SRL
                            1'b1: get_alucode = 6'd26; // SRA
                        endcase
                    end
                    `TYPE_R: get_alucode = 6'd22; // OR
                    default: get_alucode = 6'd23; // ANDと例外
                endcase
            end
            `LUI: get_alucode = 6'd0; // LUi
            `AUIPC: get_alucode = 6'd17; // AUiPC
            `JAL: get_alucode = 6'd1; // JAL
            `JALR: get_alucode = 6'd2; // JALR
            `BRANCH: begin
                case(func_rec)
                    `TYPE_NONE: get_alucode = 6'd3; // Beq
                    `TYPE_U: get_alucode = 6'd4; // Bne
                    `TYPE_B: get_alucode = 6'd5; // Blt
                    `TYPE_S: get_alucode = 6'd6; // Bge
                    `TYPE_R: get_alucode = 6'd7; // Bltu
                    default: get_alucode = 6'd8; // Bgeuと例外
                endcase
            end
            `STORE: begin
                case(func_rec)
                    `TYPE_NONE: get_alucode = 6'd14; // Sb
                    `TYPE_U: get_alucode = 6'd15; // Sh
                    `TYPE_J: get_alucode = 6'd16; // Sw
                    default: get_alucode = 6'd0; // 例外
                endcase
            end
            `LOAD: begin
                case(func_rec)
                    `TYPE_NONE: get_alucode = 6'd9; // Lb
                    `TYPE_U: get_alucode = 6'd10; // Lh
                    `TYPE_J: get_alucode = 6'd11; // Lw
                    `TYPE_B: get_alucode = 6'd12; // Lbu
                    `TYPE_S: get_alucode = 6'd13; // Lhu
                    default: get_alucode = 6'd0; // 例外
                endcase
            end
            default: get_alucode = 6'd0; // 例外
        endcase
        // $display("get_alucode");
        // $display(get_alucode);
    end
endfunction

function [1:0] get_op1type;
    input [6:0] opcode;
    begin
        case (opcode)
            `LUI: get_op1type = 2'd0;
            `AUIPC: get_op1type = 2'd2;
            `JAL: get_op1type = 2'd0;
            default: get_op1type = 2'd1;
        endcase
    end
endfunction

function [1:0] get_op2type;
    input [6:0] opcode;
    begin
        case (opcode)
            `OP: get_op2type = 2'd1;
            `OPIMM: get_op2type = 2'd2;
            `LUI: get_op2type = 2'd2;
            `AUIPC: get_op2type = 2'd3;
            `JAL: get_op2type = 2'd3;
            `JALR: get_op2type = 2'd3;
            `BRANCH: get_op2type = 2'd1;
            `STORE: get_op2type = 2'd2;
            `LOAD: get_op2type = 2'd2;
            default: get_op2type = 2'd0; 
        endcase
    end
endfunction

function get_regwe;
    input [6:0] opcode;
    input [4:0] rd;
    begin
        case (opcode)
            `OP: get_regwe = 1'b1;
            `OPIMM: get_regwe = 1'b1;
            `LUI: get_regwe = 1'b1;
            `AUIPC: get_regwe = 1'b1;
            `JAL: begin
                case(rd)
                    5'd0: get_regwe = 1'b0;
                    default: get_regwe = 1'b1;
                endcase
            end
            `JALR: begin
                case(rd)
                    5'd0: get_regwe = 1'b0;
                    default: get_regwe = 1'b1;
                endcase
            end
            `BRANCH: get_regwe = 1'b0;
            `STORE: get_regwe = 1'b0;
            `LOAD: get_regwe = 1'b1;
            default: get_regwe = 1'b0;
        endcase
    end
endfunction

function get_load;
    input [6:0] opcode;
    begin
        case (opcode)
            `LOAD: get_load = 1'd1;
            default: get_load = 1'd0;
        endcase
    end
endfunction

function get_store;
    input [6:0] opcode;
    begin
        case (opcode)
            `STORE: get_store = 1'd1;
            default: get_store = 1'd0;
        endcase
    end
endfunction

function get_halt;
    input [6:0] opcode;
    begin
        case (opcode)
            default: get_halt = 1'd0;
        endcase
    end
endfunction

assign srcreg1_num = get_r1(ir_d[6:0], ir_d[19:15]);
assign srcreg2_num = get_r2(ir_d[6:0], ir_d[24:20]);
assign dstreg_num = get_rd(ir_d[6:0], ir_d[11:7]);
assign imm = get_imm(ir_d[6:0], ir_d[31:0], ir_d[14:12]); 
assign alucode = get_alucode(ir_d[6:0], ir_d[14:12], ir_d[30]);
assign aluop1_type = get_op1type(ir_d[6:0]);
assign aluop2_type = get_op2type(ir_d[6:0]);
assign reg_we = get_regwe(ir_d[6:0], ir_d[11:7]);
assign is_load = get_load(ir_d[6:0]);
assign is_store = get_store(ir_d[6:0]);
assign is_halt = get_halt(ir_d[6:0]);
endmodule
