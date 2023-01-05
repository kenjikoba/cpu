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
// module data_memory(is_load_m, is_store_m, alu_result_m2, rs2_data_m, store_code, rd_value, is_loaded, mem_2, uart_OUT_data, 
// uart_IN_data, uart_we, uart_tx, hc_OUT_data);  // データメモリ
//         input wire is_load_m; 
//         input wire is_store_m;
//         input wire [31:0] alu_result_m2;
//         input wire [31:0] rs2_data_m;
//         input wire [5:0] store_code;

//         output wire [31:0] rd_value;
//         output wire is_loaded;
//         output wire [31:0] mem_2;

//         // uart
//         input wire uart_OUT_data;
//         output wire [7:0] uart_IN_data;
//         output wire uart_we;
//         output wire uart_tx;

//         // hardware_counter
//         input wire [31:0] hc_OUT_data;

//         // reg [31:0] mem [0:2000];

//         // // load and store only

//         // // initial $readmemh("/home/denjo/b3exp/test.hex", mem);
//         // initial $readmemh("/home/denjo/b3exp/benchmarks/tests/IntRegReg/mi.hex", mem, 0, 2000);
//         reg [31:0] memory [0:262144];

//         // initial $readmemh("/home/denjo/b3exp/benchmarks/tests/IntRegReg/code.hex", mem);

//         function [31:0] get_rd_value;
//             input is_load_m;
//             input is_store_m;
//             input [31:0] alu_result_m2;
//             input [31:0] rs2_data_m;
//             input [5:0] store_code;
//             begin
//                 if (is_load_m) begin
//                     case(alu_result_m2[1:0])
//                     2'd0: begin
//                         case(store_code)
//                         6'd9: begin
//                         get_rd_value[7:0] = memory[alu_result_m2 >> 32'd2][7:0]; // Lb
//                         if (memory[alu_result_m2 >> 32'd2][7] == 1'd0) get_rd_value[31:8] = 24'd0;
//                         else get_rd_value[31:8] = 24'b111111111111111111111111;
//                         end
//                         6'd10: begin
//                         get_rd_value[15:0] = memory[alu_result_m2 >> 32'd2][15:0]; // Lh
//                         if (memory[alu_result_m2 >> 32'd2][15] == 1'd0) get_rd_value[31:16] = 16'd0;
//                         else get_rd_value[31:16] = 16'b1111111111111111;;
//                         end
//                         6'd11: begin
//                             if (alu_result_m2[31:0] == 32'hffffff00) get_rd_value[31:0] = hc_OUT_data[31:0]; // hardware_counter
//                             else get_rd_value[31:0] = memory[alu_result_m2 >> 32'd2][31:0]; // Lw
//                         end
//                         6'd12: begin
//                         get_rd_value[7:0] = memory[alu_result_m2 >> 32'd2][7:0]; // Lbu
//                         get_rd_value[31:8] = 24'd0;
//                         end
//                         6'd13: begin
//                         get_rd_value[15:0] = memory[alu_result_m2 >> 32'd2][15:0]; // Lhu
//                         get_rd_value[31:16] = 16'd0;
//                         end
//                         default: get_rd_value[31:0] = 32'd0;
//                         endcase
//                     end
//                     2'd1: begin
//                         case(store_code)
//                         6'd9: begin
//                         get_rd_value[7:0] = memory[(alu_result_m2 - 32'd1) >> 32'd2][15:8]; // Lb
//                         if (memory[(alu_result_m2 - 32'd1) >> 32'd2][15] == 1'd0) get_rd_value[31:8] = 24'd0;
//                         else get_rd_value[31:8] = 24'b111111111111111111111111;
//                         end
//                         6'd10: begin
//                         get_rd_value[15:0] = memory[(alu_result_m2 - 32'd1) >> 32'd2][23:8]; // Lh
//                         if (memory[(alu_result_m2 - 32'd1) >> 32'd2][23] == 1'd0) get_rd_value[31:16] = 16'd0;
//                         else get_rd_value[31:16] = 16'b1111111111111111;
//                         end
//                         6'd12: begin
//                         get_rd_value[7:0] = memory[(alu_result_m2 - 32'd1) >> 32'd2][15:8]; // Lbu
//                         get_rd_value[31:8] = 24'd0;
//                         end
//                         6'd13: begin
//                         get_rd_value[15:0] = memory[(alu_result_m2 - 32'd1) >> 32'd2][23:8]; // Lhu
//                         get_rd_value[31:16] = 16'd0;
//                         end
//                         default: get_rd_value[31:0] = 32'd0;
//                         endcase
//                     end
//                     2'd2: begin
//                         case(store_code)
//                         6'd9: begin
//                         get_rd_value[7:0] = memory[(alu_result_m2 - 32'd2) >> 32'd2][23:16]; // Lb
//                         if (memory[(alu_result_m2 - 32'd2) >> 32'd2][23] == 1'd0) get_rd_value[31:8] = 24'd0;
//                         else get_rd_value[31:8] = 24'b111111111111111111111111;
//                         end
//                         6'd10: begin
//                         get_rd_value[15:0] = memory[(alu_result_m2 - 32'd2) >> 32'd2][31:16]; // Lh
//                         // get_rd_value[31:0] = {{16{get_rd_value[15]}},get_rd_value};
//                         if (memory[(alu_result_m2 - 32'd2) >> 32'd2][31] == 1'd0) get_rd_value[31:16] = 16'd0;
//                         else get_rd_value[31:16] = 16'b1111111111111111;;
//                         end
//                         6'd12: begin
//                         get_rd_value[7:0] = memory[(alu_result_m2 - 32'd2) >> 32'd2][23:16]; // Lbu
//                         get_rd_value[31:8] = 24'd0;
//                         end
//                         6'd13: begin
//                         get_rd_value[15:0] = memory[(alu_result_m2 - 32'd2) >> 32'd2][31:16]; // Lhu
//                         get_rd_value[31:16] = 16'd0;
//                         end
//                         default: get_rd_value[31:0]  = 32'd0;
//                         endcase
//                     end
//                     2'd3: begin
//                         case(store_code)
//                         6'd9: begin
//                         get_rd_value[7:0] = memory[(alu_result_m2 - 32'd3) >> 32'd2][31:24]; // Lb
//                         // get_rd_value[31:0] = {{24{get_rd_value[7]}},get_rd_value};
//                         if (memory[(alu_result_m2 - 32'd3) >> 32'd2][31] == 1'd0) get_rd_value[31:8] = 24'd0;
//                         else get_rd_value[31:8] = 24'b111111111111111111111111;
//                         end
//                         6'd12: begin
//                         get_rd_value[7:0] = memory[(alu_result_m2 - 32'd3) >> 32'd2][31:24]; // Lbu
//                         get_rd_value[31:8] = 24'd0;
//                         end
//                         default: get_rd_value[31:0] = 32'd0;
//                         endcase
//                     end
//                     default: get_rd_value[31:0] = 32'd0;
//                     endcase
//                 end
//                 else if (is_store_m) begin
//                     get_rd_value = 32'd0;
//                     case(alu_result_m2[1:0])
//                     2'd0: begin
//                         case(store_code)
//                         6'd14: begin
//                         memory[alu_result_m2 >> 32'd2][7:0] = rs2_data_m[7:0]; // Sb
//                         end
//                         6'd15: begin
//                         memory[alu_result_m2 >> 32'd2][15:0] = rs2_data_m[15:0]; // Sh
//                         end
//                         6'd16: begin
//                         memory[alu_result_m2 >> 32'd2][31:0] = rs2_data_m[31:0]; // Sw
//                         end
//                         default:;
//                         endcase
//                     end
//                     2'd1: begin
//                         case(store_code)
//                         6'd14: begin
//                         memory[(alu_result_m2 - 32'd1) >> 32'd2][15:8] = rs2_data_m[7:0]; // Sb
//                         end
//                         6'd15: begin
//                         memory[(alu_result_m2 - 32'd1) >> 32'd2][23:8] = rs2_data_m[15:0]; // Sh
//                         end
//                         default:;
//                         endcase
//                     end
//                     2'd2: begin
//                         case(store_code)
//                         6'd14: begin
//                         memory[(alu_result_m2 - 32'd2) >> 32'd2][23:16] = rs2_data_m[7:0]; // Sb
//                         end
//                         6'd15: begin
//                         memory[(alu_result_m2 - 32'd2) >> 32'd2][31:16] = rs2_data_m[15:0]; // Sh
//                         end
//                         default:;
//                         endcase
//                     end
//                     2'd3: begin
//                         case(store_code)
//                         6'd14: begin
//                         memory[(alu_result_m2 - 32'd3) >> 32'd2][31:24] = rs2_data_m[7:0]; // Sb
//                         end
//                         default:;
//                         endcase
//                     end
//                     default: get_rd_value[31:0]  = 32'd0;
//                     endcase
//                 end
//                 else get_rd_value = 32'd0;
//             end
//         endfunction


//         assign rd_value = get_rd_value(is_load_m, is_store_m, alu_result_m2, rs2_data_m, store_code);
//         assign is_loaded = is_load_m;
//         assign mem_2 = memory[2][31:0];

//         // Memory Accessステージに以下のような記述を追加
//         assign uart_IN_data = rd_value[7:0];  // ストアするデータをモジュールへ入力
//         assign uart_we = ((alu_result_m2 == 32'hf6fff070) && (is_store_m == 1'd1)) ? 1'b1 : 1'b0;  // シリアル通信用アドレスへのストア命令実行時に送信開始信号をアサート
//         assign uart_tx = uart_OUT_data;  // シリアル通信モジュールの出力はFPGA外部へと出力
// endmodule



module data_memory(clk, data_enable, is_load_m, is_store_m, alu_result_m2, alu_last, rs2_data_m, store_code, memory_value, is_loaded);  // データメモリ
        input wire clk;
        input wire data_enable;
        input wire is_load_m; 
        input wire is_store_m;
        input wire [31:0] alu_result_m2;
        input wire [1:0] alu_last;
        input wire [31:0] rs2_data_m;
        input wire [5:0] store_code;

        output reg [31:0] memory_value;
        output reg is_loaded;
        // output wire [31:0] mem_2;

        // // uart
        // input wire uart_OUT_data;
        // output reg [7:0] uart_IN_data;
        // output reg uart_we;
        // output reg uart_tx;

        // // hardware_counter
        // input wire [31:0] hc_OUT_data;

        // reg [31:0] mem [0:2000];

        // // load and store only
        reg [31:0] memory [0:32768]; // 32768,16384
        // initial $readmemh("/home/denjo/b3exp/benchmarks/Coremark/data.hex", memory);
        // initial $readmemh("/home/denjo/b3exp/benchmarks/Coremark/data_new.hex", memory);
        initial $readmemh("/home/denjo/b3exp/benchmarks/Coremark_for_Synthesis/data.hex", memory);
        // initial $readmemh("/home/denjo/b3exp/benchmarks/Coremark_for_Synthesis/data_new.hex", memory);

        // reg [31:0] reg_rd_value;

        // initial $readmemh("/home/denjo/b3exp/benchmarks/tests/IntRegReg/code.hex", mem);

        always @(posedge clk) begin // メモリアドレスは他のモジュールでできそう。
            if (data_enable) begin
                if (is_load_m) memory_value[31:0] <= memory[alu_result_m2][31:0];
                // if (is_load_m) begin
                    // memory_value <= memory[alu_result];
                    // rd_value[31:0] <= (alu_result_m2[1:0] == 2'd0) ?
                    // (store_code == 6'd9) ? {{24{memory[alu_result_m2 >> 32'd2][7]}}, memory[alu_result_m2 >> 32'd2][7:0]} : 
                    // (store_code == 6'd10) ? {{16{memory[alu_result_m2 >> 32'd2][15]}}, memory[alu_result_m2 >> 32'd2][15:0]} : 
                    // (store_code == 6'd11) ? (alu_result_m2[31:0] == 32'hffffff00) ? hc_OUT_data[31:0] : memory[alu_result_m2 >> 32'd2][31:0] :
                    // (store_code == 6'd12) ? {{24{1'd0}}, memory[alu_result_m2 >> 32'd2][7:0]} :
                    // {{16{1'd0}}, memory[alu_result_m2 >> 32'd2][15:0]} : 
                    // (alu_result_m2[1:0] == 2'd1) ?
                    // (store_code == 6'd9) ? {{24{memory[(alu_result_m2 - 32'd1) >> 32'd2][15]}}, memory[(alu_result_m2 - 32'd1) >> 32'd2][15:8]} : 
                    // (store_code == 6'd10) ? {{16{memory[(alu_result_m2 - 32'd1) >> 32'd2][23]}}, memory[(alu_result_m2 - 32'd1) >> 32'd2][23:8]} : 
                    // (store_code == 6'd12) ? {{24{1'd0}}, memory[(alu_result_m2 - 32'd1) >> 32'd2][15:8]} :
                    // (store_code == 6'd13) ? {{16{1'd0}}, memory[(alu_result_m2 - 32'd1) >> 32'd2][23:8]} :
                    // 32'd0 :
                    // (alu_result_m2[1:0] == 2'd2) ?
                    // (store_code == 6'd9) ? {{24{memory[(alu_result_m2 - 32'd2) >> 32'd2][23]}}, memory[(alu_result_m2 - 32'd2) >> 32'd2][23:16]} : 
                    // (store_code == 6'd10) ? {{16{memory[(alu_result_m2 - 32'd2) >> 32'd2][31]}}, memory[(alu_result_m2 - 32'd2) >> 32'd2][31:16]} : 
                    // (store_code == 6'd12) ? {{24{1'd0}}, memory[(alu_result_m2 - 32'd2) >> 32'd2][23:16]} :
                    // (store_code == 6'd13) ? {{16{1'd0}}, memory[(alu_result_m2 - 32'd2) >> 32'd2][31:16]} :
                    // 32'd0 :
                    // (store_code == 6'd9) ? {{24{memory[(alu_result_m2 - 32'd3) >> 32'd2][31]}}, memory[(alu_result_m2 - 32'd3) >> 32'd2][31:24]} : 
                    // (store_code == 6'd12) ? {{24{1'd0}}, memory[(alu_result_m2 - 32'd3) >> 32'd2][31:24]} :
                    // 32'd0;

                    // case(alu_result_m2[1:0])
                    //     2'd0: begin
                    //         rd_value[31:0] <= (store_code == 6'd9) ? {{24{memory[alu_result_m2 >> 32'd2][7]}}, memory[alu_result_m2 >> 32'd2][7:0]} : 
                    //         (store_code == 6'd10) ? {{16{memory[alu_result_m2 >> 32'd2][15]}}, memory[alu_result_m2 >> 32'd2][15:0]} : 
                    //         (store_code == 6'd11) ? (alu_result_m2[31:0] == 32'hffffff00) ? hc_OUT_data[31:0] : memory[alu_result_m2 >> 32'd2][31:0] :
                    //         (store_code == 6'd12) ? {{24{0}}, memory[alu_result_m2 >> 32'd2][7:0]} :
                    //         {{16{0}}, memory[alu_result_m2 >> 32'd2][15:0]};
                    //         // case(store_code)
                    //         //     6'd9: begin
                    //         //         rd_value[7:0] <= memory[alu_result_m2 >> 32'd2][7:0]; // Lb
                    //         //         // if (memory[alu_result_m2 >> 32'd2][7] == 1'd0) rd_value[31:8] <= 24'd0;
                    //         //         // else rd_value[31:8] <= 24'b111111111111111111111111;
                    //         //         rd_value[31:8] <= (memory[alu_result_m2 >> 32'd2][7] == 1'd0) ? 24'd0 : 24'b111111111111111111111111;
                    //         //     end
                    //         //     6'd10: begin
                    //         //         rd_value[15:0] <= memory[alu_result_m2 >> 32'd2][15:0]; // Lh
                    //         //         // if (memory[alu_result_m2 >> 32'd2][15] == 1'd0) rd_value[31:16] <= 16'd0;
                    //         //         // else rd_value[31:16] <= 16'b1111111111111111;
                    //         //         rd_value[31:16] <= (memory[alu_result_m2 >> 32'd2][15] == 1'd0) ? 16'd0 : 16'b1111111111111111;
                    //         //     end
                    //         //     6'd11: begin
                    //         //     //     if (alu_result_m2[31:0] == 32'hffffff00) rd_value[31:0] <= hc_OUT_data[31:0]; // hardware_counter
                    //         //     //     else rd_value[31:0] <= memory[alu_result_m2 >> 32'd2][31:0]; // Lw
                    //         //         rd_value[31:0] <= (alu_result_m2[31:0] == 32'hffffff00) ? hc_OUT_data[31:0] : memory[alu_result_m2 >> 32'd2][31:0];
                    //         //     end
                    //         //     6'd12: begin
                    //         //         rd_value[7:0] <= memory[alu_result_m2 >> 32'd2][7:0]; // Lbu
                    //         //         rd_value[31:8] <= 24'd0;
                    //         //     end
                    //         //     default: begin // 6'd13
                    //         //         rd_value[15:0] <= memory[alu_result_m2 >> 32'd2][15:0]; // Lhu
                    //         //         rd_value[31:16] <= 16'd0;
                    //         //     end
                    //         //     // default: reg_rd_value[31:0] <= 32'd0;
                    //         // endcase
                    //     end
                    //     2'd1: begin
                    //         rd_value[31:0] <= (store_code == 6'd9) ? {{24{memory[(alu_result_m2 - 32'd1) >> 32'd2][15]}}, memory[(alu_result_m2 - 32'd1) >> 32'd2][15:8]} : 
                    //         (store_code == 6'd10) ? {{16{memory[(alu_result_m2 - 32'd1) >> 32'd2][23]}}, memory[(alu_result_m2 - 32'd1) >> 32'd2][23:8]} : 
                    //         (store_code == 6'd12) ? {{24{0}}, memory[(alu_result_m2 - 32'd1) >> 32'd2][15:8]} :
                    //         (store_code == 6'd13) ? {{16{0}}, memory[(alu_result_m2 - 32'd1) >> 32'd2][23:8]} :
                    //         32'd0;


                    //         // case(store_code)
                    //         //     6'd9: begin
                    //         //         rd_value[7:0] <= memory[(alu_result_m2 - 32'd1) >> 32'd2][15:8]; // Lb
                    //         //         if (memory[(alu_result_m2 - 32'd1) >> 32'd2][15] == 1'd0) rd_value[31:8] <= 24'd0;
                    //         //         else rd_value[31:8] <= 24'b111111111111111111111111;
                    //         //     end
                    //         //     6'd10: begin
                    //         //         rd_value[15:0] <= memory[(alu_result_m2 - 32'd1) >> 32'd2][23:8]; // Lh
                    //         //         if (memory[(alu_result_m2 - 32'd1) >> 32'd2][23] == 1'd0) rd_value[31:16] <= 16'd0;
                    //         //         else rd_value[31:16] <= 16'b1111111111111111;
                    //         //     end
                    //         //     6'd12: begin
                    //         //         rd_value[7:0] <= memory[(alu_result_m2 - 32'd1) >> 32'd2][15:8]; // Lbu
                    //         //         rd_value[31:8] <= 24'd0;
                    //         //     end
                    //         //     6'd13: begin
                    //         //         rd_value[15:0] <= memory[(alu_result_m2 - 32'd1) >> 32'd2][23:8]; // Lhu
                    //         //         rd_value[31:16] <= 16'd0;
                    //         //     end
                    //         //     default: rd_value[31:0] <= 32'd0;
                    //         // endcase
                    //     end
                    //     2'd2: begin
                    //         rd_value[31:0] <= (store_code == 6'd9) ? {{24{memory[(alu_result_m2 - 32'd2) >> 32'd2][23]}}, memory[(alu_result_m2 - 32'd2) >> 32'd2][23:16]} : 
                    //         (store_code == 6'd10) ? {{16{memory[(alu_result_m2 - 32'd2) >> 32'd2][31]}}, memory[(alu_result_m2 - 32'd2) >> 32'd2][31:16]} : 
                    //         (store_code == 6'd12) ? {{24{0}}, memory[(alu_result_m2 - 32'd2) >> 32'd2][23:16]} :
                    //         (store_code == 6'd13) ? {{16{0}}, memory[(alu_result_m2 - 32'd2) >> 32'd2][31:16]} :
                    //         32'd0;

                    //         // case(store_code)
                    //         //     6'd9: begin
                    //         //         rd_value[7:0] <= memory[(alu_result_m2 - 32'd2) >> 32'd2][23:16]; // Lb
                    //         //         if (memory[(alu_result_m2 - 32'd2) >> 32'd2][23] == 1'd0) rd_value[31:8] <= 24'd0;
                    //         //         else rd_value[31:8] <= 24'b111111111111111111111111;
                    //         //     end
                    //         //     6'd10: begin
                    //         //         rd_value[15:0] <= memory[(alu_result_m2 - 32'd2) >> 32'd2][31:16]; // Lh
                    //         //         // get_rd_value[31:0] = {{16{get_rd_value[15]}},get_rd_value};
                    //         //         if (memory[(alu_result_m2 - 32'd2) >> 32'd2][31] == 1'd0) rd_value[31:16] <= 16'd0;
                    //         //         else rd_value[31:16] <= 16'b1111111111111111;
                    //         //     end
                    //         //     6'd12: begin
                    //         //         rd_value[7:0] <= memory[(alu_result_m2 - 32'd2) >> 32'd2][23:16]; // Lbu
                    //         //         rd_value[31:8] <= 24'd0;
                    //         //     end
                    //         //     6'd13: begin
                    //         //         rd_value[15:0] <= memory[(alu_result_m2 - 32'd2) >> 32'd2][31:16]; // Lhu
                    //         //         rd_value[31:16] <= 16'd0;
                    //         //     end
                    //         //     default: rd_value[31:0]  <= 32'd0;
                    //         // endcase
                    //     end
                    //     default: begin // 2'd3
                    //         rd_value[31:0] <= (store_code == 6'd9) ? {{24{memory[(alu_result_m2 - 32'd3) >> 32'd2][31]}}, memory[(alu_result_m2 - 32'd3) >> 32'd2][31:24]} : 
                    //         (store_code == 6'd12) ? {{24{0}}, memory[(alu_result_m2 - 32'd3) >> 32'd2][31:24]} :
                    //         32'd0;

                    //         // case(store_code)
                    //         //     6'd9: begin
                    //         //         rd_value[7:0] <= memory[(alu_result_m2 - 32'd3) >> 32'd2][31:24]; // Lb
                    //         //         // get_rd_value[31:0] = {{24{get_rd_value[7]}},get_rd_value};
                    //         //         if (memory[(alu_result_m2 - 32'd3) >> 32'd2][31] == 1'd0) rd_value[31:8] <= 24'd0;
                    //         //         else rd_value[31:8] <= 24'b111111111111111111111111;
                    //         //     end
                    //         //     6'd12: begin
                    //         //         rd_value[7:0] <= memory[(alu_result_m2 - 32'd3) >> 32'd2][31:24]; // Lbu
                    //         //         rd_value[31:8] <= 24'd0;
                    //         //     end
                    //         //     default: rd_value[31:0] <= 32'd0;
                    //         // endcase
                    //     end
                    //     // default: reg_rd_value[31:0] <= 32'd0;
                    // endcase
                // end
                else if (is_store_m) begin
                    // rd_value <= 32'd0;
                    case(alu_last)
                        2'd0: begin
                            if (store_code == 6'd14) memory[alu_result_m2][7:0] <= rs2_data_m[7:0];
                            else if (store_code == 6'd15) memory[alu_result_m2][15:0] <= rs2_data_m[15:0]; // Sh
                            else memory[alu_result_m2][31:0] <= rs2_data_m[31:0]; // Sw
                        end
                        2'd1: begin
                            if (store_code == 6'd14) memory[alu_result_m2][15:8] <= rs2_data_m[7:0]; // Sb
                            else memory[alu_result_m2][23:8] <= rs2_data_m[15:0]; // Sh
                        end
                        2'd2: begin
                            if (store_code == 6'd14) memory[alu_result_m2][23:16] <= rs2_data_m[7:0]; // Sb
                            else memory[alu_result_m2][31:16] <= rs2_data_m[15:0]; // Sh
                        end
                        default: memory[alu_result_m2][31:24] <= rs2_data_m[7:0]; // Sb
                    endcase
                    // rd_value <= 32'd0;
                    // case(alu_result_m2[1:0])
                    //     2'd0: begin
                    //         case(store_code)
                    //             6'd14: begin
                    //                 memory[alu_result_m2 >> 32'd2][7:0] <= rs2_data_m[7:0]; // Sb
                    //                 rd_value[7:0] <= rs2_data_m[7:0];
                    //             end
                    //             6'd15: begin
                    //                 memory[alu_result_m2 >> 32'd2][15:0] <= rs2_data_m[15:0]; // Sh
                    //             end
                    //             default: begin // 6'd16
                    //                 memory[alu_result_m2 >> 32'd2][31:0] <= rs2_data_m[31:0]; // Sw
                    //             end
                    //             // default:;
                    //         endcase
                    //     end
                    //     2'd1: begin
                    //         case(store_code)
                    //             6'd14: begin
                    //                 memory[(alu_result_m2 - 32'd1) >> 32'd2][15:8] <= rs2_data_m[7:0]; // Sb
                    //             end
                    //             default: begin // 6'd15
                    //                 memory[(alu_result_m2 - 32'd1) >> 32'd2][23:8] <= rs2_data_m[15:0]; // Sh
                    //             end
                    //             // default:;
                    //         endcase
                    //     end
                    //     2'd2: begin
                    //         case(store_code)
                    //             6'd14: begin
                    //                 memory[(alu_result_m2 - 32'd2) >> 32'd2][23:16] <= rs2_data_m[7:0]; // Sb
                    //             end
                    //             default: begin // 6'd15
                    //                 memory[(alu_result_m2 - 32'd2) >> 32'd2][31:16] <= rs2_data_m[15:0]; // Sh
                    //             end
                    //             // default:;
                    //         endcase
                    //     end
                    //     default: begin // 2'd3
                    //         case(store_code)
                    //             default: begin // 6'd14
                    //                 memory[(alu_result_m2 - 32'd3) >> 32'd2][31:24] <= rs2_data_m[7:0]; // Sb
                    //             end
                    //             // default:;
                    //         endcase
                    //     end
                    // endcase
                end
                // Memory Accessステージに以下のような記述を追加
                // uart_IN_data <= rd_value[7:0];  // ストアするデータをモジュールへ入力
                // uart_we <= ((alu_result_m2 == 32'hf6fff070) && (is_store_m == 1'd1)) ? 1'b1 : 1'b0;  // シリアル通信用アドレスへのストア命令実行時に送信開始信号をアサート
                // uart_tx <= uart_OUT_data;  // シリアル通信モジュールの出力はFPGA外部へと出力
                is_loaded <= is_load_m;
            end
        end


        // assign rd_value = reg_rd_value;
        // assign is_loaded = is_load_m;
        // assign mem_2 = memory[2][31:0];

        // // Memory Accessステージに以下のような記述を追加
        // assign uart_IN_data = reg_rd_value[7:0];  // ストアするデータをモジュールへ入力
        // assign uart_we = ((alu_result_m2 == 32'hf6fff070) && (is_store_m == 1'd1)) ? 1'b1 : 1'b0;  // シリアル通信用アドレスへのストア命令実行時に送信開始信号をアサート
        // assign uart_tx = uart_OUT_data;  // シリアル通信モジュールの出力はFPGA外部へと出力
endmodule