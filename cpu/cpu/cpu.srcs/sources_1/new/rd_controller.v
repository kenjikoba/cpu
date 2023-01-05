
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


module rd_controller( //　完成。
    input wire [31:0] rd_value,
    input wire is_loaded,
    input wire [31:0] alu_result_m1,
    input wire [4:0] rd_addr_m,
    input wire reg_we_m,

    output wire [31:0] store_value_m,
    output wire [4:0] store_addr_m,
    output wire is_write_m
);
    function [31:0] get_store;
    input [31:0] rd_value;
    input is_loaded;
    input [31:0] alu_result_m1;
    begin
        if (is_loaded) get_store = rd_value;
        else get_store = alu_result_m1;
    end
    endfunction

    assign store_value_m = get_store(rd_value, is_loaded, alu_result_m1);
    assign store_addr_m = rd_addr_m;
    assign is_write_m = reg_we_m;

endmodule