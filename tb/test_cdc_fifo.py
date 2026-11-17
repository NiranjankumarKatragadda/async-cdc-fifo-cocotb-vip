import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge, Timer, with_timeout

@cocotb.test()
async def test_cdc_fifo_stress(dut):
    cocotb.start_soon(Clock(dut.wclk, 10, units="ns").start())
    cocotb.start_soon(Clock(dut.rclk, 14, units="ns").start())
    dut.wrst_n.value = 0; dut.rrst_n.value = 0; dut.winc.value = 0; dut.rinc.value = 0; dut.wdata.value = 0
    await Timer(50, units="ns"); dut.wrst_n.value = 1; dut.rrst_n.value = 1
    sent, recvd = [], []
    async def writer():
        for i in range(256):
            v = (0xA5000000 | i) ^ (i << 12)
            dut.wdata.value = v; dut.winc.value = 1
            while True:
                await RisingEdge(dut.wclk)
                if int(dut.wfull.value) == 0: sent.append(v); break
        dut.winc.value = 0
    async def reader():
        dut.rinc.value = 1
        while len(recvd) < 256:
            await RisingEdge(dut.rclk)
            if int(dut.rempty.value) == 0: recvd.append(int(dut.rdata.value))
        dut.rinc.value = 0
    w_t = cocotb.start_soon(writer()); r_t = cocotb.start_soon(reader())
    await with_timeout(w_t, 50, "us"); await with_timeout(r_t, 50, "us")
    assert recvd == sent and len(recvd) == 256, f"Mismatch: got {len(recvd)}/{len(sent)}"
    dut._log.info("PASS: 256 words verified across async 100MHz/71.4MHz CDC domains!")
