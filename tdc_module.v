/*
 * TDC Module - Time-to-Digital Converter
 * ASIC/FPGA Design
 * 
 * Descripción:
 * - ref: entrada de oscilador (reloj del contador)
 * - sens: entrada de sensor
 * - Contador de 10 bits con reloj ref
 * - Registro reg10 (10 bits) con entrada del contador
 * - Divisor de frecuencia x10 para sens
 * - Registro reg11 (10 bits) con reloj outsens
 * - Salida final: outcdc = Q2 - Q1
 */

module tdc_module (
    input wire clk,           // Reloj del sistema (opcional)
    input wire rst_n,         // Reset activo bajo
    input wire ref,           // Oscilador de referencia
    input wire sens,          // Entrada de sensor
    output reg [9:0] outcdc   // Salida: Q2 - Q1 (10 bits)
);

    // =====================================
    // Contador de 10 bits
    // =====================================
    reg [9:0] counter;
    
    always @(posedge ref or negedge rst_n) begin
        if (!rst_n)
            counter <= 10'b0;
        else
            counter <= counter + 1'b1;
    end
    
    // =====================================
    // Registro REG10 (10 bits)
    // =====================================
    reg [9:0] Q1;
    
    always @(posedge outsens or negedge rst_n) begin
        if (!rst_n)
            Q1 <= 10'b0;
        else
            Q1 <= counter;  // Captura la salida del contador
    end
    
    // =====================================
    // Divisor de Frecuencia x10
    // =====================================
    reg [3:0] div_counter;
    reg outsens;
    
    always @(posedge sens or negedge rst_n) begin
        if (!rst_n) begin
            div_counter <= 4'b0;
            outsens <= 1'b0;
        end
        else begin
            if (div_counter == 4'd9) begin
                div_counter <= 4'b0;
                outsens <= ~outsens;  // Toggle de salida
            end
            else begin
                div_counter <= div_counter + 1'b1;
            end
        end
    end
    
    // =====================================
    // Registro REG11 (10 bits)
    // =====================================
    reg [9:0] Q2;
    
    always @(posedge outsens or negedge rst_n) begin
        if (!rst_n)
            Q2 <= 10'b0;
        else
            Q2 <= Q1;  // Captura Q1 del registro anterior
    end
    
    // =====================================
    // Resta Final: outcdc = Q2 - Q1
    // =====================================
    always @(*) begin
        outcdc = Q2 - Q1;
    end

endmodule
