'timescale 1ms/100ns
module fsm_vending_machine_tb();
  reg clk,rst,
  reg [1:0]coin,
  wire x,

  fsm_vending_machine dut(clk,rst,coin,x);
  task initialize();
    begin
      clk=1'b0;
      coin=2'b00;
    end
  endtask

  always #0.5 clk = ~clk;

  task rst_dut();
    begin
      rst=1'b1;
      #1;
      rst=1'b0;
    end
  endtask

  task stimulus (input [1:0] j);
    begin
      @(negedge clk)
      coin = j;
    end
  endtask

  initial begin
    initialize;
    rst_dut;
    stimulus(2'b10);
    stimulus(2'b10);
    stimulus(2'b10);
    stimulus(2'b10);
    stimulus(2'b11);
    stimulus(2'b11);
    stimulus(2'b10);
    stimulus(2'b0x);
    #6145;
    stimulus(2'b10);
    stimulus(2'b10);
    stimulus(2'b10);
    stimulus(2'b10);
    $finish;
  end
  initial
    $monitor("Product Delivered = %b",x);
endmodule
endmodule

  
