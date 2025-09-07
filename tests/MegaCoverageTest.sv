class MegaCoverageTest extends uvm_test;
    `uvm_component_utils(MegaCoverageTest)
    
    BmuEnvironment env;
    
    function new(string name = "MegaCoverageTest", uvm_component parent = null);
        super.new(name, parent);
    endfunction: new
    
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        env = BmuEnvironment::type_id::create("env", this);
    endfunction: build_phase
    
    virtual task run_phase(uvm_phase phase);
        super.run_phase(phase);
        
        phase.raise_objection(this);
        `uvm_info("MEGA_COVERAGE_TEST", "Starting MEGA Coverage Test - Running ALL sequences", UVM_LOW)
        
        // Run ALL Zbb sequences (Bit Manipulation) - Multiple runs for better coverage
        `uvm_info("MEGA_COVERAGE_TEST", "=== Running Zbb Extension Sequences ===", UVM_LOW)
        repeat(20) run_sequence("xorSequence");
        repeat(20) run_sequence("andSequence"); 
        repeat(15) run_sequence("andErrSequence");
        repeat(20) run_sequence("clzSequence");
        repeat(20) run_sequence("minSequence");
        repeat(20) run_sequence("subSequence");
        repeat(20) run_sequence("sltSequence");
        repeat(20) run_sequence("cpopSequence");
        repeat(20) run_sequence("addSequence");
        
        // Run ALL Zbs sequences (Single-bit Operations) - Multiple runs
        `uvm_info("MEGA_COVERAGE_TEST", "=== Running Zbs Extension Sequences ===", UVM_LOW)
        repeat(25) run_sequence("bextSequence");
        repeat(25) run_sequence("siextHSequence");
        
        // Run ALL Zba sequences (Address Generation) - Multiple runs
        `uvm_info("MEGA_COVERAGE_TEST", "=== Running Zba Extension Sequences ===", UVM_LOW)
        repeat(30) run_sequence("sh3addSequence");
        
        // Run ALL Zbp sequences (Permutation) - Multiple runs
        `uvm_info("MEGA_COVERAGE_TEST", "=== Running Zbp Extension Sequences ===", UVM_LOW)
        repeat(20) run_sequence("packuSequence");
        repeat(20) run_sequence("rolSequence");
        repeat(20) run_sequence("gorcSequence");
        repeat(20) run_sequence("sllSequence");
        repeat(20) run_sequence("sraSequence");
        
        // Run ALL CSR sequences (Control/Status Registers) - Multiple runs  
        `uvm_info("MEGA_COVERAGE_TEST", "=== Running CSR Extension Sequences ===", UVM_LOW)
        repeat(25) run_sequence("csrSequence");
        repeat(20) run_sequence("csrWriteSequence");
        repeat(15) run_sequence("csrWriteErrSequence");
        repeat(20) run_sequence("csrReadSequence");
        
        // Additional sequences for edge cases and maximum coverage
        `uvm_info("MEGA_COVERAGE_TEST", "=== Running Additional Coverage Sequences ===", UVM_LOW)
        repeat(30) run_sequence("xorSequence");  // Extra XOR for logical coverage
        repeat(30) run_sequence("clzSequence");  // Extra CLZ for bit manipulation
        repeat(30) run_sequence("bextSequence"); // Extra BEXT for single-bit ops
        repeat(30) run_sequence("sh3addSequence"); // Extra SH3ADD for address gen
        repeat(30) run_sequence("packuSequence"); // Extra PACKU for permutation
        repeat(30) run_sequence("csrSequence");   // Extra CSR for control ops
        
        `uvm_info("MEGA_COVERAGE_TEST", "MEGA Coverage Test completed - Total sequences run!", UVM_LOW)
        phase.drop_objection(this);
    endtask: run_phase
    
    // Helper task to run sequences with error handling
    task run_sequence(string seq_name);
        case(seq_name)
            // Zbb Extension Sequences
            "xorSequence": begin
                xorSequence seq = xorSequence::type_id::create("xor_seq");
                seq.start(env.agent.sequencer);
            end
            "andSequence": begin
                andSequence seq = andSequence::type_id::create("and_seq");
                seq.start(env.agent.sequencer);
            end
            "andErrSequence": begin
                andErrSequence seq = andErrSequence::type_id::create("and_err_seq");
                seq.start(env.agent.sequencer);
            end
            "clzSequence": begin
                clzSequence seq = clzSequence::type_id::create("clz_seq");
                seq.start(env.agent.sequencer);
            end
            "minSequence": begin
                minSequence seq = minSequence::type_id::create("min_seq");
                seq.start(env.agent.sequencer);
            end
            "subSequence": begin
                subSequence seq = subSequence::type_id::create("sub_seq");
                seq.start(env.agent.sequencer);
            end
            "sltSequence": begin
                sltSequence seq = sltSequence::type_id::create("slt_seq");
                seq.start(env.agent.sequencer);
            end
            "cpopSequence": begin
                cpopSequence seq = cpopSequence::type_id::create("cpop_seq");
                seq.start(env.agent.sequencer);
            end
            "addSequence": begin
                addSequence seq = addSequence::type_id::create("add_seq");
                seq.start(env.agent.sequencer);
            end
            
            // Zbs Extension Sequences
            "bextSequence": begin
                bextSequence seq = bextSequence::type_id::create("bext_seq");
                seq.start(env.agent.sequencer);
            end
            "siextHSequence": begin
                siextHSequence seq = siextHSequence::type_id::create("siext_h_seq");
                seq.start(env.agent.sequencer);
            end
            
            // Zba Extension Sequences
            "sh3addSequence": begin
                sh3addSequence seq = sh3addSequence::type_id::create("sh3add_seq");
                seq.start(env.agent.sequencer);
            end
            
            // Zbp Extension Sequences
            "packuSequence": begin
                packuSequence seq = packuSequence::type_id::create("packu_seq");
                seq.start(env.agent.sequencer);
            end
            "rolSequence": begin
                rolSequence seq = rolSequence::type_id::create("rol_seq");
                seq.start(env.agent.sequencer);
            end
            "gorcSequence": begin
                gorcSequence seq = gorcSequence::type_id::create("gorc_seq");
                seq.start(env.agent.sequencer);
            end
            "sllSequence": begin
                sllSequence seq = sllSequence::type_id::create("sll_seq");
                seq.start(env.agent.sequencer);
            end
            "sraSequence": begin
                sraSequence seq = sraSequence::type_id::create("sra_seq");
                seq.start(env.agent.sequencer);
            end
            
            // CSR Extension Sequences
            "csrSequence": begin
                csrSequence seq = csrSequence::type_id::create("csr_seq");
                seq.start(env.agent.sequencer);
            end
            "csrWriteSequence": begin
                csrWriteSequence seq = csrWriteSequence::type_id::create("csr_write_seq");
                seq.start(env.agent.sequencer);
            end
            "csrWriteErrSequence": begin
                csrWriteErrSequence seq = csrWriteErrSequence::type_id::create("csr_write_err_seq");
                seq.start(env.agent.sequencer);
            end
            "csrReadSequence": begin
                csrReadSequence seq = csrReadSequence::type_id::create("csr_read_seq");
                seq.start(env.agent.sequencer);
            end
            
            default: begin
                `uvm_error("MEGA_COVERAGE_TEST", $sformatf("Unknown sequence: %s", seq_name))
            end
        endcase
    endtask: run_sequence

endclass: MegaCoverageTest
