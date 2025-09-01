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
        if (actualQueue.size() > 0 && expectedQueue.size() > 0) begin
            BmuSequenceItem actual = actualQueue.pop_front();
            BmuSequenceItem expected = expectedQueue.pop_front();

            if (actual.resultFf === expected.resultFf) begin
                cMatches++;
                `uvm_info("BMU_CHECKER", $sformatf("MATCH: Expected=%h, Actual=%h", expected.resultFf, actual.resultFf), UVM_LOW)
            end else begin
                cMismatches++;
                `uvm_error("BMU_CHECKER", $sformatf("MISMATCH: Expected=%h, Actual=%h", expected.resultFf, actual.resultFf))
            end
        end
    endfunction

    // Report
    function void report_phase(uvm_phase phase);
        super.report_phase(phase);
        `uvm_info("BMU_CHECKER", $sformatf("Final Stats: %0d matches, %0d mismatches", cMatches, cMismatches), UVM_LOW)
        if (cMismatches > 0) begin
            `uvm_error("BMU_CHECKER", $sformatf("Test FAILED with %0d mismatches", cMismatches))
        end else begin
            `uvm_info("BMU_CHECKER", "Test PASSED - All results matched!", UVM_LOW)
        end
    endfunction
  
endclass: BmuChecker
