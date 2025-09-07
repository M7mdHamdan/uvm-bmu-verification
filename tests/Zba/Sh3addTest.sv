import uvm_pkg::*;
`include "uvm_macros.svh"

class Sh3addTest extends uvm_test;

    `uvm_component_utils(Sh3addTest)
    
    BmuEnvironment bmu_env;

    function new(string name = "Sh3addTest", uvm_component parent = null);
        super.new(name, parent);
    endfunction 

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        bmu_env = BmuEnvironment::type_id::create("bmu_env", this);
    endfunction 

    task run_phase(uvm_phase phase);
        sh3addSequence sh3add_seq = sh3addSequence::type_id::create("sh3add_seq");
        
        phase.raise_objection(this);
        `uvm_info(get_type_name(), "Starting SH3ADD Test", UVM_NONE);
        
        sh3add_seq.start(bmu_env.agent.sequencer);
        
        `uvm_info(get_type_name(), "SH3ADD Test Completed", UVM_NONE);
        phase.drop_objection(this);
    endtask

endclass
