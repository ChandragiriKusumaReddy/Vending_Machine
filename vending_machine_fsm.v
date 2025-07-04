module fsm_vending_machine(
  input clk,rst,
  input [1:0] coin,
  output reg x);
  parameter idle = 2'b00;
  parameter s1 = 2'b01;
  parameter s2 = 2'b10;
  parameter s3 = 2'b11;

  reg soft_rst;
  reg [9:0] count_clk;
  reg [2:0]count_sec;
  reg [1:0] ps,ns;

  //Logic that counts the clock cycles
  always@(posedge clk, posedge rst)
    initial begin
      if(rst)
        count_clk<=0;
      else 
        begin
          if ((coin[1]==1'b0) && ((ps==s1) || (ps==s2) ||(ps==s3)))
            count_clk<=count_clk+1'b1;
          else
            count_clk<=0;
        end
    end

  //Logic for counter that counts sec pulses
  always@(posedge clk, posedge rst)
    begin
      if(rst)
        begin
          count_sec<=0;
          soft_rst<=1'b0;
        end
      else
        begin
          if(coin[1]!=1'b0)
            count_sec<=0;
          soft_rst<=1'b0;
        end
      else
        begin
          if(count_clk == 1023)
            begin
              if(count_sec==5)
                begin
                  count_sec<=0;
                  soft_rst<=1'b1;
                end
              begin
                count_sec<=count_sec+1'b1;
                soft_rst<=1'b0;
              end
            end
        end
    end

  //Present state logic
  always@(posedge clk or posedge rst)
    begin
      if(rst)
        ps<=idle;
      else if(soft_rst)
        ps<=idle;
      else
        ps<=ns;
    end

  //Next state logic
  always@(*)
    begin
      ns=idle;
      case(ps)
        idle : if(coin == 2'b10)
          ns=s1;
        else if(coin == 2'b11)
          ns=s2;
        else
          ns=idle;
        s1 : if (coin == 2'b10)
          ns=s2;
        else if (coin == 2'b11)
          ns=s3;
        else
          ns=s1;
        s2 : if(coin == 2'b10)
          ns=s3;
        else if (coin == 2'b11)
          ns=idle;
        else
          ns=s2;
        s3 : if (coin == 2'b10) || (coin == 2'b11)
          ns=idle;
        else ns=s3;
      endcase
    end

  //output logic
  always@(posedge clk or posedge rst)
    begin
      if(rst)
        begin
          x<=1'b0;
        end
      else if (soft_rst)
        begin
          x<=1'b0;
        end
      else
        begin
          case(ps)
            idle,s1 : x<=1'b0;
            s2 : if (coin==2'b11)
              x<=1'b1;
            else
              x<=1'b0;
            s3 : if((coin==2'b10) || (coin==2'b11))
              x<=1'b1;
            default : x<=1'b0;
          endcase
        end
    end
endmodule

    
  
                
