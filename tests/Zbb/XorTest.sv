import uvm_pkg::*;
`include "uvm_macros.svh"

class XorTest extends uvm_test;

    `uvm_component_utils(XorTest)
    
    BmuEnvironment bmu_env;

    function new(string name = "XorTest", uvm_component parent = null);
        super.new(name, parent);
    endfunction 

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        bmu_env = BmuEnvironment::type_id::create("bmu_env", this);
    endfunction 

    task run_phase(uvm_phase phase);
        xorSequence xor_seq = xorSequence::type_id::create("xor_seq");
        
        phase.raise_objection(this);
        `uvm_info(get_type_name(), "Starting XOR (Bitwise Exclusive OR) Test", UVM_NONE);
        
        xor_seq.start(bmu_env.agent.sequencer);
        
        `uvm_info(get_type_name(), "XOR Test Completed", UVM_NONE);
        phase.drop_objection(this);
    endtask

endclass
