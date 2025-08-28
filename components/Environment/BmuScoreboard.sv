class BmuScoreboard extends uvm_scoreboard;
    `uvm_component_utils(BmuScoreboard)

    // Analysis imports to receive transactions from monitor
    uvm_analysis_imp #(BmuSequenceItem, BmuScoreboard) monitorAnalysisImp;
    
    // Analysis ports to send transactions to reference model and checker
    uvm_analysis_port #(BmuSequenceItem) refModelPort;
    uvm_analysis_port #(BmuSequenceItem) checkerActualPort;
    
    // Transaction queues for processing
    BmuSequenceItem transactionQueue[$];
    
    // Statistics and tracking
    int totalTransactions;
    int processedTransactions;
    
    // Constructor
    function new(string name = "BmuScoreboard", uvm_component parent);
        super.new(name, parent);
        totalTransactions = 0;
        processedTransactions = 0;
    endfunction

    // Build phase
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        monitorAnalysisImp = new("monitorAnalysisImp", this);
        refModelPort = new("refModelPort", this);
        checkerActualPort = new("checkerActualPort", this);
    endfunction

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
    endfunction

    // Write function called by monitor
    function void write(BmuSequenceItem monitorItem);
        BmuSequenceItem scoreboardItem;
        
        `uvm_info("BMU_SCOREBOARD", $sformatf("Received transaction from monitor"), UVM_DEBUG)
        
        // Create a copy of the item for processing
        scoreboardItem = BmuSequenceItem::type_id::create("scoreboardItem");
        scoreboardItem.copy(monitorItem);
        
        // Update statistics
        totalTransactions++;
        
        // Send to reference model for expected result generation
        refModelPort.write(scoreboardItem);
        
        // Send actual result to checker
        checkerActualPort.write(scoreboardItem);
        
        // Store in queue for tracking
        transactionQueue.push_back(scoreboardItem);
        
        processTransaction(scoreboardItem);
    endfunction

    // Process individual transactions
    function void processTransaction(BmuSequenceItem transactionItem);
        processedTransactions++;
        
        `uvm_info("BMU_SCOREBOARD", 
                  $sformatf("Processing transaction %0d: aIn=%h, bIn=%h, result=%h", 
                           processedTransactions, transactionItem.aIn, transactionItem.bIn, transactionItem.resultFf), 
                  UVM_MEDIUM)
        
        // Additional transaction processing logic can be added here
        // For now, the main comparison is handled by the dedicated checker
    endfunction

    // Utility function to get transaction statistics
    function void getTransactionStats(output int total, output int processed, output int pending);
        total = totalTransactions;
        processed = processedTransactions;
        pending = transactionQueue.size();
    endfunction

    // Clear processed transactions periodically to prevent memory buildup
    function void clearProcessedTransactions();
        if (transactionQueue.size() > 100) begin
            // Keep only the last 50 transactions for debugging
            while (transactionQueue.size() > 50) begin
                transactionQueue.pop_front();
            end
            `uvm_info("BMU_SCOREBOARD", "Cleared old transactions from queue", UVM_DEBUG)
        end
    endfunction

    // Report phase - provide summary statistics
    function void report_phase(uvm_phase phase);
        super.report_phase(phase);
        
        `uvm_info("BMU_SCOREBOARD", "========================================", UVM_LOW)
        `uvm_info("BMU_SCOREBOARD", "         SCOREBOARD FINAL REPORT        ", UVM_LOW)
        `uvm_info("BMU_SCOREBOARD", "========================================", UVM_LOW)
        `uvm_info("BMU_SCOREBOARD", $sformatf("Total Transactions Received: %0d", totalTransactions), UVM_LOW)
        `uvm_info("BMU_SCOREBOARD", $sformatf("Total Transactions Processed: %0d", processedTransactions), UVM_LOW)
        `uvm_info("BMU_SCOREBOARD", $sformatf("Pending Transactions: %0d", transactionQueue.size()), UVM_LOW)
        `uvm_info("BMU_SCOREBOARD", "========================================", UVM_LOW)
        
        if (totalTransactions != processedTransactions) begin
            `uvm_warning("BMU_SCOREBOARD", 
                        $sformatf("Transaction count mismatch: Received=%0d, Processed=%0d", 
                                 totalTransactions, processedTransactions))
        end
    endfunction

    // Run phase for periodic maintenance
    task run_phase(uvm_phase phase);
        forever begin
            #1000; // Wait 1000 time units
            clearProcessedTransactions();
        end
    endtask

endclass: BmuScoreboard