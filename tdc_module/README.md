# TDC Module - Time-to-Digital Converter

## 📋 Descripción General

Este proyecto implementa un módulo **Time-to-Digital Converter (TDC)** optimizado para diseños ASIC y FPGA. El TDC mide intervalos de tiempo con alta precisión utilizando arquitectura de pipeline de dos etapas.

## 🏗️ Arquitectura del Módulo

```
ref (Oscilador) ──→ Contador 10-bit
                         ↓
                    (D) REG10 ← outsens
                         ↓ (Q1)
                    (D) REG11 ← outsens
                         ↓ (Q2)
                    Q2 - Q1 → outcdc (salida final)

sens (Sensor) ──→ Divisor x10 ──→ outsens
```

### Componentes Principales:

1. **Contador de 10 bits**: Clocked por `ref`
2. **Registro REG10**: Captura del contador, reloj por `outsens`
3. **Divisor de Frecuencia x10**: Reduce la frecuencia de `sens`
4. **Registro REG11**: Pipeline secundario
5. **Substractor Final**: Calcula `outcdc = Q2 - Q1`

## 📁 Estructura del Proyecto

```
tdc_module/
├── rtl/              # Código RTL (Verilog/SystemVerilog)
├── tb/               # Testbenches
├── sim/              # Scripts y resultados de simulación
├── fpga/             # Archivos específicos para FPGA
├── asic/             # Archivos específicos para ASIC
├── scripts/          # Scripts de compilación y automatización
├── docs/             # Documentación técnica
├── paper/            # Publicaciones y papers de referencia
├── results/          # Resultados de síntesis, timing, área
├── README.md         # Este archivo
└── .gitignore        # Configuración de Git
```

## 🚀 Quick Start

### Simulación
```bash
cd sim/
./run_simulation.sh
```

### Síntesis FPGA
```bash
cd fpga/
./synthesize.sh
```

### Síntesis ASIC
```bash
cd asic/
./synthesize.sh
```

## 📊 Especificaciones

- **Arquitectura**: Pipeline de 2 etapas
- **Ancho de datos**: 10 bits
- **Modo de operación**: Sincrónico
- **Aplicación**: ASIC y FPGA

## 📝 Parámetros de Entrada

| Parámetro | Tipo | Descripción |
|-----------|------|-------------|
| `clk` | Input | Reloj del sistema |
| `rst_n` | Input | Reset activo bajo |
| `ref` | Input | Oscilador de referencia |
| `sens` | Input | Entrada de sensor |

## 📤 Par��metros de Salida

| Parámetro | Tipo | Descripción |
|-----------|------|-------------|
| `outcdc` | Output [9:0] | Diferencia medida (Q2 - Q1) |

## 👤 Autor

**jedward1977** - ASIC/FPGA Design

## 📄 Licencia

Este proyecto está bajo licencia MIT.

## 📧 Contacto

Para preguntas o sugerencias, contactar al autor.

---

**Última actualización**: 2026-04-30
