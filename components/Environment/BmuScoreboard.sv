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

        // Send to checker
        checkerActualPort.write(scoreboardItem);

        // Store in queue for tracking
        transactionQueue.push_back(scoreboardItem);
        
        // processTransaction(scoreboardItem);
    endfunction

    // Process individual transactions
    function void processTransaction(BmuSequenceItem transactionItem);
        string border_line;
        string data_border_line;
        processedTransactions++;
        
        border_line = "\n+=============================================+\n";
        data_border_line = "+---------------------------------------------+\n";
        
        `uvm_info("BMU_SCOREBOARD", $sformatf("%s|            TRANSACTION #%-16d    |\n%s| INPUT/OUTPUT VALUES (HEX)                   |\n| A Input          : 0x%8h (decimal: %0d) |\n| B Input          : 0x%8h (decimal: %0d) |\n| Actual Result    : 0x%8h (decimal: %0d) |\n%s| INPUT/OUTPUT VALUES (BINARY)                |\n| A Input (31:0)   : %32b |\n| B Input (31:0)   : %32b |\n| Actual (31:0)    : %32b |\n%s| CONTROL FLAGS                              |\n+---------------------------------------------+\n| Basic Operations:                          |\n| add=%0d    sub=%0d    slt=%0d    unsign=%0d     |\n+---------------------------------------------+\n| Logical Operations:                        |\n| land=%0d   lor=%0d    lxor=%0d               |\n+---------------------------------------------+\n| Shifts:                                    |\n| sll=%0d    srl=%0d    sra=%0d                |\n+---------------------------------------------+\n| Bit Manipulation (Zbb):                    |\n| zbb=%0d    clz=%0d    ctz=%0d    cpop=%0d     |\n| rol=%0d    ror=%0d    grev=%0d   gorc=%0d     |\n+---------------------------------------------+\n| Bit Field (Zbs):                           |\n| bset=%0d   bclr=%0d   binv=%0d   bext=%0d     |\n+---------------------------------------------+\n| Address Generation (Zba):                  |\n| zba=%0d    sh1add=%0d sh2add=%0d sh3add=%0d   |\n+---------------------------------------------+\n| Packed SIMD (Zbp):                         |\n| pack=%0d   packu=%0d  packh=%0d              |\n| siext_b=%0d siext_h=%0d min=%0d    max=%0d     |\n+---------------------------------------------+\n| Conditional:                               |\n| beq=%0d    bne=%0d    blt=%0d    bge=%0d      |\n+---------------------------------------------+\n| CSR & Jump Operations:                     |\n| csr_write=%0d csr_imm=%0d jal=%0d             |\n| predict_t=%0d predict_nt=%0d                  |\n%s", 
                border_line,
                processedTransactions,
                data_border_line,
                transactionItem.aIn, transactionItem.aIn,
                transactionItem.bIn, transactionItem.bIn,
                transactionItem.resultFf, transactionItem.resultFf,
                data_border_line,
                transactionItem.aIn,
                transactionItem.bIn,
                transactionItem.resultFf,
                data_border_line,
                // Basic Operations
                transactionItem.ap.add, transactionItem.ap.sub, transactionItem.ap.slt, transactionItem.ap.unsign,
                // Logical Operations
                transactionItem.ap.land, transactionItem.ap.lor, transactionItem.ap.lxor,
                // Shifts
                transactionItem.ap.sll, transactionItem.ap.srl, transactionItem.ap.sra,
                // Bit Manipulation (Zbb)
                transactionItem.ap.zbb, transactionItem.ap.clz, transactionItem.ap.ctz, transactionItem.ap.cpop,
                transactionItem.ap.rol, transactionItem.ap.ror, transactionItem.ap.grev, transactionItem.ap.gorc,
                // Bit Field (Zbs)
                transactionItem.ap.bset, transactionItem.ap.bclr, transactionItem.ap.binv, transactionItem.ap.bext,
                // Address Generation (Zba)
                transactionItem.ap.zba, transactionItem.ap.sh1add, transactionItem.ap.sh2add, transactionItem.ap.sh3add,
                // Packed SIMD (Zbp)
                transactionItem.ap.pack, transactionItem.ap.packu, transactionItem.ap.packh,
                transactionItem.ap.siext_b, transactionItem.ap.siext_h, transactionItem.ap.min, transactionItem.ap.max,
                // Conditional Operations
                transactionItem.ap.beq, transactionItem.ap.bne, transactionItem.ap.blt, transactionItem.ap.bge,
                // CSR & Jump Operations
                transactionItem.ap.csr_write, transactionItem.ap.csr_imm, transactionItem.ap.jal,
                transactionItem.ap.predict_t, transactionItem.ap.predict_nt,
                border_line), UVM_MEDIUM)
        
        // Additional transaction processing logic can be added here
        // For now, the main comparison is handled by the dedicated checker
    endfunction

    // Utility function to get transaction statistics
    function void getTransactionStats(output int total, output int processed, output int pending);
        total = totalTransactions;
        processed = processedTransactions;
        pending = transactionQueue.size();
    endfunction

    // // Clear processed transactions periodically to prevent memory buildup
    // function void clearProcessedTransactions();
    //     if (transactionQueue.size() > 100) begin
    //         // Keep only the last 50 transactions for debugging
    //         while (transactionQueue.size() > 50) begin
    //             transactionQueue.pop_front();
    //         end
    //         `uvm_info("BMU_SCOREBOARD", "Cleared old transactions from queue", UVM_DEBUG)
    //     end
    // endfunction

    // Report phase - provide summary statistics
    function void report_phase(uvm_phase phase);
        string border_line;
        super.report_phase(phase);
        
        border_line = "\n+=============================================+\n";
        
        `uvm_info("BMU_SCOREBOARD", $sformatf("%s|           SCOREBOARD FINAL REPORT          |\n|                                             |\n| Total Transactions Received  : %-10d    |\n| Total Transactions Processed : %-10d    |\n| Pending Transactions         : %-10d    |%s", 
            border_line,
            totalTransactions,
            processedTransactions,
            transactionQueue.size(),
            border_line), UVM_LOW)
        
        if (totalTransactions != processedTransactions) begin
            `uvm_warning("BMU_SCOREBOARD", 
                        $sformatf("Transaction count mismatch: Received=%0d, Processed=%0d", 
                                 totalTransactions, processedTransactions))
        end
    endfunction

    task run_phase(uvm_phase phase);
        super.run_phase(phase);
    endtask

endclass: BmuScoreboard

