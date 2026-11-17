`default_nettype none
module async_cdc_fifo #(parameter DATA_W=32, ADDR_W=4) (
  input wire wclk, input wire wrst_n, input wire winc, input wire [DATA_W-1:0] wdata, output reg wfull,
  input wire rclk, input wire rrst_n, input wire rinc, output wire [DATA_W-1:0] rdata, output reg rempty
);
  localparam DEPTH = 1 << ADDR_W;
  reg [DATA_W-1:0] mem [0:DEPTH-1];
  reg [ADDR_W:0] wbin, wptr, wq1_rptr, wq2_rptr, rbin, rptr, rq1_wptr, rq2_wptr;
  wire [ADDR_W:0] wbin_n = wbin + ((winc && !wfull) ? {{ADDR_W{1'b0}},1'b1} : {(ADDR_W+1){1'b0}});
  wire [ADDR_W:0] wgray_n = (wbin_n >> 1) ^ wbin_n;
  wire [ADDR_W:0] rbin_n = rbin + ((rinc && !rempty) ? {{ADDR_W{1'b0}},1'b1} : {(ADDR_W+1){1'b0}});
  wire [ADDR_W:0] rgray_n = (rbin_n >> 1) ^ rbin_n;
  assign rdata = mem[rbin[ADDR_W-1:0]];
  always @(posedge wclk or negedge wrst_n) begin
    if (!wrst_n) begin wbin<=0; wptr<=0; wq1_rptr<=0; wq2_rptr<=0; wfull<=0; end
    else begin
      if (winc && !wfull) mem[wbin[ADDR_W-1:0]] <= wdata;
      wq1_rptr <= rptr; wq2_rptr <= wq1_rptr; wbin <= wbin_n; wptr <= wgray_n;
      wfull <= (wgray_n == {~wq2_rptr[ADDR_W:ADDR_W-1], wq2_rptr[ADDR_W-2:0]});
    end
  end
  always @(posedge rclk or negedge rrst_n) begin
    if (!rrst_n) begin rbin<=0; rptr<=0; rq1_wptr<=0; rq2_wptr<=0; rempty<=1; end
    else begin
      rq1_wptr <= wptr; rq2_wptr <= rq1_wptr; rbin <= rbin_n; rptr <= rgray_n;
      rempty <= (rgray_n == rq2_wptr);
    end
  end
endmodule
`default_nettype wire
