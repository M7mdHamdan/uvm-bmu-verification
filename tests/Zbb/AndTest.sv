import uvm_pkg::*;
`include "uvm_macros.svh"
// Don't import bmuPkg here - this file is already included in the package
class AndTest extends uvm_test;
    BmuEnvironment env;
    //Sequences
    andSequence andSeq;

    `uvm_component_utils(AndTest)
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
        andSeq = andSequence::type_id::create("andSeq");
        andSeq.start(env.agent.sequencer);
        phase.drop_objection(this);
        `uvm_info(get_type_name(), "End of BMU regression test", UVM_LOW);

    endtask



endclass: AndTest