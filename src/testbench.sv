module async_fifo_TB;

  parameter DATA_WIDTH = 8;
  parameter BRUST_SIZE = 512;
  wire [DATA_WIDTH-1:0] data_out;
  wire full, write_error;
  wire empty, read_error;
  reg [DATA_WIDTH-1:0] data_in;
  reg w_en, wclk, wrst_n;
  reg r_en, rclk, rrst_n;


  asynchronous_fifo as_fifo (wclk, wrst_n,rclk, rrst_n,w_en,r_en,data_in,data_out,full,empty,write_error,read_error);

  always #2.083ns wclk = ~wclk;
  always #1.25ns rclk = ~rclk;
  
  initial begin
    $monitor("time=%2t, Write_en=%b Read_en=%b full=%b empty=%b write_error=%b, read_error=%b",$time,w_en,r_en,full,empty,write_error,read_error);
    wclk = 1'b0; wrst_n = 1'b0;
    w_en = 1'b0;
    data_in = 0;
    // read 
    rclk = 1'b0; rrst_n = 1'b0;
    r_en = 1'b0;
    
    repeat(10) @(posedge wclk);
    wrst_n = 1'b1;
    rrst_n = 1'b1;
    w_en =1'b1;
    
      // reads after write's 
      for (int i=0; i<256; i++) begin
        @(posedge wclk)
          data_in = $urandom;
      end
     
      w_en = 1'b0;
      #50;

      for (int i=0; i< 256; i++) begin
      @(posedge rclk) r_en = '1;
       @(posedge rclk) r_en = '0;
       @(posedge rclk) ;
      end
      r_en = 1'b0;
      #50;
   
      // Write error :- even if fifo is full if your writing data to fifo it should give write_error
        w_en = 1'b1;
       for (int i=0; i<257; i++) begin
        @(posedge wclk)
          data_in = $urandom;
       end

       repeat(4) @(posedge wclk);
        w_en = 1'b0;
        #50;
  
      //Read error :- even if fifo is empty if your reading data from the fifo it should give read_error
      for (int i=0; i< 257; i++) begin
       @(posedge rclk) r_en = '1;
       @(posedge rclk) r_en = '0;
       @(posedge rclk) ;
       end
       r_en = 1'b0;
       #50;
      
      fork
        write();
        read();
      join
   
    

    $finish;
  end
  
  task write;
     w_en =1'b1;
      for (int i=0; i<BRUST_SIZE; i++) begin
        @(posedge wclk)
          data_in = $urandom;
      end
      w_en = 1'b0;
      #50;
  endtask

  task read;
      for (int i=0; i<BRUST_SIZE; i++) begin
       @(posedge rclk) r_en = '1;
       @(posedge rclk) r_en = '0;
       @(posedge rclk) ;
      end
     #50;

  endtask

endmodule