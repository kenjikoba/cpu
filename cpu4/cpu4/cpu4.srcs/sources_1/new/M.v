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


// Memory
module M(input wire clk, input wire enable, input wire[31:0] new_pc,
input wire [31:0] alu_result, input wire [31:0] rs2_data, 
input wire is_load_e, input wire is_store_e, input wire [4:0] rd_addr_e,
input wire reg_we_e, input wire [5:0] alucode_store,
output wire [31:0] pc_m, output wire [31:0] alu_result_m1,
output wire [4:0] rd_addr_m, output wire reg_we_m, output wire is_load_m2, output wire is_stored,
output wire [31:0] rs2_data_m2, output wire [5:0] store_code_m);
    reg [31:0] reg_new_pc;
    reg [31:0] reg_alu_result;
    reg [31:0] reg_rs2_data;
    reg reg_is_load;
    reg reg_is_store;
    reg [4:0] reg_rd_addr_e;
    reg reg_reg_we_e;
    reg [5:0] reg_store_code;

    always @(posedge clk) begin
        // if (enable) begin
            reg_new_pc <= new_pc;
            reg_alu_result <= alu_result;
            reg_rs2_data <= rs2_data;
            reg_is_load <= is_load_e;
            reg_is_store <= is_store_e;
            reg_rd_addr_e <= rd_addr_e;
            reg_reg_we_e <= reg_we_e;
            reg_store_code <= alucode_store;
        // end
    end
    assign pc_m = reg_new_pc;
    assign alu_result_m1 = reg_alu_result;
    assign rd_addr_m = reg_rd_addr_e;
    assign reg_we_m = reg_reg_we_e;
    assign is_load_m2 = reg_is_load;
    assign is_stored = reg_is_store;
    assign rs2_data_m2 = reg_rs2_data;
    assign store_code_m = reg_store_code;
endmodule