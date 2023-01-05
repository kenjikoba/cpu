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


// Write
module W(input wire clk, input wire enable, input wire[31:0] pc_m,
input wire [31:0] store_value_m, input wire [4:0] store_addr_m, 
input wire is_write_m,
output wire [31:0] pc_w, output wire [31:0] store_value, output wire [4:0] store_addr, output wire is_write_w);
    reg [31:0] reg_pc_m;
    reg [31:0] reg_store_value;
    reg [4:0] reg_store_addr;
    reg reg_is_write_m;

    always @(posedge clk) begin
        if (enable) begin
            reg_pc_m <= pc_m;
            reg_store_value <= store_value_m;
            reg_store_addr <= store_addr_m;
            reg_is_write_m <= is_write_m;
        end
    end
    assign pc_w = reg_pc_m;
    assign store_value = reg_store_value;
    assign store_addr = reg_store_addr;
    assign is_write_w = reg_is_write_m;
endmodule

// // Write
// module W(input wire[31:0] pc_m,
// input wire [31:0] store_value_m, input wire [4:0] store_addr_m, 
// input wire is_write_m,
// output wire [31:0] pc_w, output wire [31:0] store_value, output wire [4:0] store_addr, output wire is_write_w);

//     assign pc_w = pc_m;
//     assign store_value = store_value_m;
//     assign store_addr = store_addr_m;
//     assign is_write_w = is_write_m;
// endmodule