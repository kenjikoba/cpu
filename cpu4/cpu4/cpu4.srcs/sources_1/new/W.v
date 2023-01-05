`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/12/19 16:02:42
// Design Name: 
// Module Name: forwarding
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


module W(
    input wire clk, input wire enable,
    input wire [31:0] value_w, input wire [4:0] addr_w, input wire write_w,
    input wire [31:0] pc_m,
    output wire [31:0] pp_value, output wire [4:0] pp_addr, output wire pp_write,
    output wire [31:0] pc_w
    );
    reg [31:0] pp_value_reg;
    reg [4:0] pp_addr_reg;
    reg pp_write_reg;
    reg [31:0] pc_w_reg;
    always @(posedge clk) begin
        // if (enable) begin
            pp_value_reg <= value_w;
            pp_addr_reg <= addr_w;
            pp_write_reg <= write_w;
            pc_w_reg <= pc_m;
        // end
    end
    assign pp_value = pp_value_reg;
    assign pp_addr = pp_addr_reg;
    assign pp_write = pp_write_reg;
    assign pc_w = pc_w_reg;
endmodule
