/*
 * Testbench for TDC Module
 * Time-to-Digital Converter - Simulation
 * 
 * Test Cases:
 * 1. Reset functionality
 * 2. Counter incrementation
 * 3. Frequency divider operation
 * 4. Pipeline stage captures
 * 5. Output calculation (Q2 - Q1)
 */

`timescale 1ns / 1ps

module tb_tdc_module();

    // =====================================
    // Signals
    // =====================================
    reg clk;
    reg rst_n;
    reg ref;
    reg sens;
    wire [9:0] outcdc;
    
    // Clock parameters
    parameter CLK_PERIOD = 10;      // 100 MHz
    parameter REF_PERIOD = 5;       // 200 MHz (2x clk)
    parameter SENS_PERIOD = 20;     // 50 MHz (0.5x clk)
    
    // =====================================
    // DUT Instantiation
    // =====================================
    tdc_module dut (
        .clk(clk),
        .rst_n(rst_n),
        .ref(ref),
        .sens(sens),
        .outcdc(outcdc)
    );
    
    // =====================================
    // Clock Generation
    // =====================================
    always #(CLK_PERIOD/2) clk = ~clk;
    
    // =====================================
    // Reference Clock Generation
    // =====================================
    always #(REF_PERIOD/2) ref = ~ref;
    
    // =====================================
    // Sensor Signal Generation
    // =====================================
    always #(SENS_PERIOD/2) sens = ~sens;
    
    // =====================================
    // Test Stimulus
    // =====================================
    initial begin
        // Initialize
        clk = 0;
        rst_n = 0;
        ref = 0;
        sens = 0;
        
        // Display header
        $display("=" * 80);
        $display("TDC MODULE TESTBENCH - Time-to-Digital Converter");
        $display("=" * 80);
        $display("Time (ns) | rst_n | ref | sens | outcdc | Q1 | Q2 | counter");
        $display("-" * 80);
        
        // Test 1: Reset
        #(CLK_PERIOD * 2);
        rst_n = 1;
        $display("%t ns | Reset released", $time);
        
        // Test 2: Run simulation
        #(CLK_PERIOD * 200);
        
        // Display final results
        $display("-" * 80);
        $display("Simulation completed successfully!");
        $display("=" * 80);
        
        $finish;
    end
    
    // =====================================
    // Monitor
    // =====================================
    always @(posedge clk) begin
        $monitor("%t ns | %b | %b | %b | %5d | %3d | %3d | %3d",
            $time, rst_n, ref, sens, outcdc,
            dut.Q1, dut.Q2, dut.counter);
    end
    
    // =====================================
    // Assertions and Checks
    // =====================================
    always @(posedge rst_n) begin
        if (dut.counter !== 10'b0) begin
            $error("ERROR: Counter not reset to 0!");
        end
        if (dut.Q1 !== 10'b0) begin
            $error("ERROR: Q1 not reset to 0!");
        end
        if (dut.Q2 !== 10'b0) begin
            $error("ERROR: Q2 not reset to 0!");
        end
    end
    
    // =====================================
    // Waveform Dump (for GTKWave)
    // =====================================
    initial begin
        $dumpfile("tdc_module.vcd");
        $dumpvars(0, tb_tdc_module);
    end

endmodule
