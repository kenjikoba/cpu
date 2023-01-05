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
module data_memory(clk, data_enable, is_load_m, is_store_m, alu_result_mem, alu_last, rs2_data_m, store_code, memory_value);  // データメモリ
        input wire clk;
        input wire data_enable;
        input wire is_load_m; 
        input wire is_store_m;
        input wire [31:0] alu_result_mem;
        input wire [1:0] alu_last;
        input wire [31:0] rs2_data_m;
        input wire [5:0] store_code;

        output reg [31:0] memory_value;
        
        // // load and store only
        reg [31:0] memory [0:32768]; // 32768,16384
        // initial $readmemh("/home/denjo/b3exp/benchmarks/Coremarkm/data.hex", memory);
        initial $readmemh("/home/denjo/b3exp/benchmarks/Coremark_for_Synthesis_m/data.hex", memory);

        always @(posedge clk) begin // メモリアドレスは他のモジュールでできそう。
            if (data_enable) begin
                if (is_load_m) memory_value[31:0] <= memory[alu_result_mem][31:0];
                else if (is_store_m) begin
                    case(alu_last)
                        2'd0: begin
                            if (store_code == 6'd14) memory[alu_result_mem][7:0] <= rs2_data_m[7:0];
                            else if (store_code == 6'd15) memory[alu_result_mem][15:0] <= rs2_data_m[15:0]; // Sh
                            else memory[alu_result_mem][31:0] <= rs2_data_m[31:0]; // Sw
                        end
                        2'd1: begin
                            if (store_code == 6'd14) memory[alu_result_mem][15:8] <= rs2_data_m[7:0]; // Sb
                            else memory[alu_result_mem][23:8] <= rs2_data_m[15:0]; // Sh
                        end
                        2'd2: begin
                            if (store_code == 6'd14) memory[alu_result_mem][23:16] <= rs2_data_m[7:0]; // Sb
                            else memory[alu_result_mem][31:16] <= rs2_data_m[15:0]; // Sh
                        end
                        default: memory[alu_result_mem][31:24] <= rs2_data_m[7:0]; // Sb
                    endcase
                end
            end
        end
endmodule