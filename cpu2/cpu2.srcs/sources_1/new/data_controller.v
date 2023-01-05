`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/12/16 18:43:44
// Design Name: 
// Module Name: rs1_rs2_controller
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


module data_controller(
    input wire [31:0] rs2_data_2, input wire [31:0] alu_result_2, 
    input wire is_load_e2, input wire is_store_e2, input wire [5:0] alucode_store_2,
    output wire is_load_m, output wire is_store_m, output wire [31:0] alu_result_mem,
    output wire [1:0] alu_last, output wire [31:0] rs2_data_m, output wire [5:0] store_code
    );

function [31:0] get_memory_address;
    input [31:0] alu_result_2;
    input is_load_e2;
    input is_store_e2;
    begin
        if (is_load_e2) begin
            case(alu_result_2[1:0])
                2'd0: get_memory_address = alu_result_2 >> 32'd2;
                2'd1: get_memory_address = (alu_result_2 - 32'd1) >> 32'd2;
                2'd2: get_memory_address = (alu_result_2 - 32'd2) >> 32'd2;
                default: get_memory_address = (alu_result_2 - 32'd3) >> 32'd2;
            endcase
        end
        else if (is_store_e2) begin
            case(alu_result_2[1:0])
                2'd0: get_memory_address = alu_result_2 >> 32'd2;
                2'd1: get_memory_address = (alu_result_2 - 32'd1) >> 32'd2;
                2'd2: get_memory_address = (alu_result_2 - 32'd2) >> 32'd2;
                default: get_memory_address = (alu_result_2 - 32'd3) >> 32'd2;
            endcase
        end
    end
endfunction
    assign is_load_m = is_load_e2;
    assign is_store_m = is_store_e2;
    assign alu_result_mem = get_memory_address(alu_result_2, is_load_e2, is_store_e2);
    assign alu_last = alu_result_2[1:0];
    assign rs2_data_m = rs2_data_2;
    assign store_code = alucode_store_2;
endmodule
