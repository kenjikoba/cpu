// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Primary design header
//
// This header should be included by all source files instantiating the design.
// The class here is then constructed to instantiate the design.
// See the Verilator manual for examples.

#ifndef _VCPU_H_
#define _VCPU_H_  // guard

#include "verilated_heavy.h"

//==========

class Vcpu__Syms;

//----------

VL_MODULE(Vcpu) {
  public:
    
    // PORTS
    // The application code writes and reads these signals to
    // propagate new values into/out from the Verilated model.
    VL_IN8(sysclk,0,0);
    VL_IN8(cpu_resetn,0,0);
    VL_OUT8(uart_tx,0,0);
    
    // LOCAL SIGNALS
    // Internals; generally not touched by application code
    CData/*2:0*/ cpu__DOT__ctr;
    CData/*4:0*/ cpu__DOT__rs1_addr;
    CData/*4:0*/ cpu__DOT__rs2_addr;
    CData/*4:0*/ cpu__DOT__rd_addr;
    CData/*5:0*/ cpu__DOT__alucode;
    CData/*1:0*/ cpu__DOT__aluop1_type;
    CData/*1:0*/ cpu__DOT__aluop2_type;
    CData/*0:0*/ cpu__DOT__reg_we;
    CData/*0:0*/ cpu__DOT__is_load;
    CData/*0:0*/ cpu__DOT__is_store;
    CData/*0:0*/ cpu__DOT__br;
    CData/*0:0*/ cpu__DOT__uart_we;
    CData/*0:0*/ cpu__DOT__uart_OUT_data;
    CData/*3:0*/ cpu__DOT__uart__DOT__bitcount;
    CData/*0:0*/ cpu__DOT__uart__DOT__uart_busy;
    CData/*0:0*/ cpu__DOT__uart__DOT__sending;
    SData/*8:0*/ cpu__DOT__uart__DOT__shifter;
    IData/*31:0*/ cpu__DOT__ir_f;
    IData/*31:0*/ cpu__DOT__imm;
    IData/*31:0*/ cpu__DOT__op1;
    IData/*31:0*/ cpu__DOT__op2;
    IData/*31:0*/ cpu__DOT__alu_result;
    IData/*31:0*/ cpu__DOT__new_pc;
    IData/*31:0*/ cpu__DOT__store_value;
    IData/*28:0*/ cpu__DOT__uart__DOT__d;
    IData/*28:0*/ cpu__DOT__uart__DOT__dNxt;
    IData/*31:0*/ cpu__DOT__hardware_counter__DOT__cycles;
    IData/*31:0*/ cpu__DOT__F__DOT__reg_pc;
    IData/*31:0*/ cpu__DOT__D__DOT__pc_reg;
    IData/*31:0*/ cpu__DOT__D__DOT__ir_reg;
    IData/*31:0*/ cpu__DOT__register_file__DOT__rs1_value_reg;
    IData/*31:0*/ cpu__DOT__register_file__DOT__rs2_value_reg;
    IData/*31:0*/ cpu__DOT__data_memory__DOT__reg_rd_value;
    IData/*31:0*/ cpu__DOT__instruction_memory__DOT__mem[262145];
    IData/*31:0*/ cpu__DOT__register_file__DOT__register[32];
    IData/*31:0*/ cpu__DOT__data_memory__DOT__memory[262145];
    
    // LOCAL VARIABLES
    // Internals; generally not touched by application code
    // Anonymous structures to workaround compiler member-count bugs
    struct {
        CData/*7:0*/ cpu__DOT__data_memory__DOT____Vlvbound1;
        CData/*7:0*/ cpu__DOT__data_memory__DOT____Vlvbound4;
        CData/*7:0*/ cpu__DOT__data_memory__DOT____Vlvbound6;
        CData/*7:0*/ cpu__DOT__data_memory__DOT____Vlvbound8;
        CData/*4:0*/ __Vfunc_cpu__DOT__decoder__DOT__get_r1__1__Vfuncout;
        CData/*6:0*/ __Vfunc_cpu__DOT__decoder__DOT__get_r1__1__opcode;
        CData/*4:0*/ __Vfunc_cpu__DOT__decoder__DOT__get_r1__1__r1;
        CData/*4:0*/ __Vfunc_cpu__DOT__decoder__DOT__get_r2__2__Vfuncout;
        CData/*6:0*/ __Vfunc_cpu__DOT__decoder__DOT__get_r2__2__opcode;
        CData/*4:0*/ __Vfunc_cpu__DOT__decoder__DOT__get_r2__2__r2;
        CData/*4:0*/ __Vfunc_cpu__DOT__decoder__DOT__get_rd__3__Vfuncout;
        CData/*6:0*/ __Vfunc_cpu__DOT__decoder__DOT__get_rd__3__opcode;
        CData/*4:0*/ __Vfunc_cpu__DOT__decoder__DOT__get_rd__3__rd;
        CData/*6:0*/ __Vfunc_cpu__DOT__decoder__DOT__get_imm__4__opcode;
        CData/*2:0*/ __Vfunc_cpu__DOT__decoder__DOT__get_imm__4__func_rec;
        CData/*5:0*/ __Vfunc_cpu__DOT__decoder__DOT__get_alucode__5__Vfuncout;
        CData/*6:0*/ __Vfunc_cpu__DOT__decoder__DOT__get_alucode__5__opcode;
        CData/*2:0*/ __Vfunc_cpu__DOT__decoder__DOT__get_alucode__5__func_rec;
        CData/*0:0*/ __Vfunc_cpu__DOT__decoder__DOT__get_alucode__5__lastbit;
        CData/*1:0*/ __Vfunc_cpu__DOT__decoder__DOT__get_op1type__6__Vfuncout;
        CData/*6:0*/ __Vfunc_cpu__DOT__decoder__DOT__get_op1type__6__opcode;
        CData/*1:0*/ __Vfunc_cpu__DOT__decoder__DOT__get_op2type__7__Vfuncout;
        CData/*6:0*/ __Vfunc_cpu__DOT__decoder__DOT__get_op2type__7__opcode;
        CData/*0:0*/ __Vfunc_cpu__DOT__decoder__DOT__get_regwe__8__Vfuncout;
        CData/*6:0*/ __Vfunc_cpu__DOT__decoder__DOT__get_regwe__8__opcode;
        CData/*4:0*/ __Vfunc_cpu__DOT__decoder__DOT__get_regwe__8__rd;
        CData/*0:0*/ __Vfunc_cpu__DOT__decoder__DOT__get_load__9__Vfuncout;
        CData/*6:0*/ __Vfunc_cpu__DOT__decoder__DOT__get_load__9__opcode;
        CData/*0:0*/ __Vfunc_cpu__DOT__decoder__DOT__get_store__10__Vfuncout;
        CData/*6:0*/ __Vfunc_cpu__DOT__decoder__DOT__get_store__10__opcode;
        CData/*1:0*/ __Vfunc_cpu__DOT__op_controller__DOT__choose_op1__12__aluop1_type_e;
        CData/*1:0*/ __Vfunc_cpu__DOT__op_controller__DOT__choose_op2__13__aluop2_type_e;
        CData/*5:0*/ __Vfunc_cpu__DOT__alu__DOT__calc__14__alucode_e;
        CData/*4:0*/ __Vfunc_cpu__DOT__alu__DOT__calc__14__signed_op2;
        CData/*0:0*/ __Vfunc_cpu__DOT__alu__DOT__is_jump__15__Vfuncout;
        CData/*5:0*/ __Vfunc_cpu__DOT__alu__DOT__is_jump__15__alucode_e;
        CData/*0:0*/ __Vfunc_cpu__DOT__pc_update__DOT__find_pc__16__br;
        CData/*0:0*/ __Vfunc_cpu__DOT__rd_controller__DOT__get_store__17__is_loaded;
        CData/*0:0*/ __Vdly__cpu__DOT__uart_OUT_data;
        CData/*0:0*/ __Vclklast__TOP__cpu_resetn;
        CData/*0:0*/ __Vclklast__TOP__sysclk;
        SData/*15:0*/ cpu__DOT__data_memory__DOT____Vlvbound2;
        SData/*15:0*/ cpu__DOT__data_memory__DOT____Vlvbound5;
        SData/*15:0*/ cpu__DOT__data_memory__DOT____Vlvbound7;
        IData/*31:0*/ cpu__DOT__data_memory__DOT____Vlvbound3;
        IData/*31:0*/ __Vfunc_cpu__DOT__instruction_memory__DOT__get_ir__0__Vfuncout;
        IData/*31:0*/ __Vfunc_cpu__DOT__instruction_memory__DOT__get_ir__0__next_pc;
        IData/*31:0*/ __Vfunc_cpu__DOT__decoder__DOT__get_imm__4__Vfuncout;
        IData/*31:0*/ __Vfunc_cpu__DOT__decoder__DOT__get_imm__4__ir_d;
        IData/*31:0*/ __Vfunc_cpu__DOT__op_controller__DOT__choose_op1__12__Vfuncout;
        IData/*31:0*/ __Vfunc_cpu__DOT__op_controller__DOT__choose_op1__12__rs1_value_e;
        IData/*31:0*/ __Vfunc_cpu__DOT__op_controller__DOT__choose_op1__12__imm_e1;
        IData/*31:0*/ __Vfunc_cpu__DOT__op_controller__DOT__choose_op1__12__pc_e1;
        IData/*31:0*/ __Vfunc_cpu__DOT__op_controller__DOT__choose_op2__13__Vfuncout;
        IData/*31:0*/ __Vfunc_cpu__DOT__op_controller__DOT__choose_op2__13__rs2_value_e;
        IData/*31:0*/ __Vfunc_cpu__DOT__op_controller__DOT__choose_op2__13__imm_e1;
        IData/*31:0*/ __Vfunc_cpu__DOT__op_controller__DOT__choose_op2__13__pc_e1;
        IData/*31:0*/ __Vfunc_cpu__DOT__alu__DOT__calc__14__Vfuncout;
        IData/*31:0*/ __Vfunc_cpu__DOT__alu__DOT__calc__14__op1;
        IData/*31:0*/ __Vfunc_cpu__DOT__alu__DOT__calc__14__op2;
        IData/*31:0*/ __Vfunc_cpu__DOT__alu__DOT__calc__14__register;
        IData/*31:0*/ __Vfunc_cpu__DOT__alu__DOT__calc__14__signed_op1;
        IData/*31:0*/ __Vfunc_cpu__DOT__alu__DOT__is_jump__15__op1;
        IData/*31:0*/ __Vfunc_cpu__DOT__alu__DOT__is_jump__15__op2;
    };
    struct {
        IData/*31:0*/ __Vfunc_cpu__DOT__alu__DOT__is_jump__15__register;
        IData/*31:0*/ __Vfunc_cpu__DOT__pc_update__DOT__find_pc__16__Vfuncout;
        IData/*31:0*/ __Vfunc_cpu__DOT__pc_update__DOT__find_pc__16__imm_e2;
        IData/*31:0*/ __Vfunc_cpu__DOT__pc_update__DOT__find_pc__16__pc_e2;
        IData/*31:0*/ __Vfunc_cpu__DOT__rd_controller__DOT__get_store__17__Vfuncout;
        IData/*31:0*/ __Vfunc_cpu__DOT__rd_controller__DOT__get_store__17__rd_value;
        IData/*31:0*/ __Vfunc_cpu__DOT__rd_controller__DOT__get_store__17__alu_result_m1;
        IData/*31:0*/ __Vdly__cpu__DOT__hardware_counter__DOT__cycles;
    };
    
    // INTERNAL VARIABLES
    // Internals; generally not touched by application code
    Vcpu__Syms* __VlSymsp;  // Symbol table
    
    // CONSTRUCTORS
  private:
    VL_UNCOPYABLE(Vcpu);  ///< Copying not allowed
  public:
    /// Construct the model; called by application code
    /// The special name  may be used to make a wrapper with a
    /// single model invisible with respect to DPI scope names.
    Vcpu(const char* name = "TOP");
    /// Destroy the model; called (often implicitly) by application code
    ~Vcpu();
    
    // API METHODS
    /// Evaluate the model.  Application must call when inputs change.
    void eval();
    /// Simulation complete, run final blocks.  Application must call on completion.
    void final();
    
    // INTERNAL METHODS
  private:
    static void _eval_initial_loop(Vcpu__Syms* __restrict vlSymsp);
  public:
    void __Vconfigure(Vcpu__Syms* symsp, bool first);
  private:
    static QData _change_request(Vcpu__Syms* __restrict vlSymsp);
    void _ctor_var_reset() VL_ATTR_COLD;
  public:
    static void _eval(Vcpu__Syms* __restrict vlSymsp);
  private:
#ifdef VL_DEBUG
    void _eval_debug_assertions();
#endif  // VL_DEBUG
  public:
    static void _eval_initial(Vcpu__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    static void _eval_settle(Vcpu__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    static void _initial__TOP__1(Vcpu__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    static void _sequent__TOP__2(Vcpu__Syms* __restrict vlSymsp);
    static void _sequent__TOP__3(Vcpu__Syms* __restrict vlSymsp);
    static void _sequent__TOP__5(Vcpu__Syms* __restrict vlSymsp);
    static void _settle__TOP__4(Vcpu__Syms* __restrict vlSymsp) VL_ATTR_COLD;
} VL_ATTR_ALIGNED(VL_CACHE_LINE_BYTES);

//----------


#endif  // guard
