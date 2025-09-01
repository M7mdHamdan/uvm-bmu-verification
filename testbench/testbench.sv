import uvm_pkg::*;
import bmuPkg::*;


`include "uvm_macros.svh"
// `include "/home/Trainee3/BMU/rtl/library/rtl_def.sv"
`include "/home/Trainee3/BMU/rtl/library/Bit_Manibulation_Unit.sv"

`include "package/bmuPkg.sv"

module testbench;
    logic clk, rstL;
    always #5 clk = ~clk;
    
    BmuInterface bmuIf(clk);

    // DUT commented out due to compilation issues
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
        run_test("ArithmeticTest");
    end

    initial begin
        clk = 0;
        rstL = 0;
        #10 rstL = 1; 
        #10 rstL = 0;
    end

    initial begin
        $shm_open("waves.shm",1);
        $shm_probe("AS");
    end

    initial begin
        $display("simulation finished");
        #100000; 
        $finish; 
    end
endmodule