`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 11/30/2022 11:30:53 PM
// Design Name:
// Module Name: cpu_tb
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
//////////////////////////////////////////////////////////////////////////////////`include "/home/denjo/exp/b3exp/work/simple_addaddr_cpu/simple_addaddr_cpu.srcs/sources_1/new/define.vh"module cpu_tb;


module testbench;
    reg sysclk;
    reg cpu_resetn; parameter CYCLE = 2;
    integer count = 0;
    integer fd = 0; always #(CYCLE/2) sysclk = ~sysclk; cpu cpu(
    .sysclk(sysclk),
    .cpu_resetn(cpu_resetn)
    ); 
    
    reg [2:0] ctr;

    wire [31:0] pc_f; 
    wire [31:0] next_pc;
    wire [31:0] ir_f;

    wire [31:0] pc_d;
    wire [31:0] ir_d;
    wire [4:0] rs1_addr;
    wire [4:0] rs2_addr;
    wire [4:0] rd_addr;
    wire [31:0] imm; 
    wire [5:0] alucode; 
    wire [1:0] aluop1_type; 
    wire [1:0] aluop2_type; 
    wire reg_we; 
    wire is_load; 
    wire is_store;
    wire is_halt;
    wire [31:0] rs1_value; 
    wire [31:0] rs2_value;

    wire [31:0] pc_e1;
    wire [31:0] rs1_value_e;
    wire [31:0] rs2_value_e;
    wire [31:0] imm_e1;
    wire [1:0] aluop1_type_e;
    wire [1:0] aluop2_type_e;
    wire is_load_e;
    wire is_store_e;
    wire [4:0] rd_addr_e;
    wire reg_we_e;
    wire [5:0] alucode_store;
    wire [5:0] alucode_e;
    wire [5:0] alucode_pc;
    wire [31:0] rs1_value_pc;
    wire [31:0] op1; 
    wire [31:0] op2; 
    wire [31:0] rs2_data; 
    wire [31:0] imm_e2; 
    wire [31:0] pc_e2;
    wire [31:0] alu_result;
    wire br;
    wire [31:0] new_pc;

    wire [31:0] pc_m;
    wire [31:0] alu_result_m1;
    wire [4:0] rd_addr_m;
    wire reg_we_m;
    wire is_load_m;
    wire is_store_m;
    wire [31:0] alu_result_m2;
    wire [31:0] rs2_data_m;
    wire [5:0] store_code;
    wire [31:0] rd_value;
    wire is_loaded;
    wire [31:0] store_value_m;
    wire [4:0] store_addr_m;
    wire is_write_m;

    wire [31:0] pc_w;
    wire is_write_w;
    wire [31:0] store_value;
    wire [4:0] store_addr;

    wire [31:0] register_all;
    // wire store_done;
    wire [31:0] register_13;
    wire [31:0] register_11;
    wire [31:0] register_zero;
    wire [31:0] register_10;
    wire [31:0] mem_2;
    wire [31:0] register_01;

    /*      */
    /* uart */
    /*      */
    wire [7:0] uart_IN_data;
    wire uart_we;
    wire uart_OUT_data;

    uart uart(
        .uart_tx(uart_OUT_data),
        .uart_wr_i(uart_we),
        .uart_dat_i(uart_IN_data),
        .sys_clk_i(sysclk),
        .sys_rstn_i(cpu_resetn),
        .enable_uart(ctr == 0)
    );

    /*                 */
    /* HardwareCounter */
    /*                 */
    wire [31:0] hc_OUT_data;

    hardware_counter hardware_counter(
        .CLK_IP(sysclk),
        .RSTN_IP(cpu_resetn),
        .COUNTER_OP(hc_OUT_data)
    );



    initial ctr = 3'd0;

    always @(posedge sysclk) begin
        ctr <= (ctr + 1) % 5;
        // $display("ctr");
        // $display(ctr);
    end
    // always @(posedge sysclk) begin
    //     ctr <= 3'd0;
    //     // $display("ctr");
    //     // $display(ctr);
    // end

    // Fetch
    F F(.clk(sysclk), .enable(ctr == 0), .cpu_resetn(cpu_resetn), .pc_w(pc_m),

    .next_pc(next_pc), .pc_f(pc_f)); 

    instruction_memory instruction_memory(
        .next_pc(next_pc),

        .ir_f(ir_f)
    );

    // Decode
    D D(.clk(sysclk), .enable(ctr == 1), .ir_f(ir_f), .pc_f(pc_f),
    .ir_d(ir_d), .pc_d(pc_d)); // decoder, register_file

    // // Decode
    // D D(.ir_f(ir_f), .pc_f(pc_f),
    // .ir_d(ir_d), .pc_d(pc_d)); // decoder, register_file

    decoder decoder(
        .ir_d(ir_d),

        .srcreg1_num(rs1_addr),
        .srcreg2_num(rs2_addr),
        .dstreg_num(rd_addr),
        .imm(imm),
        .alucode(alucode),
        .aluop1_type(aluop1_type),
        .aluop2_type(aluop2_type),
        .reg_we(reg_we),
        .is_load(is_load),
        .is_store(is_store),
        .is_halt(is_halt)
    );

    // register_file register_file(
    //     // .clk(sysclk),
    //     .rs1_addr(rs1_addr),
    //     .rs2_addr(rs2_addr),
    //     .store_addr(store_addr),
    //     .store_value(store_value),
    //     .is_write_w(is_write_w),
    //     .is_decode_stage(ctr == 2),
    //     .is_write_stage(ctr == 4),

    //     .rs1_value(rs1_value),
    //     .rs2_value(rs2_value),
    //     .register_all(register_all),
    //     .store_done(store_done),
    //     .register_13(register_13),
    //     .register_11(register_11),
    //     .register_zero(register_zero),
    //     .register_10(register_10)
    // );

    register_file register_file(
        .clk(sysclk),
        .rs1_addr(rs1_addr),
        .rs2_addr(rs2_addr),
        .store_addr(store_addr),
        .store_value(store_value),
        .is_write_w(is_write_w),
        .is_decode_stage(ctr == 2),
        .is_write_stage(ctr == 4),

        .rs1_value(rs1_value),
        .rs2_value(rs2_value),
        .register_all(register_all),
        .register_13(register_13),
        .register_11(register_11),
        .register_zero(register_zero),
        .register_10(register_10),
        .register_01(register_01)
    );

    // // Execute
    // E E(.clk(sysclk), .enable(ctr == 2), .pc_d(pc_d), .rs1_value(rs1_value), .rs2_value(rs2_value),
    // .rd_addr(rd_addr), .imm(imm), .alucode(alucode), .aluop1_type(aluop1_type), .aluop2_type(aluop2_type),
    // .reg_we(reg_we), .is_load(is_load), .is_store(is_store), .is_halt(is_halt),
    // .is_load_e(is_load_e), .is_store_e(is_store_e), .rd_addr_e(rd_addr_e), .reg_we_e(reg_we_e),
    // .pc_e1(pc_e1), .rs1_value_e(rs1_value_e), .rs2_value_e(rs2_value_e),
    // .imm_e1(imm_e1), .aluop1_type_e(aluop1_type_e), .aluop2_type_e(aluop2_type_e), .alucode_e(alucode_e),
    // .alucode_store(alucode_store));

    // Execute
    E E(.pc_d(pc_d), .rs1_value(rs1_value), .rs2_value(rs2_value),
    .rd_addr(rd_addr), .imm(imm), .alucode(alucode), .aluop1_type(aluop1_type), .aluop2_type(aluop2_type),
    .reg_we(reg_we), .is_load(is_load), .is_store(is_store), .is_halt(is_halt),
    .is_load_e(is_load_e), .is_store_e(is_store_e), .rd_addr_e(rd_addr_e), .reg_we_e(reg_we_e),
    .pc_e1(pc_e1), .rs1_value_e(rs1_value_e), .rs2_value_e(rs2_value_e),
    .imm_e1(imm_e1), .aluop1_type_e(aluop1_type_e), .aluop2_type_e(aluop2_type_e), .alucode_e(alucode_e),
    .alucode_store(alucode_store), .alucode_pc(alucode_pc), .rs1_value_pc(rs1_value_pc));

    op_controller op_controller(
        .rs1_value_e(rs1_value_e),
        .rs2_value_e(rs2_value_e),
        .imm_e1(imm_e1),
        .aluop1_type_e(aluop1_type_e),
        .aluop2_type_e(aluop2_type_e),
        .pc_e1(pc_e1),

        .op1(op1),
        .op2(op2),
        .rs2_data(rs2_data),
        .imm_e2(imm_e2),
        .pc_e2(pc_e2)
    );

    alu alu(
        .alucode_e(alucode_e),
        .op1(op1),
        .op2(op2),

        .alu_result(alu_result),
        .br_taken(br)
    );

    pc_update pc_update(
        .br(br),
        .imm_e2(imm_e2),
        .pc_e2(pc_e2),
        .alucode_pc(alucode_pc),
        .rs1_value_pc(rs1_value_pc),

        .new_pc(new_pc)
    );

    // Memory
    // M M(.clk(sysclk), .enable(ctr == 3), .new_pc(new_pc), .alu_result(alu_result),
    // .rs2_data(rs2_data), .is_load_e(is_load_e), .is_store_e(is_store_e), .rd_addr_e(rd_addr_e), .reg_we_e(reg_we_e),
    // .alucode_store(alucode_store),
    // .pc_m(pc_m), .alu_result_m1(alu_result_m1), .rd_addr_m(rd_addr_m), .reg_we_m(reg_we_m), .is_load_m(is_load_m),
    // .is_store_m(is_store_m), .alu_result_m2(alu_result_m2), .rs2_data_m(rs2_data_m), .store_code(store_code));

    // // Memory
    M M(.new_pc(new_pc), .alu_result(alu_result),
    .rs2_data(rs2_data), .is_load_e(is_load_e), .is_store_e(is_store_e), .rd_addr_e(rd_addr_e), .reg_we_e(reg_we_e),
    .alucode_store(alucode_store),
    .pc_m(pc_m), .alu_result_m1(alu_result_m1), .rd_addr_m(rd_addr_m), .reg_we_m(reg_we_m), .is_load_m(is_load_m),
    .is_store_m(is_store_m), .alu_result_m2(alu_result_m2), .rs2_data_m(rs2_data_m), .store_code(store_code));

    // data_memory data_memory(
    //     .is_load_m(is_load_m),
    //     .is_store_m(is_store_m),
    //     .alu_result_m2(alu_result_m2),
    //     .rs2_data_m(rs2_data_m),
    //     .store_code(store_code),

    //     .rd_value(rd_value),
    //     .is_loaded(is_loaded),
    //     .mem_2(mem_2),
    //     // uart
    //     .uart_OUT_data(uart_OUT_data), // input

    //     .uart_IN_data(uart_IN_data),
    //     .uart_we(uart_we),
    //     .uart_tx(uart_tx),

    //     // hardware_counter
    //     .hc_OUT_data(hc_OUT_data)
    // );

    data_memory data_memory(
        .clk(sysclk),
        .data_enable(ctr == 3),
        .is_load_m(is_load_m),
        .is_store_m(is_store_m),
        .alu_result_m2(alu_result_m2),
        .rs2_data_m(rs2_data_m),
        .store_code(store_code),

        .rd_value(rd_value),
        .is_loaded(is_loaded),
        .mem_2(mem_2),
        // uart
        .uart_OUT_data(uart_OUT_data), // input

        .uart_IN_data(uart_IN_data),
        .uart_we(uart_we),
        .uart_tx(uart_tx),

        // hardware_counter
        .hc_OUT_data(hc_OUT_data)
    );

    rd_controller rd_controller(
        .rd_value(rd_value),
        .is_loaded(is_loaded),
        .alu_result_m1(alu_result_m1),
        .rd_addr_m(rd_addr_m),
        .reg_we_m(reg_we_m),

        // .store_value_m(store_value_m),
        // .store_addr_m(store_addr_m),
        // .is_write_m(is_write_m)
        .store_value_m(store_value),
        .store_addr_m(store_addr),
        .is_write_m(is_write_w)
    );

    // // Write
    // W W(.clk(sysclk), .enable(ctr == 4), .pc_m(pc_m), .store_value_m(store_value_m), .store_addr_m(store_addr_m), .is_write_m(is_write_m),
    // .pc_w(pc_w), .store_value(store_value), .store_addr(store_addr), .is_write_w(is_write_w));


    
    
    
    
    
    
    
    initial begin
    fd = $fopen("/home/denjo/b3exp/benchmarks/trace/result", "w");
    // fd = $fopen("/home/denjo/b3exp/benchmarks/trace/result_for_sysnthesis2", "w");
    #10     sysclk     = 1'd0;
    cpu_resetn    = 1'd0;
    #(CYCLE) cpu_resetn = 1'd1;
    if (cpu.ctr == 1) begin
        while (cpu.pc_f != 32'h8004) begin
        count <= count + 1;
        if (count % 5 == 4) begin
            $fwrite(fd, "0x%x: 0x%x # ", cpu.pc_f[15:0], cpu.ir_f);
            if (cpu.reg_we) begin
            $fwrite(fd, "x%02d = 0x%x", cpu.store_addr, cpu.store_value);
            end else begin
            $fwrite(fd, "(no destination)");
            end
            if (cpu.is_load && cpu.ir_f[13:12] == 2'b00) begin
            $fwrite(fd, ";            0x%02x <- mem[0x%x]", cpu.store_value[7:0], cpu.alu_result_m2[31:0] + 32'h10000);
            end else if (cpu.is_load && cpu.ir_f[13:12] == 2'b01) begin
            $fwrite(fd, ";          0x%04x <- mem[0x%x]", cpu.store_value[15:0], cpu.alu_result_m2[31:0] + 32'h10000);
            end else if (cpu.is_load && cpu.ir_f[13] == 1'b1) begin
            $fwrite(fd, ";      0x%x <- mem[0x%x]", cpu.store_value[31:0], cpu.alu_result_m2[31:0] + 32'h10000);
            end
            if (cpu.is_store && cpu.ir_f[14:12] == 3'b000) begin
            $fwrite(fd, "; mem[0x%x] <- 0x%02x", cpu.alu_result_m2[31:0] + 32'h10000, cpu.rs2_data_m[7:0]);
            end else if (cpu.is_store && cpu.ir_f[14:12] == 3'b001) begin
            $fwrite(fd, "; mem[0x%x] <- 0x%04x", cpu.alu_result_m2[31:0] + 32'h10000, cpu.rs2_data_m[15:0]);
            end else if (cpu.is_store && cpu.ir_f[14:12] == 3'b010) begin
            $fwrite(fd, "; mem[0x%x] <- 0x%x", cpu.alu_result_m2[31:0] + 32'h10000, cpu.rs2_data_m[31:0]);
            end
            $fwrite(fd, "\n");
        end
        #(CYCLE);
        end
        $fwrite(fd, "0x%x: 0x%x # ", cpu.pc_f[15:0], cpu.ir_f);
        $fwrite(fd, "(no destination)");
        $fwrite(fd, "\n");
    end
    $fclose(fd);
    $finish;
    end
endmodule