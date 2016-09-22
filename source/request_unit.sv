/*
  Apoorv Wairagade
  awairaga@purdue.edu
  mg286
  Sept 11, 2016

  request unit 
*/

`include "request_unit_if.vh"
`include "cpu_types_pkg.vh"

import cpu_types_pkg::*;

module request_unit (
  input logic CLK, 
  input logic nRST,
  request_unit_if.ru ruif
);
  
  // enable PC to be updated when this signal is high
  //assign ruif.updatePC = ~ruif.ihit && ~(ruif.CUdren|ruif.CUdwen);
  
  assign ruif.updatePC = ruif.ihit;

  // assign ruif.updatePC = (ruif.CUdren|ruif.CUdwen) ? ruif.dhit : ruif.ihit;
  // Above statement is still in doubt

  always_ff @(posedge CLK , negedge nRST) begin 
    if(~nRST) begin
      ruif.iren <= 1;
      ruif.dwen <= 0;
      ruif.dren <= 0;
    end else begin
      if(ruif.CUhalt) begin
        ruif.iren <= 0;
        ruif.dren <= 0;
        ruif.dwen <= 0;
      end
      // ruif.iren <= 1;
      else if(ruif.ihit) begin
        ruif.dren <= ruif.CUdren;
        ruif.dwen <= ruif.CUdwen;
      end
      else if(ruif.dhit) begin
        ruif.dren <= 0;
        ruif.dwen <= 0;
      end
    end
  end
endmodule