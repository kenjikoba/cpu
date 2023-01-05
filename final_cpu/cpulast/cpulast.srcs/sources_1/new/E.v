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


// // Excecute
// module E(input wire clk, input wire enable, input wire[31:0] pc_d,
// input wire [31:0] rs1_value, input wire [31:0] rs2_value, 
// input wire [4:0] rd_addr, input wire [31:0] imm, input wire [5:0] alucode,
// input wire [1:0] aluop1_type, input wire [1:0] aluop2_type, input wire reg_we,
// input wire is_load, input wire is_store, input wire is_halt,
// output wire is_load_e, output wire is_store_e, output wire [4:0] rd_addr_e, output wire reg_we_e,
// output wire [31:0] pc_e1, output wire [31:0] rs1_value_e, output wire [31:0] rs2_value_e, 
// output wire [31:0] imm_e1, output wire [1:0] aluop1_type_e, output wire [1:0] aluop2_type_e, 
// output wire [5:0] alucode_e, output wire [5:0] alucode_store);
//     reg [31:0] reg_pc_e;
//     reg [31:0] reg_rs1_value;
//     reg [31:0] reg_rs2_value;
//     reg [4:0] reg_rd_addr;
//     reg [31:0] reg_imm;
//     reg [5:0] reg_alucode;
//     reg [1:0] reg_aluop1_type;
//     reg [1:0] reg_aluop2_type;
//     reg reg_reg_we;
//     reg reg_load;
//     reg reg_store;

//     always @(posedge clk) begin
//         if (enable) begin
//             reg_pc_e <= pc_d;
//             reg_rs1_value <= rs1_value;
//             reg_rs2_value <= rs2_value;
//             reg_rd_addr <= rd_addr;
//             reg_imm <= imm;
//             reg_alucode <= alucode;
//             reg_aluop1_type <= aluop1_type;
//             reg_aluop2_type <= aluop2_type;
//             reg_reg_we <= reg_we;
//             reg_load <= is_load;
//             reg_store <= is_store;
//         end
//     end
//     assign pc_e1 = reg_pc_e;
//     assign rs1_value_e = reg_rs1_value;
//     assign rs2_value_e = reg_rs2_value;
//     assign rd_addr_e = reg_rd_addr;
//     assign imm_e1 = reg_imm;
//     assign alucode_e = reg_alucode;
//     assign aluop1_type_e = reg_aluop1_type;
//     assign aluop2_type_e = reg_aluop2_type;
//     assign reg_we_e = reg_reg_we;
//     assign is_load_e = reg_load;
//     assign is_store_e = reg_store;
//     assign alucode_store = reg_alucode;
// endmodule


// Excecute
module E(input wire[31:0] pc_d,
input wire [31:0] rs1_value, input wire [31:0] rs2_value, 
input wire [4:0] rd_addr, input wire [31:0] imm, input wire [5:0] alucode,
input wire [1:0] aluop1_type, input wire [1:0] aluop2_type, input wire reg_we,
input wire is_load, input wire is_store, input wire is_halt,
output wire is_load_e, output wire is_store_e, output wire [4:0] rd_addr_e, output wire reg_we_e,
output wire [31:0] pc_e1, output wire [31:0] rs1_value_e, output wire [31:0] rs2_value_e, 
output wire [31:0] imm_e1, output wire [1:0] aluop1_type_e, output wire [1:0] aluop2_type_e, 
output wire [5:0] alucode_e, output wire [5:0] alucode_store, output wire [5:0] alucode_pc,
output wire [31:0] rs1_value_pc);

    assign pc_e1 = pc_d;
    assign rs1_value_e = rs1_value;
    assign rs2_value_e = rs2_value;
    assign rd_addr_e = rd_addr;
    assign imm_e1 = imm;
    assign alucode_e = alucode;
    assign aluop1_type_e = aluop1_type;
    assign aluop2_type_e = aluop2_type;
    assign reg_we_e = reg_we;
    assign is_load_e = is_load;
    assign is_store_e = is_store;
    assign alucode_store = alucode;
    assign alucode_pc = alucode;
    assign rs1_value_pc = rs1_value;
endmodule