import uvm_pkg::*;
`include "uvm_macros.svh"

class SubTest extends uvm_test;

    `uvm_component_utils(SubTest)
    
    BmuEnvironment bmu_env;

    function new(string name = "SubTest", uvm_component parent = null);
        super.new(name, parent);
    endfunction 

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        bmu_env = BmuEnvironment::type_id::create("bmu_env", this);
    endfunction 

    task run_phase(uvm_phase phase);
        subSequence sub_seq = subSequence::type_id::create("sub_seq");
        
        phase.raise_objection(this);
        `uvm_info(get_type_name(), "Starting SUB (Subtraction) Test", UVM_NONE);
        
        sub_seq.start(bmu_env.agent.sequencer);
        
        `uvm_info(get_type_name(), "SUB Test Completed", UVM_NONE);
        phase.drop_objection(this);
    endtask

endclass
