import uvm_pkg::*;
`include "uvm_macros.svh"

class RolTest extends uvm_test;

    `uvm_component_utils(RolTest)
    
    BmuEnvironment bmu_env;

    function new(string name = "RolTest", uvm_component parent = null);
        super.new(name, parent);
    endfunction 

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        bmu_env = BmuEnvironment::type_id::create("bmu_env", this);
    endfunction 

    task run_phase(uvm_phase phase);
        rolSequence rol_seq = rolSequence::type_id::create("rol_seq");
        
        phase.raise_objection(this);
        `uvm_info(get_type_name(), "Starting ROL (Rotate Left) Test", UVM_NONE);
        
        rol_seq.start(bmu_env.agent.sequencer);
        
        `uvm_info(get_type_name(), "ROL Test Completed", UVM_NONE);
        phase.drop_objection(this);
    endtask

endclass
