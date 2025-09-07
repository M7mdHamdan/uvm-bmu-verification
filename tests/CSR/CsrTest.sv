import uvm_pkg::*;
`include "uvm_macros.svh"

class CsrTest extends uvm_test;

    `uvm_component_utils(CsrTest)
    
    BmuEnvironment bmu_env;

    function new(string name = "CsrTest", uvm_component parent = null);
        super.new(name, parent);
    endfunction 

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        bmu_env = BmuEnvironment::type_id::create("bmu_env", this);
    endfunction 

    task run_phase(uvm_phase phase);
        csrSequence csr_seq = csrSequence::type_id::create("csr_seq");
        csrWriteSequence csr_write_seq = csrWriteSequence::type_id::create("csr_write_seq");
        csrReadSequence csr_read_seq = csrReadSequence::type_id::create("csr_read_seq");
        csrWriteErrSequence csr_write_err_seq = csrWriteErrSequence::type_id::create("csr_write_err_seq");
        phase.raise_objection(this);
        `uvm_info(get_type_name(), "Starting CSR (Control and Status Register) Test", UVM_NONE);
        
        csr_seq.start(bmu_env.agent.sequencer);
        csr_write_seq.start(bmu_env.agent.sequencer);
        csr_read_seq.start(bmu_env.agent.sequencer);    
        csr_write_err_seq.start(bmu_env.agent.sequencer);
        `uvm_info(get_type_name(), "CSR Test Completed", UVM_NONE);
        phase.drop_objection(this);
    endtask

endclass
