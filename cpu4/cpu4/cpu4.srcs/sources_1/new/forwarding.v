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


module forwarding(
    input wire [4:0] addr_1, input wire [4:0] addr_2,
    input wire [31:0] pp_value, input wire [4:0] pp_addr, input wire pp_write,
    input wire [31:0] p_value, input wire [4:0] p_addr, input wire p_write,
    output wire [31:0] addr_v_1, output wire [31:0] addr_v_2, output wire is_1, output wire is_2
    );
    assign addr_v_1 = (p_addr == addr_1) ? p_value : (pp_addr == addr_1) ? pp_value : 32'd0;
    assign addr_v_2 = (p_addr == addr_2) ? p_value : (pp_addr == addr_2) ? pp_value : 32'd0;
    assign is_1 = (p_write == 1'd1) ? (p_addr == addr_1) ? 1'd1 : 1'd0 : (pp_write == 1'd1) ? (pp_addr == addr_1) ? 1'd1 : 1'd0 : 1'd0;
    assign is_2 = (p_write == 1'd1) ? (p_addr == addr_2) ? 1'd1 : 1'd0 : (pp_write == 1'd1) ? (pp_addr == addr_2) ? 1'd1 : 1'd0 : 1'd0;
endmodule
