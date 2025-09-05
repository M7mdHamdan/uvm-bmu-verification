import uvm_pkg::*;
`include "uvm_macros.svh"
`include "../rtl/library/rtl_pdef.sv"
`include "../rtl/library/rtl_defines.sv"
`include "../rtl/library/rtl_lib.sv"
`include "../rtl/library/rtl_def.sv"
`include "../rtl/library/Bit_Manipulation_Unit.sv"

`include "../package/bmuPkg.sv"

import bmuPkg::*;
module testbench;

    
    logic clk, rstL;
    always #5 clk = ~clk;
    
    BmuInterface bmuIf(clk);

    // DUT
    Bit_Manipulation_Unit dut (
        .clk(bmuIf.clk),
        .rst_l(bmuIf.rstL),
        .scan_mode(bmuIf.scanMode),
        .valid_in(bmuIf.validIn),
        .ap(bmuIf.ap),
        .csr_ren_in(bmuIf.csrRenIn),
        .csr_rddata_in(bmuIf.csrRdataIn),
        .a_in(bmuIf.aIn),
        .b_in(bmuIf.bIn),
        .result_ff(bmuIf.resultFf),
        .error(bmuIf.error)
    );

    initial begin
        uvm_config_db#(virtual BmuInterface)::set(uvm_root::get(), "*", "vif", bmuIf);
    end
    initial begin
        clk = 0;
        rstL = 1; 
    end
    initial begin
        run_test();
    end
    initial begin
        $shm_open("waves.shm",1);
        $shm_probe("AS");
    end

    initial begin
        $display("simulation started");
        #10000000000000000; 
        $display("simulation finished");
        $finish; 
    end
endmodule