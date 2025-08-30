`timescale 1ns/1ps

// Define missing parameters before including RTL files
// package pt;
//     parameter BITMANIP_ZBB = 1;
//     parameter BITMANIP_ZBS = 1;
//     parameter BITMANIP_ZBP = 1;
//     parameter BITMANIP_ZBA = 1;
//     parameter BITMANIP_ZBE = 1;
//     parameter BITMANIP_ZBF = 1;
// endpackage

// // Include RTL library files in dependency order
// `include "../rtl/library/rtl_pdef.vh"
// `include "../rtl/library/rtl_param.vh"
// `include "../rtl/library/rtl_defines.vh"
// `include "../rtl/library/rtl_def.sv"
// `include "../rtl/library/rtl_lib.sv"
// `include "../rtl/library/Bit_Manipulation_Unit.sv"

// Include Interface separately (cannot be in package)
`include "../components/interfaces/BmuInterface.sv"

package bmuPkg;
    
    // Import UVM and RTL packages inside the package
    `include "uvm_macros.svh"
    import uvm_pkg::*;
    // import rtl_pkg::*;
    
    // Include Sequence Item
    `include "../components/Agent/BmuSequenceItem.sv"
    
    // Include Sequences
    `include "../components/sequences/ArithmeticAndShiftLogic/addSequence.sv"
    
    // UVM Components (fixed paths for running from sim/)
    `include "../components/Agent/BmuSequencer.sv"
    `include "../components/Agent/BmuDriver.sv"
    `include "../components/Agent/BmuMonitor.sv"
    `include "../components/Agent/BmuAgent.sv"
    
    //Include Environment Components (commenting out problematic ones for now)
    `include "../components/Environment/BmuRefModel.sv"
    `include "../components/Environment/BmuScoreboard.sv"
    // `include "../components/Environment/BmuSubscriber.sv"
    `include "../components/Environment/BmuChecker.sv"
    `include "../components/Environment/BmuEnvironment.sv"

    // Include Tests
    `include "../tests/ArithmeticAndShiftLogic/ArithmeticTest.sv"

endpackage : bmuPkg
