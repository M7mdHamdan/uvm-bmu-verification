// Include RTL library files in dependency order
// `include "/home/Trainee3/BMU/rtl/library/rtl_pdef.sv"
// // `include "/home/Trainee3/BMU/rtl/library/rtl_param.vh"
// `include "/home/Trainee3/BMU/rtl/library/rtl_defines.vh"
// `include "/home/Trainee3/BMU/rtl/library/rtl_def.sv"
// `include "/home/Trainee3/BMU/rtl/library/rtl_lib.sv"
// `include "/home/Trainee3/BMU/rtl/library/Bit_Manibulation_Unit.sv"


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
    `include "../components/sequences/Zbb/addSequence.sv"//tst sequence
    `include "../components/sequences/Zbb/AND/andSequence.sv"
    `include "../components/sequences/Zbb/CPOP/cpopSequence.sv"

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

    // // Include Tests
    `include "../tests/Zbb/ArithmeticTest.sv"
    `include "../tests/Zbb/AndTest.sv"
    `include "../tests/Zbb/CpopTest.sv"

endpackage : bmuPkg
