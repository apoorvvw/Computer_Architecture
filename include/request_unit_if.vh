/*
  Apoorv Wairagade
  awairaga@purdue.edu
  mg286
  Sept 11, 2016

  request unit interface
*/
`ifndef REQUEST_UNIT_IF_VH
`define REQUEST_UNIT_IF_VH

// all types
`include "cpu_types_pkg.vh"

interface request_unit_if;
  // import types
  import cpu_types_pkg::*;

  logic ihit, dhit, CUdren, CUdwen, CUhalt;
  logic updatePC, iren, dwen, dren;

  // register file ports
  modport ru (
    input   ihit, dhit, CUdwen, CUdren, CUhalt,
    output  updatePC, dren, iren, dwen
  );
  // register file tb
  modport tb (
    output   ihit, dhit, CUdwen, CUdren, CUhalt, 
    input  updatePC, dren, iren, dwen
  );
endinterface

`endif //REQUEST_UNIT_IF_VH
