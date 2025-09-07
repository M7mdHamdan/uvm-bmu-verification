import uvm_pkg::*;
`include "uvm_macros.svh"

class PackuTest extends uvm_test;

    `uvm_component_utils(PackuTest)
    
    BmuEnvironment bmu_env;

    function new(string name = "PackuTest", uvm_component parent = null);
        super.new(name, parent);
    endfunction 

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        bmu_env = BmuEnvironment::type_id::create("bmu_env", this);
    endfunction 

    task run_phase(uvm_phase phase);
        packuSequence packu_seq = packuSequence::type_id::create("packu_seq");
        
        phase.raise_objection(this);
        `uvm_info(get_type_name(), "Starting PACKU (Pack Upper) Test", UVM_NONE);
        
        packu_seq.start(bmu_env.agent.sequencer);
        
        `uvm_info(get_type_name(), "PACKU Test Completed", UVM_NONE);
        phase.drop_objection(this);
    endtask

endclass
