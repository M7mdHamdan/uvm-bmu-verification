class ComprehensiveCoverageTest extends uvm_test;
    `uvm_component_utils(ComprehensiveCoverageTest)
    
    BmuEnvironment bmu_env;
    
    function new(string name = "ComprehensiveCoverageTest", uvm_component parent = null);
        super.new(name, parent);
    endfunction
    
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        bmu_env = BmuEnvironment::type_id::create("bmu_env", this);
    endfunction
    
    task run_phase(uvm_phase phase);
        // Run comprehensive sequences to maximize coverage
        xorSequence xor_seq;
        clzSequence clz_seq;
        sh3addSequence sh3add_seq;
        bextSequence bext_seq;
        minSequence min_seq;
        subSequence sub_seq;
        sltSequence slt_seq;
        cpopSequence cpop_seq;
        rolSequence rol_seq;
        packuSequence packu_seq;
        gorcSequence gorc_seq;
        sllSequence sll_seq;
        sraSequence sra_seq;
        siextHSequence siext_h_seq;
        csrReadSequence csr_read_seq;
        csrWriteSequence csr_write_seq;
        
        phase.raise_objection(this);
        
        `uvm_info("COMPREHENSIVE_TEST", "Starting Comprehensive Coverage Test to reach 80%", UVM_LOW)
        
        // Execute multiple sequences to hit different coverage points
        
        // 1. Logical Operations Coverage
        `uvm_info("COMPREHENSIVE_TEST", "Running Logical Operations (XOR)", UVM_MEDIUM)
        xor_seq = xorSequence::type_id::create("xor_seq");
        xor_seq.start(bmu_env.agent.sequencer);
        #10;
        
        // 2. Bit Manipulation Coverage (Zbb Extension)
        `uvm_info("COMPREHENSIVE_TEST", "Running Zbb Operations (CLZ, MIN, SUB, SLT, CPOP)", UVM_MEDIUM)
        clz_seq = clzSequence::type_id::create("clz_seq");
        clz_seq.start(bmu_env.agent.sequencer);
        #10;
        
        min_seq = minSequence::type_id::create("min_seq");
        min_seq.start(bmu_env.agent.sequencer);
        #10;
        
        sub_seq = subSequence::type_id::create("sub_seq");
        sub_seq.start(bmu_env.agent.sequencer);
        #10;
        
        slt_seq = sltSequence::type_id::create("slt_seq");
        slt_seq.start(bmu_env.agent.sequencer);
        #10;
        
        cpop_seq = cpopSequence::type_id::create("cpop_seq");
        cpop_seq.start(bmu_env.agent.sequencer);
        #10;
        
        // 3. Address Generation Coverage (Zba Extension)
        `uvm_info("COMPREHENSIVE_TEST", "Running Zba Operations (SH3ADD)", UVM_MEDIUM)
        sh3add_seq = sh3addSequence::type_id::create("sh3add_seq");
        sh3add_seq.start(bmu_env.agent.sequencer);
        #10;
        
        // 4. Single-bit Operations Coverage (Zbs Extension)
        `uvm_info("COMPREHENSIVE_TEST", "Running Zbs Operations (BEXT, SIEXT_H)", UVM_MEDIUM)
        bext_seq = bextSequence::type_id::create("bext_seq");
        bext_seq.start(bmu_env.agent.sequencer);
        #10;
        
        siext_h_seq = siextHSequence::type_id::create("siext_h_seq");
        siext_h_seq.start(bmu_env.agent.sequencer);
        #10;
        
        // 5. Permutation Operations Coverage (Zbp Extension)
        `uvm_info("COMPREHENSIVE_TEST", "Running Zbp Operations (ROL, PACKU, GORC, SLL, SRA)", UVM_MEDIUM)
        rol_seq = rolSequence::type_id::create("rol_seq");
        rol_seq.start(bmu_env.agent.sequencer);
        #10;
        
        packu_seq = packuSequence::type_id::create("packu_seq");
        packu_seq.start(bmu_env.agent.sequencer);
        #10;
        
        gorc_seq = gorcSequence::type_id::create("gorc_seq");
        gorc_seq.start(bmu_env.agent.sequencer);
        #10;
        
        sll_seq = sllSequence::type_id::create("sll_seq");
        sll_seq.start(bmu_env.agent.sequencer);
        #10;
        
        sra_seq = sraSequence::type_id::create("sra_seq");
        sra_seq.start(bmu_env.agent.sequencer);
        #10;
        
        // 6. CSR Operations Coverage
        `uvm_info("COMPREHENSIVE_TEST", "Running CSR Operations (READ, WRITE)", UVM_MEDIUM)
        csr_read_seq = csrReadSequence::type_id::create("csr_read_seq");
        csr_read_seq.start(bmu_env.agent.sequencer);
        #10;
        
        csr_write_seq = csrWriteSequence::type_id::create("csr_write_seq");
        csr_write_seq.start(bmu_env.agent.sequencer);
        #10;
        
        `uvm_info("COMPREHENSIVE_TEST", "Comprehensive Coverage Test Completed", UVM_LOW)
        
        phase.drop_objection(this);
    endtask
    
endclass: ComprehensiveCoverageTest
