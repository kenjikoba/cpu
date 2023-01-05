
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
    input wire [31:0] memory_value,
    input wire is_load_m2,
    input wire [31:0] alu_result_m1,
    input wire [4:0] rd_addr_m,
    input wire reg_we_m,
    input wire [5:0] store_code_m,
    input wire is_stored,
    input [31:0] rs2_data_m2,

    output wire [31:0] store_value,
    output wire [4:0] store_addr,
    output wire is_write_w,

    // uart
    input wire uart_OUT_data,
    output wire [7:0] uart_IN_data,
    output wire uart_we,
    output wire uart_tx,

    // hardware_counter
    input wire [31:0] hc_OUT_data
);
    function [31:0] get_store;
    input [31:0] memory_value;
    input is_load_m2;
    input [31:0] alu_result_m1;
    input [5:0] store_code_m;
    input is_stored;
    input [31:0] rs2_data_m2;
    begin
        get_store = (is_load_m2) ? (alu_result_m1[1:0] == 2'd0) ? (store_code_m == 6'd9) ? {{24{memory_value[7]}}, memory_value[7:0]} :
        (store_code_m == 6'd10) ? {{16{memory_value[15]}}, memory_value[15:0]} :
        (store_code_m == 6'd11) ? (alu_result_m1[31:0] == 32'hffffff00) ? hc_OUT_data[31:0] : memory_value[31:0] :
        (store_code_m == 6'd12) ? {{24{1'd0}}, memory_value[7:0]} : {{16{1'd0}}, memory_value[15:0]} :
        (alu_result_m1[1:0] == 2'd1) ? (store_code_m == 6'd9) ? {{24{memory_value[15]}}, memory_value[15:8]} :
        (store_code_m == 6'd10) ? {{16{memory_value[23]}}, memory_value[23:8]} :
        (store_code_m == 6'd12) ? {{24{1'd0}}, memory_value[15:8]} :
        (store_code_m == 6'd13) ? {{16{1'd0}}, memory_value[23:8]} : 32'd0 :
        (alu_result_m1[1:0] == 2'd2) ? (store_code_m == 6'd9) ? {{24{memory_value[23]}}, memory_value[23:16]} :
        (store_code_m == 6'd10) ? {{16{memory_value[31]}}, memory_value[31:16]} :
        (store_code_m == 6'd12) ? {{24{1'd0}}, memory_value[23:16]} :
        (store_code_m == 6'd13) ? {{16{1'd0}}, memory_value[31:16]} : 32'd0 :
        (store_code_m == 6'd9) ? {{24{memory_value[31]}}, memory_value[31:24]} :
        (store_code_m == 6'd12) ? {{24{1'd0}}, memory_value[31:24]} : 32'd0 : alu_result_m1;
    end
    endfunction

    assign store_value = get_store(memory_value, is_load_m2, alu_result_m1, store_code_m, is_stored, rs2_data_m2);
    assign store_addr = rd_addr_m;
    assign is_write_w = reg_we_m;
    // // Memory Accessステージに以下のような記述を追加
    assign uart_IN_data = rs2_data_m2[7:0];  // ストアするデータをモジュールへ入力
    assign uart_we = ((alu_result_m1 == 32'hf6fff070) && (is_stored == 1'd1)) ? 1'b1 : 1'b0;  // シリアル通信用アドレスへのストア命令実行時に送信開始信号をアサート
    assign uart_tx = uart_OUT_data;  // シリアル通信モジュールの出力はFPGA外部へと出力

endmodule