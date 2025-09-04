// UVM analysis implementation declarations for multiple write functions
`uvm_analysis_imp_decl(_actual)
`uvm_analysis_imp_decl(_expected)

class BmuChecker extends uvm_component;
    `uvm_component_utils(BmuChecker)
    // Analysis implementations to receive transactions
    uvm_analysis_imp_actual #(BmuSequenceItem, BmuChecker) actualExport;
    uvm_analysis_imp_expected #(BmuSequenceItem, BmuChecker) expectedExport;

    // Queues
    BmuSequenceItem actualQueue[$];
    BmuSequenceItem expectedQueue[$];
    
    // Counters
    int cMatches;
    int cMismatches;

    function new(string name = "BmuChecker", uvm_component parent);
        super.new(name, parent);
        cMatches = 0;
        cMismatches = 0;
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        actualExport = new("actualExport", this);
        expectedExport = new("expectedExport", this);
    endfunction

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
    endfunction

    // Write function for actual DUT results
    function void write_actual(BmuSequenceItem item);
        `uvm_info("BMU_CHECKER", $sformatf("Received actual result: %h", item.resultFf), UVM_DEBUG)
        actualQueue.push_back(item);
        compareIfReady();
    endfunction
    
    // Write function for expected results from reference model
    function void write_expected(BmuSequenceItem item);
        `uvm_info("BMU_CHECKER", $sformatf("Received expected result: %h", item.resultFf), UVM_DEBUG)
        expectedQueue.push_back(item);
        compareIfReady();
    endfunction
    // Compare actual vs expected
    function void compareIfReady();
        string border_line;
        string data_border_line;
        
        if (actualQueue.size() > 0 && expectedQueue.size() > 0) begin
            BmuSequenceItem actual = actualQueue.pop_front();
            BmuSequenceItem expected = expectedQueue.pop_front();
            
            border_line = "\n+=============================================+\n";
            data_border_line = "+---------------------------------------------+\n";
            
            if (actual.resultFf === expected.resultFf) begin
                cMatches++;
                `uvm_info("BMU_CHECKER", $sformatf("%s|         MATCH: TRANSACTION SUCCESSFUL       |\n%s| INPUT/OUTPUT VALUES (HEX)                   |\n| A Input          : 0x%8h (decimal: %0d) |\n| B Input          : 0x%8h (decimal: %0d) |\n| Expected Result  : 0x%8h (decimal: %0d) |\n| Expected Error   : %0d                      |\n| Actual Result    : 0x%8h (decimal: %0d) |\n| Actual Error     : %0d                      |\n%s| INPUT/OUTPUT VALUES (BINARY)                |\n| A Input (31:0)   : %32b |\n| B Input (31:0)   : %32b |\n| Expected (31:0)  : %32b |\n| Actual (31:0)    : %32b |\n%s| CONTROL FLAGS                              |\n+---------------------------------------------+\n| Basic Operations:                          |\n| add=%0d    sub=%0d    slt=%0d    unsign=%0d     |\n+---------------------------------------------+\n| Logical Operations:                        |\n| land=%0d   lor=%0d    lxor=%0d               |\n+---------------------------------------------+\n| Shifts:                                    |\n| sll=%0d    srl=%0d    sra=%0d                |\n+---------------------------------------------+\n| Bit Manipulation (Zbb):                    |\n| zbb=%0d    clz=%0d    ctz=%0d    cpop=%0d     |\n| rol=%0d    ror=%0d    grev=%0d   gorc=%0d     |\n+---------------------------------------------+\n| Bit Field (Zbs):                           |\n| bset=%0d   bclr=%0d   binv=%0d   bext=%0d     |\n+---------------------------------------------+\n| Address Generation (Zba):                  |\n| zba=%0d    sh1add=%0d sh2add=%0d sh3add=%0d   |\n+---------------------------------------------+\n| Packed SIMD (Zbp):                         |\n| pack=%0d   packu=%0d  packh=%0d              |\n| siext_b=%0d siext_h=%0d min=%0d    max=%0d     |\n+---------------------------------------------+\n| Conditional:                               |\n| beq=%0d    bne=%0d    blt=%0d    bge=%0d      |\n+---------------------------------------------+\n| CSR & Jump Operations:                     |\n| csr_write=%0d csr_imm=%0d jal=%0d             |\n| predict_t=%0d predict_nt=%0d                  |\n%s", 
                    border_line,
                    data_border_line,
                    actual.aIn, actual.aIn,
                    actual.bIn, actual.bIn,
                    expected.resultFf, expected.resultFf,
                    expected.error,
                    actual.resultFf, actual.resultFf,
                    actual.error,
                    data_border_line,
                    actual.aIn,
                    actual.bIn,
                    expected.resultFf,
                    actual.resultFf,
                    data_border_line,
                    // Basic Operations
                    actual.ap.add, actual.ap.sub, actual.ap.slt, actual.ap.unsign,
                    // Logical Operations
                    actual.ap.land, actual.ap.lor, actual.ap.lxor,
                    // Shifts
                    actual.ap.sll, actual.ap.srl, actual.ap.sra,
                    // Bit Manipulation (Zbb)
                    actual.ap.zbb, actual.ap.clz, actual.ap.ctz, actual.ap.cpop,
                    actual.ap.rol, actual.ap.ror, actual.ap.grev, actual.ap.gorc,
                    // Bit Field (Zbs)
                    actual.ap.bset, actual.ap.bclr, actual.ap.binv, actual.ap.bext,
                    // Address Generation (Zba)
                    actual.ap.zba, actual.ap.sh1add, actual.ap.sh2add, actual.ap.sh3add,
                    // Packed SIMD (Zbp)
                    actual.ap.pack, actual.ap.packu, actual.ap.packh,
                    actual.ap.siext_b, actual.ap.siext_h, actual.ap.min, actual.ap.max,
                    // Conditional Operations
                    actual.ap.beq, actual.ap.bne, actual.ap.blt, actual.ap.bge,
                    // CSR & Jump Operations
                    actual.ap.csr_write, actual.ap.csr_imm, actual.ap.jal,
                    actual.ap.predict_t, actual.ap.predict_nt,
                    border_line), UVM_LOW)
            end else begin
                cMismatches++;
                `uvm_error("BMU_CHECKER", $sformatf("%s|    !!! MISMATCH: TRANSACTION FAILED !!!    |\n%s| INPUT/OUTPUT VALUES (HEX)                   |\n| A Input          : 0x%8h (decimal: %0d) |\n| B Input          : 0x%8h (decimal: %0d) |\n| Expected Result  : 0x%8h (decimal: %0d) |\n| Expected Error   : %0d                      |\n| Actual Result    : 0x%8h (decimal: %0d) |\n| Actual Error     : %0d                      |\n%s| INPUT/OUTPUT VALUES (BINARY)                |\n| A Input (31:0)   : %32b |\n| B Input (31:0)   : %32b |\n| Expected (31:0)  : %32b |\n| Actual (31:0)    : %32b |\n%s| CONTROL FLAGS                              |\n+---------------------------------------------+\n| Basic Operations:                          |\n| add=%0d    sub=%0d    slt=%0d    unsign=%0d     |\n+---------------------------------------------+\n| Logical Operations:                        |\n| land=%0d   lor=%0d    lxor=%0d               |\n+---------------------------------------------+\n| Shifts:                                    |\n| sll=%0d    srl=%0d    sra=%0d                |\n+---------------------------------------------+\n| Bit Manipulation (Zbb):                    |\n| zbb=%0d    clz=%0d    ctz=%0d    cpop=%0d     |\n| rol=%0d    ror=%0d    grev=%0d   gorc=%0d     |\n+---------------------------------------------+\n| Bit Field (Zbs):                           |\n| bset=%0d   bclr=%0d   binv=%0d   bext=%0d     |\n+---------------------------------------------+\n| Address Generation (Zba):                  |\n| zba=%0d    sh1add=%0d sh2add=%0d sh3add=%0d   |\n+---------------------------------------------+\n| Packed SIMD (Zbp):                         |\n| pack=%0d   packu=%0d  packh=%0d              |\n| siext_b=%0d siext_h=%0d min=%0d    max=%0d     |\n+---------------------------------------------+\n| Conditional:                               |\n| beq=%0d    bne=%0d    blt=%0d    bge=%0d      |\n+---------------------------------------------+\n| CSR & Jump Operations:                     |\n| csr_write=%0d csr_imm=%0d jal=%0d             |\n| predict_t=%0d predict_nt=%0d                  |\n%s", 
                    border_line,
                    data_border_line,
                    actual.aIn, actual.aIn,
                    actual.bIn, actual.bIn,
                    expected.resultFf, expected.resultFf,
                    expected.error,
                    actual.resultFf, actual.resultFf,
                    actual.error,
                    data_border_line,
                    actual.aIn,
                    actual.bIn,
                    expected.resultFf,
                    actual.resultFf,
                    data_border_line,
                    // Basic Operations
                    actual.ap.add, actual.ap.sub, actual.ap.slt, actual.ap.unsign,
                    // Logical Operations
                    actual.ap.land, actual.ap.lor, actual.ap.lxor,
                    // Shifts
                    actual.ap.sll, actual.ap.srl, actual.ap.sra,
                    // Bit Manipulation (Zbb)
                    actual.ap.zbb, actual.ap.clz, actual.ap.ctz, actual.ap.cpop,
                    actual.ap.rol, actual.ap.ror, actual.ap.grev, actual.ap.gorc,
                    // Bit Field (Zbs)
                    actual.ap.bset, actual.ap.bclr, actual.ap.binv, actual.ap.bext,
                    // Address Generation (Zba)
                    actual.ap.zba, actual.ap.sh1add, actual.ap.sh2add, actual.ap.sh3add,
                    // Packed SIMD (Zbp)
                    actual.ap.pack, actual.ap.packu, actual.ap.packh,
                    actual.ap.siext_b, actual.ap.siext_h, actual.ap.min, actual.ap.max,
                    // Conditional Operations
                    actual.ap.beq, actual.ap.bne, actual.ap.blt, actual.ap.bge,
                    // CSR & Jump Operations
                    actual.ap.csr_write, actual.ap.csr_imm, actual.ap.jal,
                    actual.ap.predict_t, actual.ap.predict_nt,
                    border_line))
            end
        end
    endfunction

    // Report
    function void report_phase(uvm_phase phase);
        string border_line;
        super.report_phase(phase);
        
        border_line = "\n+=============================================+\n";
        
        if (cMismatches > 0) begin
            `uvm_info("BMU_CHECKER", $sformatf("%s|               TEST SUMMARY                 |\n|                                             |\n| Total Matches    : %-25d |\n| Total Mismatches : %-25d |\n| Final Result     : %-25s |%s", 
                border_line, 
                cMatches, 
                cMismatches, 
                "FAILED", 
                border_line), UVM_LOW)
            `uvm_error("BMU_CHECKER", $sformatf("Test FAILED with %0d mismatches", cMismatches))
        end else begin
            `uvm_info("BMU_CHECKER", $sformatf("%s|               TEST SUMMARY                 |\n|                                             |\n| Total Matches    : %-25d |\n| Total Mismatches : %-25d |\n| Final Result     : %-25s |%s", 
                border_line, 
                cMatches, 
                cMismatches, 
                "PASSED", 
                border_line), UVM_LOW)
            `uvm_info("BMU_CHECKER", "Test PASSED - All results matched!", UVM_LOW)
        end
    endfunction
  
endclass: BmuChecker
