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


// Fetch
module F(input wire clk, input wire enable, input wire cpu_resetn, input wire[31:0] pc_m, output wire [31:0] pc_f, output wire [31:0] next_pc);
    reg [31:0] reg_pc;
    initial reg_pc = 32'h8000; // 8000
    reg [2:0] reg_cnt;
    initial reg_cnt = 3'd0;
    always @(posedge clk) begin
        // if (enable) begin
            if (!cpu_resetn) reg_pc <= 32'h8000; // 8000
            else if (reg_cnt < 3'd4) begin
                reg_cnt <= reg_cnt + 3'd1;
                if (reg_cnt == 3'd0) reg_pc <= 32'h8008;
                else reg_pc <= reg_pc + 32'd4;
            end
            else reg_pc <= pc_m;
        // end
    end
    assign pc_f = reg_pc;
    assign next_pc = reg_pc;
endmodule