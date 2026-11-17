SIM ?= verilator
TOPLEVEL_LANG ?= verilog
VERILOG_SOURCES += $(PWD)/../src/async_cdc_fifo.v
TOPLEVEL := async_cdc_fifo
MODULE := test_cdc_fifo
ifeq ($(SIM),verilator)
EXTRA_ARGS += -Wno-fatal -Wno-WIDTH -Wno-lint -Wno-style
endif
include $(shell cocotb-config --makefiles)/Makefile.sim
