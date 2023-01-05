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

module register_file( // 完成。
    input wire clk,
    input wire [4:0] rs1_addr,
    input wire [4:0] rs2_addr,
    input wire [4:0] store_addr,
    input wire [31:0] store_value,
    input wire is_write_w,
    input wire is_decode_stage,
    input wire is_write_stage,

    output reg [31:0] rs1_value,
    output reg [31:0] rs2_value

);
    reg [31:0] register [0:31];
    initial register[0] = 32'd0;

    always @(posedge clk) begin
        // if (is_decode_stage) begin
            rs1_value <= register[rs1_addr];
            rs2_value <= register[rs2_addr];
        // end
        // else if (is_write_stage) begin
            if (is_write_w) begin 
                if (store_addr != 5'd0) register[store_addr] <= store_value;
            end
        // end
    end
endmodule
