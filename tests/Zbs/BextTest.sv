import uvm_pkg::*;
`include "uvm_macros.svh"
class BextTest extends uvm_test;
    BmuEnvironment env;
    //Sequences
    bextSequence bextSeq;

    `uvm_component_utils(BextTest)
    function new (string name, uvm_component parent);
        super.new(name, parent);
    endfunction


    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        env = BmuEnvironment::type_id::create("env", this);
    endfunction

    task run_phase(uvm_phase phase);
        super.run_phase(phase);
        phase.raise_objection(this);
        bextSeq = bextSequence::type_id::create("bextSeq");
    
        bextSeq.start(env.agent.sequencer);
        phase.drop_objection(this);
        `uvm_info(get_type_name(), "End of BEXT regression test", UVM_LOW);

    endtask



endclass: BextTest
