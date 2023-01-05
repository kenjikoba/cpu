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


module rs1_rs2_controller(
    input wire [31:0] rs1_value,
    input wire [31:0] rs2_value,
    input wire [31:0] addr_v_1,
    input wire [31:0] addr_v_2,
    input wire is_1,
    input wire is_2,

    output wire [31:0] rs1_value_e, output wire [31:0] rs2_value_e, output wire [31:0] rs2_data, 
    output wire [31:0] rs2_data_2, output wire [31:0] rs1_value_pc
    );
    assign rs1_value_e = (is_1 == 1'd1) ? addr_v_1 : rs1_value;
    assign rs1_value_pc = (is_1 == 1'd1) ? addr_v_1 : rs1_value;
    assign rs2_value_e = (is_2 == 1'd1) ? addr_v_2 : rs2_value;
    assign rs2_data = (is_2 == 1'd1) ? addr_v_2 : rs2_value;
    assign rs2_data_2 = (is_2 == 1'd1) ? addr_v_2 : rs2_value;
endmodule
