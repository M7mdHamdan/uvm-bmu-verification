// Include RTL library files in dependency order
// `include "/home/Trainee3/BMU/rtl/library/rtl_pdef.sv"
// // `include "/home/Trainee3/BMU/rtl/library/rtl_param.vh"
// `include "/home/Trainee3/BMU/rtl/library/rtl_defines.vh"
// `include "/home/Trainee3/BMU/rtl/library/rtl_def.sv"
// `include "/home/Trainee3/BMU/rtl/library/rtl_lib.sv"
// `include "/home/Trainee3/BMU/rtl/library/Bit_Manibulation_Unit.sv"


// Include Interface separately (cannot be in package)
// `include "/home/Trainee3/BMU/components/interfaces/BmuInterface.sv"

package bmuPkg;
    
    // Import UVM and RTL packages inside the package
    `include "uvm_macros.svh"
    import uvm_pkg::*;
    // import rtl_pkg::*;
    

    // Include Sequence Item

    `include "/home/Trainee3/BMU/components/Agent/BmuSequenceItem.sv"

    // Include Sequences
    `include "/home/Trainee3/BMU/components/sequences/ArithmeticAndShiftLogic/addSequence.sv"

    // UVM Components (fixed paths for running from sim/)
    `include "/home/Trainee3/BMU/components/Agent/BmuSequencer.sv"
    `include "/home/Trainee3/BMU/components/Agent/BmuDriver.sv"
    `include "/home/Trainee3/BMU/components/Agent/BmuMonitor.sv"
    `include "/home/Trainee3/BMU/components/Agent/BmuAgent.sv"

    //Include Environment Components (commenting out problematic ones for now)
    `include "/home/Trainee3/BMU/components/Environment/BmuRefModel.sv"
    `include "/home/Trainee3/BMU/components/Environment/BmuScoreboard.sv"
    // `include "/home/Trainee3/BMU/components/Environment/BmuSubscriber.sv"
    `include "/home/Trainee3/BMU/components/Environment/BmuChecker.sv"
    `include "/home/Trainee3/BMU/components/Environment/BmuEnvironment.sv"

    // Include Tests
    `include "/home/Trainee3/BMU/tests/ArithmeticAndShiftLogic/ArithmeticTest.sv"

endpackage : bmuPkg
