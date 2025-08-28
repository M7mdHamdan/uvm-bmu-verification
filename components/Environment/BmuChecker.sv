class bmuChecker extends uvm_component;
    // Analysis exports to receive transactions
    uvm_analysis_export #(BmuSequenceItem) actualExport;
    uvm_analysis_export #(BmuSequenceItem) expectedExport;

    // Queues
    BmuSequenceItem actualQueue[$];
    BmuSequenceItem expectedQueue[$];
    
    // Counters
    int matches;
    int mismatches;

    function new(string name = "BmuChecker", uvm_component parent);
        super.new(name, parent);
        matches = 0;
        mismatches = 0;
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        actualExport = new("actualExport", this);
        expectedExport = new("expectedExport", this);
    endfunction

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
    endfunction

    // Write function for actual DUT results (called by monitor)
    function void writeActual(BmuSequenceItem actualItem);
        `uvm_info("BMU_CHECKER", $sformatf("Received actual result: %h", actualItem.resultFf), UVM_DEBUG)
        actualQueue.push_back(actualItem);
        compareIfReady();
    endfunction

    // Write function for expected results (called by reference model)
    function void writeExpected(BmuSequenceItem expectedItem);
        `uvm_info("BMU_CHECKER", $sformatf("Received expected result: %h", expectedItem.resultFf), UVM_DEBUG)
        expectedQueue.push_back(expectedItem);
        compareIfReady();
    endfunction

    // Compare actual vs expected
    function void compareIfReady();
        if (actualQueue.size() > 0 && expectedQueue.size() > 0) begin
            BmuSequenceItem actual = actualQueue.pop_front();
            BmuSequenceItem expected = expectedQueue.pop_front();

            if (actual.resultFf === expected.resultFf) begin
                matches++;
                `uvm_info("BMU_CHECKER", $sformatf("MATCH: Expected=%h, Actual=%h", expected.resultFf, actual.resultFf), UVM_LOW)
            end else begin
                mismatches++;
                `uvm_error("BMU_CHECKER", $sformatf("MISMATCH: Expected=%h, Actual=%h", expected.resultFf, actual.resultFf))
            end
        end
    endfunction

    // Report statistics at end of test
    function void report_phase(uvm_phase phase);
        super.report_phase(phase);
        `uvm_info("BMU_CHECKER", $sformatf("Final Stats: %0d matches, %0d mismatches", matches, mismatches), UVM_LOW)
        if (mismatches > 0) begin
            `uvm_error("BMU_CHECKER", $sformatf("Test FAILED with %0d mismatches", mismatches))
        end else begin
            `uvm_info("BMU_CHECKER", "Test PASSED - All results matched!", UVM_LOW)
        end
    endfunction
  
endclass: bmuChecker
