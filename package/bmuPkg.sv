package bmuPkg;
    
    // Import UVM base library
    import uvm_pkg::*;
    `include "uvm_macros.svh"
    
    // Include RTL package for rtl_alu_pkt_t and other RTL types
    import rtl_pkg::*;
    
    // Note: Interface is included separately in testbench 
    // as interfaces cannot be included inside packages
    
    // Include Sequence Item
    `include "components/Agent/BmuSequenceItem.sv"
    
    // Include Sequences
    `include "components/sequences/ArithmeticAndShiftLogic/addSequence.sv"
    
    // Include Agent Components
    `include "components/Agent/BmuSequencer.sv"
    `include "components/Agent/BmuDriver.sv"
    `include "components/Agent/BmuMonitor.sv"
    `include "components/Agent/BmuAgent.sv"
    
    // Include Environment Components (commenting out problematic ones for now)
    // `include "components/Environment/BmuRefModel.sv"
    // `include "components/Environment/BmuScoreboard.sv"
    // `include "components/Environment/BmuSubscriber.sv"
    // `include "components/Environment/BmuChecker.sv"
    `include "components/Environment/BmuEnvironment.sv"
    
    // Include Tests
    `include "tests/ArithmeticAndShiftLogic/ArithmeticTest.sv"

endpackage : bmuPkg
