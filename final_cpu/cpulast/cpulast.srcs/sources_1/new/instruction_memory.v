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

module instruction_memory(next_pc, ir_f); 
        input wire [31:0] next_pc;
        output wire [31:0] ir_f;
        reg [31:0] mem [0:24576]; // 24576

        // initial $readmemh("/home/denjo/b3exp/benchmarks/tests/IntRegReg/code.hex", mem); // クリア！！！
        // initial $readmemh("/home/denjo/b3exp/benchmarks/tests/ControlTransfer/code.hex", mem); // クリア！！！
        // initial $readmemh("/home/denjo/b3exp/benchmarks/tests/IntRegImm/code.hex", mem); // クリア！！！
        // initial $readmemh("/home/denjo/b3exp/benchmarks/tests/ZeroRegister/code.hex", mem); // クリア！！！
        // initial $readmemh("/home/denjo/b3exp/benchmarks/tests/LoadAndStore/code.hex", mem); // クリア！！！
        // initial $readmemh("/home/denjo/b3exp/benchmarks/tests/Uart/code.hex", mem);    // クリア！！！
        // initial $readmemh("/home/denjo/b3exp/benchmarks/tests/Uart/code_new.hex", mem);    // クリア！！！
        // initial $readmemh("/home/denjo/b3exp/benchmarks/Coremark/code.hex", mem);      // クリア！！！
        // initial $readmemh("/home/denjo/b3exp/benchmarks/Coremark/code_new.hex", mem);  // クリア！！！
        initial $readmemh("/home/denjo/b3exp/benchmarks/Coremark_for_Synthesis/code.hex", mem); // クリア！！！
        // initial $readmemh("/home/denjo/b3exp/benchmarks/Coremark_for_Synthesis/code_new.hex", mem); // ん、、、

        function [31:0] get_ir;
            input [31:0] next_pc;
            begin
                get_ir = mem[next_pc >> 32'd2];
                // $display("get_ir");
                // $display(next_pc);
                // $display(next_pc >> 32'd2);
                // $display(get_ir);
            end
        endfunction

        assign ir_f = get_ir(next_pc);
endmodule

