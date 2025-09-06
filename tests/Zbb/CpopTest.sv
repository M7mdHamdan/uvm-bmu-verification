import uvm_pkg::*;
`include "uvm_macros.svh"
class CpopTest extends uvm_test;
    BmuEnvironment env;
    //Sequences
    cpopSequence cpopSeq;

    `uvm_component_utils(CpopTest)
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
        cpopSeq = cpopSequence::type_id::create("cpopSeq");
    
        cpopSeq.start(env.agent.sequencer);
        phase.drop_objection(this);
        `uvm_info(get_type_name(), "End of CPOP regression test", UVM_LOW);

    endtask



endclass: CpopTest
