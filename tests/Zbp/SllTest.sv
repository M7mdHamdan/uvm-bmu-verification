import uvm_pkg::*;
`include "uvm_macros.svh"

class SllTest extends uvm_test;

    `uvm_component_utils(SllTest)
    
    BmuEnvironment bmu_env;

    function new(string name = "SllTest", uvm_component parent = null);
        super.new(name, parent);
    endfunction 

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        bmu_env = BmuEnvironment::type_id::create("bmu_env", this);
    endfunction 

    task run_phase(uvm_phase phase);
        sllSequence sll_seq = sllSequence::type_id::create("sll_seq");
        
        phase.raise_objection(this);
        `uvm_info(get_type_name(), "Starting SLL (Shift Left Logical) Test", UVM_NONE);
        
        sll_seq.start(bmu_env.agent.sequencer);
        
        `uvm_info(get_type_name(), "SLL Test Completed", UVM_NONE);
        phase.drop_objection(this);
    endtask

endclass
