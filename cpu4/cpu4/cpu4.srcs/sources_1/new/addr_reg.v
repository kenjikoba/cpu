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


module addr_reg(
    input wire clk, input wire enable,
    input wire [4:0] addr_d_1, input wire [4:0] addr_d_2,
    output wire [4:0] addr_1, output wire [4:0] addr_2
    );
    reg [31:0] addr_1_reg;
    reg [31:0] addr_2_reg;
    always @(posedge clk) begin
        // if (enable) begin
            addr_1_reg <= addr_d_1;
            addr_2_reg <= addr_d_2;
        // end
    end
    assign addr_1 = addr_1_reg;
    assign addr_2 = addr_2_reg;
endmodule
