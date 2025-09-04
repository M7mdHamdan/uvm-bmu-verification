import uvm_pkg::*;
`include "uvm_macros.svh"
class ArithmeticTest extends uvm_test;
    BmuEnvironment env;
    //Sequences
    addSequence addSeq;

    `uvm_component_utils(ArithmeticTest)
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
        addSeq = addSequence::type_id::create("addSeq");
    
        addSeq.start(env.agent.sequencer);
        #10;
        phase.drop_objection(this);
        `uvm_info(get_type_name(), "End of BMU regression test", UVM_LOW);

    endtask



endclass: ArithmeticTest