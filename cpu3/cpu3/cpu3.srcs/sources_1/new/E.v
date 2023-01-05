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


// Excecute
module E(input wire clk, input wire enable, input wire[31:0] pc_d,
input wire [4:0] rd_addr, input wire [31:0] imm, input wire [5:0] alucode,
input wire [1:0] aluop1_type, input wire [1:0] aluop2_type, input wire reg_we,
input wire is_load, input wire is_store,
output wire is_load_e, output wire is_store_e, output wire [4:0] rd_addr_e, output wire reg_we_e, output wire [5:0] alucode_store,
output wire [31:0] pc_e1, output wire [31:0] imm_e1, output wire [1:0] aluop1_type_e, output wire [1:0] aluop2_type_e, 
output wire [5:0] alucode_e,
output wire [5:0] alucode_pc,
output wire is_load_e2, output wire is_store_e2, output wire [5:0] alucode_store_2);
    reg [31:0] reg_pc_e;
    reg [4:0] reg_rd_addr;
    reg [31:0] reg_imm;
    reg [5:0] reg_alucode;
    reg [1:0] reg_aluop1_type;
    reg [1:0] reg_aluop2_type;
    reg reg_reg_we;
    reg reg_load;
    reg reg_store;

    always @(posedge clk) begin
        if (enable) begin
            reg_pc_e <= pc_d;
            reg_rd_addr <= rd_addr;
            reg_imm <= imm;
            reg_alucode <= alucode;
            reg_aluop1_type <= aluop1_type;
            reg_aluop2_type <= aluop2_type;
            reg_reg_we <= reg_we;
            reg_load <= is_load;
            reg_store <= is_store;
        end
    end
    assign pc_e1 = reg_pc_e;
    assign imm_e1 = reg_imm;
    assign aluop1_type_e = reg_aluop1_type;
    assign aluop2_type_e = reg_aluop2_type;

    assign is_load_e = reg_load;
    assign is_store_e = reg_store;
    assign rd_addr_e = reg_rd_addr;
    assign reg_we_e = reg_reg_we;
    assign alucode_store = reg_alucode;

    assign alucode_e = reg_alucode;
    assign alucode_pc = reg_alucode;

    assign is_load_e2 = reg_load;
    assign is_store_e2 = reg_store;
    assign alucode_store_2 = reg_alucode;
endmodule