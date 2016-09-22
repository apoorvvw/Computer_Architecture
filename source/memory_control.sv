/*
  Eric Villasenor
  evillase@gmail.com

  this block is the coherence protocol
  and artibtration for ram
*/

// interface include
`include "cache_control_if.vh"

// memory types
`include "cpu_types_pkg.vh"

module memory_control (
  input CLK, nRST,
  cache_control_if.cc ccif
);
  // type import
  import cpu_types_pkg::*;

  // number of cpus for cc
  parameter CPUS = 2;

  always_comb
  begin
    if (ccif.ramstate == ACCESS)
    begin
      if (ccif.dREN || ccif.dWEN)
        ccif.iwait = 1'b1;
      else
        ccif.iwait = 1'b0;
        
      if (ccif.iREN && ~(ccif.dREN || ccif.dWEN))
        ccif.dwait = 1'b1;
      else
        ccif.dwait = 1'b0;
    end
    else
    begin
        ccif.iwait = 1'b1;
        ccif.dwait = 1'b1;
    end
  end

  always_comb begin
    
    ccif.ramaddr = '0;
    ccif.ramWEN = 0;
    ccif.ramREN = 0;
    //ccif.ramstore = 0;
    //ccif.dload = 0;
    //ccif.iload = 0;

    if (ccif.dWEN) begin
      ccif.ramaddr = ccif.daddr;
      ccif.ramWEN = 1;
      ccif.ramREN = 0;
    end
    else if (ccif.dREN) begin
      ccif.ramaddr = ccif.daddr;
      ccif.ramWEN = 0;
      ccif.ramREN = 1;
      //ccif.dload = ccif.ramload;
    end
    else if (ccif.iREN) begin
      ccif.ramaddr = ccif.iaddr;
      ccif.ramWEN = 0;
      ccif.ramREN = 1;
      //ccif.iload = ccif.ramload;
    end
  end

  assign ccif.iload = ccif.ramload; 
  assign ccif.dload = ccif.ramload; 
  assign ccif.ramstore = ccif.dstore;

endmodule