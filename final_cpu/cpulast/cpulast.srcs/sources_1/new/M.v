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


// // Memory
// module M(input wire clk, input wire enable, input wire[31:0] new_pc,
// input wire [31:0] alu_result, input wire [31:0] rs2_data, 
// input wire is_load_e, input wire is_store_e, input wire [4:0] rd_addr_e,
// input wire reg_we_e, input wire [5:0] alucode_store,
// output wire [31:0] pc_m, output wire [31:0] alu_result_m1,
// output wire [4:0] rd_addr_m, output wire reg_we_m, output wire is_load_m, output wire is_store_m,
// output wire [31:0] alu_result_m2, output wire [31:0] rs2_data_m, output wire [5:0] store_code);
//     reg [31:0] reg_new_pc;
//     reg [31:0] reg_alu_result;
//     reg [31:0] reg_rs2_data;
//     reg reg_is_load;
//     reg reg_is_store;
//     reg [4:0] reg_rd_addr_e;
//     reg reg_reg_we_e;
//     reg [5:0] reg_store_code;

//     always @(posedge clk) begin
//         if (enable) begin
//             reg_new_pc <= new_pc;
//             reg_alu_result <= alu_result;
//             reg_rs2_data <= rs2_data;
//             reg_is_load <= is_load_e;
//             reg_is_store <= is_store_e;
//             reg_rd_addr_e <= rd_addr_e;
//             reg_reg_we_e <= reg_we_e;
//             reg_store_code <= alucode_store;
//             // $display("Memory");
//             // $display(reg_alu_result);
//             // $display(reg_rd_addr_e);
//         end
//     end
//     assign pc_m = reg_new_pc;
//     assign alu_result_m1 = reg_alu_result;
//     assign alu_result_m2 = reg_alu_result;
//     assign rd_addr_m = reg_rd_addr_e;
//     assign reg_we_m = reg_reg_we_e;
//     assign is_load_m = reg_is_load;
//     assign is_store_m = reg_is_store;
//     assign rs2_data_m = reg_rs2_data;
//     assign store_code = reg_store_code;
// endmodule

// Memory
module M(input wire[31:0] new_pc,
input wire [31:0] alu_result, input wire [31:0] rs2_data, 
input wire is_load_e, input wire is_store_e, input wire [4:0] rd_addr_e,
input wire reg_we_e, input wire [5:0] alucode_store,
output wire [31:0] pc_m, output wire [31:0] alu_result_m1,
output wire [4:0] rd_addr_m, output wire reg_we_m, output wire is_load_m, output wire is_store_m,
output wire [31:0] alu_result_m2, output wire [31:0] rs2_data_m, output wire [5:0] store_code, 
output wire [5:0] store_code_m, output wire is_stored, output wire [31:0] rs2_data_m2, output wire [1:0] alu_last);

function [31:0] get_memory_address;
    input [31:0] alu_result;
    input is_load_e;
    input is_store_e;
    begin
        // if (is_load_e) begin
        // get_memory_address = (is_load_e == 1'd1) ? (alu_result[1:0] == 2'd0) ? alu_result_m2 >> 32'd2 :
        // (alu_result[1:0] == 2'd1) ? (alu_result - 32'd1) >> 32'd2 :
        // (alu_result[1:0] == 2'd2) ? (alu_result - 32'd2) >> 32'd2 :
        // (alu_result[1:0] == 2'd3) ? (alu_result - 32'd3) >> 32'd2 : 
        // (is_store_e == 1'd1) ? (alu_result[1:0] == 2'd0) ? alu_result >> 32'd2 :
        // (alu_result[1:0] == 2'd1) ? (alu_result - 32'd1) >> 32'd2 : 
        // (alu_result[1:0] == 2'd2) ? (alu_result - 32'd2) >> 32'd2 :
        // (alu_result[1:0] == 2'd3) ? (alu_result - 32'd3) >> 32'd2 : 
        // 32'd0 : 32'd0;
        // end
        if (is_load_e) begin
            case(alu_result[1:0])
                2'd0: get_memory_address = alu_result >> 32'd2;
                2'd1: get_memory_address = (alu_result - 32'd1) >> 32'd2;
                2'd2: get_memory_address = (alu_result - 32'd2) >> 32'd2;
                default: get_memory_address = (alu_result - 32'd3) >> 32'd2;
            endcase
        end
        else if (is_store_e) begin
            case(alu_result[1:0])
                2'd0: get_memory_address = alu_result >> 32'd2;
                2'd1: get_memory_address = (alu_result - 32'd1) >> 32'd2;
                2'd2: get_memory_address = (alu_result - 32'd2) >> 32'd2;
                default: get_memory_address = (alu_result - 32'd3) >> 32'd2;
            endcase
        end
    end
endfunction

    assign pc_m = new_pc;
    assign alu_result_m1 = alu_result;
    assign alu_result_m2 = get_memory_address(alu_result, is_load_e, is_store_e);
    // assign alu_result_m2 = (is_load_e == 1'd1) ? (alu_result[1:0] == 2'd0) ? alu_result >> 32'd2 :
    //                         (alu_result[1:0] == 2'd1) ? (alu_result - 32'd1) >> 32'd2 :
    //                         (alu_result[1:0] == 2'd2) ? (alu_result - 32'd2) >> 32'd2 :
    //                         (alu_result[1:0] == 2'd3) ? (alu_result - 32'd3) >> 32'd2 : 
    //                         (is_store_e == 1'd1) ? (alu_result[1:0] == 2'd0) ? alu_result >> 32'd2 :
    //                         (alu_result[1:0] == 2'd1) ? (alu_result - 32'd1) >> 32'd2 : 
    //                         (alu_result[1:0] == 2'd2) ? (alu_result - 32'd2) >> 32'd2 :
    //                         (alu_result[1:0] == 2'd3) ? (alu_result - 32'd3) >> 32'd2 :
    //                         32'd0;
    assign rd_addr_m = rd_addr_e;
    assign reg_we_m = reg_we_e;
    assign is_load_m = is_load_e;
    assign is_store_m = is_store_e;
    assign rs2_data_m = rs2_data;
    assign store_code = alucode_store;
    assign store_code_m = alucode_store;
    assign is_stored = is_store_e;
    assign rs2_data_m2 = rs2_data;
    assign alu_last = alu_result[1:0];
endmodule
