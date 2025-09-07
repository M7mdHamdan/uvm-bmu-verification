import uvm_pkg::*;
`include "uvm_macros.svh"

class ClzTest extends uvm_test;

    `uvm_component_utils(ClzTest)
    
    BmuEnvironment bmu_env;

    function new(string name = "ClzTest", uvm_component parent = null);
        super.new(name, parent);
    endfunction 

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        bmu_env = BmuEnvironment::type_id::create("bmu_env", this);
    endfunction 

    task run_phase(uvm_phase phase);
        clzSequence clz_seq = clzSequence::type_id::create("clz_seq");
        
        phase.raise_objection(this);
        `uvm_info(get_type_name(), "Starting CLZ (Count Leading Zeros) Test", UVM_NONE);
        
        clz_seq.start(bmu_env.agent.sequencer);
        
        `uvm_info(get_type_name(), "CLZ Test Completed", UVM_NONE);
        phase.drop_objection(this);
    endtask

endclass
