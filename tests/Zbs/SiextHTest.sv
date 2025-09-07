import uvm_pkg::*;
`include "uvm_macros.svh"

class SiextHTest extends uvm_test;

    `uvm_component_utils(SiextHTest)
    
    BmuEnvironment bmu_env;

    function new(string name = "SiextHTest", uvm_component parent = null);
        super.new(name, parent);
    endfunction 

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        bmu_env = BmuEnvironment::type_id::create("bmu_env", this);
    endfunction 

    task run_phase(uvm_phase phase);
        siextHSequence siext_h_seq = siextHSequence::type_id::create("siext_h_seq");
        
        phase.raise_objection(this);
        `uvm_info(get_type_name(), "Starting SIEXT_H (Sign Extend Half-Word) Test", UVM_NONE);
        
        siext_h_seq.start(bmu_env.agent.sequencer);
        
        `uvm_info(get_type_name(), "SIEXT_H Test Completed", UVM_NONE);
        phase.drop_objection(this);
    endtask

endclass
