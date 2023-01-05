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


// Decode
module D(input wire clk, input wire enable, input wire [31:0] ir_f, input wire[31:0] pc_f, 
output wire [31:0] ir_d, output wire [31:0] pc_d);
    reg [31:0] pc_reg;
    reg [31:0] ir_reg;
    always @(posedge clk) begin
        // if (enable) begin
            pc_reg <= pc_f;
            ir_reg <= ir_f;
        // end
    end
    assign pc_d = pc_reg;
    assign ir_d = ir_reg;
endmodule

// // Decode
// module D(input wire [31:0] ir_f, input wire[31:0] pc_f, 
// output wire [31:0] ir_d, output wire [31:0] pc_d);
//     assign pc_d = pc_f;
//     assign ir_d = ir_f;
// endmodule
