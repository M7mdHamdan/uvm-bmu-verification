import uvm_pkg::*;
`include "uvm_macros.svh"

class SltTest extends uvm_test;

    `uvm_component_utils(SltTest)
    
    BmuEnvironment bmu_env;

    function new(string name = "SltTest", uvm_component parent = null);
        super.new(name, parent);
    endfunction 

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        bmu_env = BmuEnvironment::type_id::create("bmu_env", this);
    endfunction 

    task run_phase(uvm_phase phase);
        sltSequence slt_seq = sltSequence::type_id::create("slt_seq");
        
        phase.raise_objection(this);
        `uvm_info(get_type_name(), "Starting SLT (Set on Less Than) Test", UVM_NONE);
        
        slt_seq.start(bmu_env.agent.sequencer);
        
        `uvm_info(get_type_name(), "SLT Test Completed", UVM_NONE);
        phase.drop_objection(this);
    endtask

endclass
