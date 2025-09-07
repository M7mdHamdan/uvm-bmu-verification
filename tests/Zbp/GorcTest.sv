import uvm_pkg::*;
`include "uvm_macros.svh"

class GorcTest extends uvm_test;

    `uvm_component_utils(GorcTest)
    
    BmuEnvironment bmu_env;

    function new(string name = "GorcTest", uvm_component parent = null);
        super.new(name, parent);
    endfunction 

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        bmu_env = BmuEnvironment::type_id::create("bmu_env", this);
    endfunction 

    task run_phase(uvm_phase phase);
        gorcSequence gorc_seq = gorcSequence::type_id::create("gorc_seq");
        
        phase.raise_objection(this);
        `uvm_info(get_type_name(), "Starting GORC (Bitwise OR-Combine) Test", UVM_NONE);
        
        gorc_seq.start(bmu_env.agent.sequencer);
        
        `uvm_info(get_type_name(), "GORC Test Completed", UVM_NONE);
        phase.drop_objection(this);
    endtask

endclass
