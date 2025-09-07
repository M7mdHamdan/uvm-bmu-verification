import uvm_pkg::*;
`include "uvm_macros.svh"

class SraTest extends uvm_test;

    `uvm_component_utils(SraTest)
    
    BmuEnvironment bmu_env;

    function new(string name = "SraTest", uvm_component parent = null);
        super.new(name, parent);
    endfunction 

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        bmu_env = BmuEnvironment::type_id::create("bmu_env", this);
    endfunction 

    task run_phase(uvm_phase phase);
        sraSequence sra_seq = sraSequence::type_id::create("sra_seq");
        
        phase.raise_objection(this);
        `uvm_info(get_type_name(), "Starting SRA (Shift Right Arithmetic) Test", UVM_NONE);
        
        sra_seq.start(bmu_env.agent.sequencer);
        
        `uvm_info(get_type_name(), "SRA Test Completed", UVM_NONE);
        phase.drop_objection(this);
    endtask

endclass
