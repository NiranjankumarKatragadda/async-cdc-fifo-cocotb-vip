# Async CDC FIFO Cocotb VIP

[[https://github.com/NiranjankumarKatragadda/async-cdc-fifo-cocotb-vip/actions/workflows/ci.yml/badge.svg]](https://github.com/NiranjankumarKatragadda/async-cdc-fifo-cocotb-vip/actions/workflows/ci.yml)

Parameterized Dual-Clock Gray-Code Asynchronous CDC FIFO (`src/async_cdc_fifo.v`) with 2-FF pointer synchronizers and `wfull`/`rempty` flag generation, verified across independent 100 MHz (`wclk`) and 71.4 MHz (`rclk`) domains with **Cocotb** on **Verilator** and **Icarus Verilog**.

## Quick start
    make -C tb SIM=verilator
    make -C tb SIM=icarus

## Need something similar?
NK Verif Labs offers custom Cocotb VIPs, dual-sim CI, and RTL-to-GDSII services ([nk-verif-labs](https://github.com/nk-verif-labs)). Email **nkveriflabs@gmail.com**.
