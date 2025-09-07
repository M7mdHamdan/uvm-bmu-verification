import uvm_pkg::*;
`include "uvm_macros.svh"

class MinTest extends uvm_test;

    `uvm_component_utils(MinTest)
    
    BmuEnvironment bmu_env;

    function new(string name = "MinTest", uvm_component parent = null);
        super.new(name, parent);
    endfunction 

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        bmu_env = BmuEnvironment::type_id::create("bmu_env", this);
    endfunction 

    task run_phase(uvm_phase phase);
        minSequence min_seq = minSequence::type_id::create("min_seq");
        
        phase.raise_objection(this);
        `uvm_info(get_type_name(), "Starting MIN (Minimum) Test", UVM_NONE);
        
        min_seq.start(bmu_env.agent.sequencer);
        
        `uvm_info(get_type_name(), "MIN Test Completed", UVM_NONE);
        phase.drop_objection(this);
    endtask

endclass
