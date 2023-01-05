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

// module register_file( // 完成。
//     // input wire clk,
//     input wire [4:0] rs1_addr,
//     input wire [4:0] rs2_addr,
//     input wire [4:0] store_addr,
//     input wire [31:0] store_value,
//     input wire is_write_w,
//     input wire is_decode_stage,
//     input wire is_write_stage,

//     output wire [31:0] rs1_value,
//     output wire [31:0] rs2_value,

//     output wire [31:0] register_all,
//     output wire store_done,
//     output wire [31:0] register_13,
//     output wire [31:0] register_11,
//     output wire [31:0] register_zero,
//     output wire [31:0] register_10

// );
//     reg [31:0] register [0:31];
//     initial register[0] = 32'd0;
//     // reg [31:0] rs1_value_reg;
//     // reg [31:0] rs2_value_reg;
//     // initial $readmemh("/home/denjo/b3exp/benchmarks/tests/IntRegReg/mi.hex", register);

//     // always @(negedge clk) begin
//     //     if (is_decode_stage) begin
//     //         rs1_value_reg <= register[rs1_addr];
//     //         rs2_value_reg <= register[rs2_addr];
//     //     end
//     //     else if (is_write_stage) begin
//     //         if (is_write_w) begin
//     //             register[store_addr] <= store_value;
//     //             $display(register[store_addr]);
//     //         end
//     //     end
//     // end

//     function [31:0] get_value1;
//     input [4:0] rs1_addr;
//     input is_decode_stage;
//     begin
//         if (is_decode_stage) get_value1 = register[rs1_addr];
//     end
//     endfunction

//     function [31:0] get_value2;
//     input [4:0] rs2_addr;
//     input is_decode_stage;
//     begin
//         if (is_decode_stage) get_value2 = register[rs2_addr];
//         // else get_value2 = 32'd0;
//     end
//     endfunction

//     function store;
//     input [4:0] store_addr;
//     input [31:0] store_value;
//     input is_write_w;
//     input is_write_stage;
//     begin
//         if (is_write_stage) begin
//             if (is_write_w) begin 
//                 if (store_addr != 5'd0) register[store_addr] = store_value;
//                 store = 1'd0;
//             end
//             $display("register");
//             $display(register[17]);
//         end
//     end
//     endfunction

//     assign rs1_value = get_value1(rs1_addr, is_decode_stage);
//     assign rs2_value = get_value2(rs2_addr, is_decode_stage);

//     assign register_all = register[17];
//     assign store_done = store(store_addr, store_value, is_write_w, is_write_stage);
//     assign register_13 = register[13];
//     assign register_11 = register[11];
//     assign register_zero = register[0];
//     assign register_10 = register[10];
    
//     // assign rs1_value = rs1_value_reg;
//     // assign rs2_value = rs2_value_reg;
// endmodule



module register_file( // 完成。
    input wire clk,
    input wire [4:0] rs1_addr,
    input wire [4:0] rs2_addr,
    input wire [4:0] store_addr,
    input wire [31:0] store_value,
    input wire is_write_w,
    input wire is_decode_stage,
    input wire is_write_stage,

    output wire [31:0] rs1_value,
    output wire [31:0] rs2_value,

    output wire [31:0] register_all,
    output wire [31:0] register_13,
    output wire [31:0] register_11,
    output wire [31:0] register_zero,
    output wire [31:0] register_10,
    output wire [31:0] register_01

);
    reg [31:0] register [0:31];
    initial register[0] = 32'd0;
    reg [31:0] rs1_value_reg;
    reg [31:0] rs2_value_reg;
    // initial $readmemh("/home/denjo/b3exp/benchmarks/tests/IntRegReg/mi.hex", register);

    always @(posedge clk) begin
        if (is_decode_stage) begin
            rs1_value_reg <= register[rs1_addr];
            rs2_value_reg <= register[rs2_addr];
        end
        else if (is_write_stage) begin
            if (is_write_w) begin 
                if (store_addr != 5'd0) register[store_addr] <= store_value;
            end
        end
    end

    assign rs1_value = rs1_value_reg;
    assign rs2_value = rs2_value_reg;

    assign register_all = register[17];
    assign register_13 = register[13];
    assign register_11 = register[11];
    assign register_zero = register[0];
    assign register_10 = register[15];
    assign register_01 = register[1];
    
    // assign rs1_value = rs1_value_reg;
    // assign rs2_value = rs2_value_reg;
endmodule
