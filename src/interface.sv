interface interface_fifo;
  parameter DATA_WIDTH = 8;
  logic wclk, wrst_n;
  logic rclk, rrst_n;
  logic w_en, r_en;
  logic [DATA_WIDTH-1:0] data_in;
  logic [DATA_WIDTH-1:0] data_out;
  logic full, empty, write_error, read_error;

endinterface 
