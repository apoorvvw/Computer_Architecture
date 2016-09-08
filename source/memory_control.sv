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

  assign ccif.iwait = (ccif.ramstate == ACCESS) ? ((ccif.iREN) && (!ccif.dREN && !ccif.dWEN) ? 0 : 1) : 1;
  assign ccif.dwait = (ccif.ramstate == ACCESS) ? ((ccif.dREN || ccif.dWEN) ? 0 : 1) : 1;

  always_comb begin
    
    ccif.ramaddr = '0;
    ccif.ramWEN = 0;
    ccif.ramREN = 0;
    ccif.ramstore = 0;
    ccif.dload = 0;
    ccif.iload = 0;

    if (ccif.dWEN) begin
      ccif.ramaddr = ccif.daddr;
      ccif.ramWEN = 1;
      ccif.ramREN = 0;
      ccif.ramstore = ccif.dstore;
    end
    else if (ccif.dREN) begin
      ccif.ramaddr = ccif.daddr;
      ccif.ramWEN = 0;
      ccif.ramREN = 1;
      ccif.dload = ccif.ramload;
    end
    else if (ccif.iREN) begin
      ccif.ramaddr = ccif.iaddr;
      ccif.ramWEN = 0;
      ccif.ramREN = 1;
      ccif.iload = ccif.ramload;
    end
  end

endmodule