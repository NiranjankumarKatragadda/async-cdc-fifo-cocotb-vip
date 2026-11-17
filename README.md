# Async CDC FIFO Cocotb VIP

[[https://github.com/NiranjankumarKatragadda/async-cdc-fifo-cocotb-vip/actions/workflows/ci.yml/badge.svg]](https://github.com/NiranjankumarKatragadda/async-cdc-fifo-cocotb-vip/actions/workflows/ci.yml)

Parameterized Dual-Clock Gray-Code Asynchronous CDC FIFO (`src/async_cdc_fifo.v`) with 2-FF pointer synchronizers and `wfull`/`rempty` flag generation, verified across independent 100 MHz (`wclk`) and 71.4 MHz (`rclk`) domains with **Cocotb** on **Verilator** and **Icarus Verilog**.
