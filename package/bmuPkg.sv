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
    `include "../components/sequences/Zbb/AND/andErrSequence.sv"
    `include "../components/sequences/Zbb/CPOP/cpopSequence.sv"
    `include "../components/sequences/Zbb/CLZ/clzSequence.sv"
    `include "../components/sequences/Zbb/MIN/minSequence.sv"
    `include "../components/sequences/Zbb/SUB/subSequence.sv"
    `include "../components/sequences/Zbb/XOR/xorSequence.sv"
    `include "../components/sequences/Zbb/SLT/sltSequence.sv"
    `include "../components/sequences/Zba/SH3ADD/sh3addSequence.sv"
    `include "../components/sequences/Zbs/BEXT/bextSequence.sv"
    `include "../components/sequences/Zbs/SIEXT_H/siextHSequence.sv"
    //CSR
    `include "../components/sequences/CSR/csrSequence.sv"
    `include "../components/sequences/CSR/Read/csrReadSequence.sv"
    `include "../components/sequences/CSR/Write/csrWriteSequence.sv"
    `include "../components/sequences/CSR/Write/csrWriteErrSequence.sv"
    //
    `include "../components/sequences/Zbp/ROL/rolSequence.sv"
    `include "../components/sequences/Zbp/PACKU/packuSequence.sv"
    `include "../components/sequences/Zbp/GORC/gorcSequence.sv"
    `include "../components/sequences/Zbp/SLL/sllSequence.sv"
    `include "../components/sequences/Zbp/SRA/sraSequence.sv"

    // UVM Components (fixed paths for running from sim/)
    `include "../components/Agent/BmuSequencer.sv"
    `include "../components/Agent/BmuDriver.sv"
    `include "../components/Agent/BmuMonitor.sv"
    `include "../components/Agent/BmuAgent.sv"

    //Include Environment Components (commenting out problematic ones for now)
    `include "../components/Environment/BmuRefModel.sv"
    `include "../components/Environment/BmuScoreboard.sv"
    `include "../components/Environment/BmuSubscriber.sv"
    `include "../components/Environment/BmuChecker.sv"
    `include "../components/Environment/BmuEnvironment.sv"

    // // Include Tests
    `include "../tests/Zbb/ArithmeticTest.sv"
    `include "../tests/Zbb/AndTest.sv"
    `include "../tests/Zbb/CpopTest.sv"
    `include "../tests/Zbb/ClzTest.sv"
    `include "../tests/Zbb/MinTest.sv"
    `include "../tests/Zbb/SubTest.sv"
    `include "../tests/Zbb/SltTest.sv"
    `include "../tests/Zbb/XorTest.sv"
    `include "../tests/Zba/Sh3addTest.sv"
    `include "../tests/Zbs/BextTest.sv"
    `include "../tests/Zbs/SiextHTest.sv"
    `include "../tests/CSR/CsrTest.sv"
    `include "../tests/Zbp/RolTest.sv"
    `include "../tests/Zbp/PackuTest.sv"
    `include "../tests/Zbp/GorcTest.sv"
    `include "../tests/Zbp/SllTest.sv"
    `include "../tests/Zbp/SraTest.sv"
    `include "../tests/ComprehensiveCoverageTest.sv"
    `include "../tests/MegaCoverageTest.sv"

endpackage : bmuPkg
