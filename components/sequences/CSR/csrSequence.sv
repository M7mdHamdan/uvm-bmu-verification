import uvm_pkg::*;
`include "uvm_macros.svh"

class csrSequence extends uvm_sequence #(BmuSequenceItem);

    `uvm_object_utils(csrSequence)
    function new (string name = "csrSequence");
        super.new(name);
    endfunction 

    task body();
        BmuSequenceItem item = BmuSequenceItem::type_id::create("item");

        // Reset transaction
        item.rstL = 0;
        item.validIn = 1;  
        item.scanMode = 0;
        item.ap = 0;
        item.csrRenIn = 0;
        item.csrRdataIn = 0;
        item.aIn = 0;
        item.bIn = 0;
        start_item(item);
        `uvm_info(get_type_name(), "Reset the DUT", UVM_NONE);
        finish_item(item);
        
        // ========== CSR READ OPERATIONS (Case 0) ==========
        // CSR Read operations require: csrRenIn = 1, ap.csr_write = 0, no other ap bits set
        
        // Test Case 1: Basic CSR Read
        item.rstL = 1;
        item.validIn = 1;
        item.scanMode = 0;
        item.ap = 0;               // Clear all ap fields
        item.csrRenIn = 1;         // Enable CSR read
        item.csrRdataIn = 32'h12345678; // CSR data to read
        item.aIn = 32'hDEADBEEF;   // Should be ignored for CSR read
        item.bIn = 32'hCAFEBABE;   // Should be ignored for CSR read
        // Expected result: 0x12345678 (csrRdataIn value)
        
        start_item(item);
        `uvm_info(get_type_name(), "CSR Test Case 1: Read CSR = 0x12345678", UVM_NONE);
        finish_item(item);
        
        // Test Case 2: CSR Read with different value
        item.csrRdataIn = 32'hABCDEF00;
        item.aIn = 32'h11111111;   // Should be ignored
        item.bIn = 32'h22222222;   // Should be ignored
        // Expected result: 0xABCDEF00
        
        start_item(item);
        `uvm_info(get_type_name(), "CSR Test Case 2: Read CSR = 0xABCDEF00", UVM_NONE);
        finish_item(item);
        
        // Test Case 3: CSR Read with zero value
        item.csrRdataIn = 32'h00000000;
        // Expected result: 0x00000000
        
        start_item(item);
        `uvm_info(get_type_name(), "CSR Test Case 3: Read CSR = 0x00000000", UVM_NONE);
        finish_item(item);
        
        // Test Case 4: CSR Read with all ones
        item.csrRdataIn = 32'hFFFFFFFF;
        // Expected result: 0xFFFFFFFF
        
        start_item(item);
        `uvm_info(get_type_name(), "CSR Test Case 4: Read CSR = 0xFFFFFFFF", UVM_NONE);
        finish_item(item);
        
        // ========== CSR WRITE OPERATIONS (Case 2) ==========
        // CSR Write operations require: csrRenIn = 0, ap.csr_write = 1, ap.csr_imm for mode select
        
        // Test Case 5: CSR Write Immediate Mode
        item.ap = 0;               // Clear all ap fields
        item.ap.csr_write = 1;     // Enable CSR write
        item.ap.csr_imm = 1;       // Immediate mode (use bIn)
        item.csrRenIn = 0;         // Must be 0 for write operations
        item.csrRdataIn = 32'h00000000; // Not used for write
        item.aIn = 32'h11111111;   // Should be ignored in immediate mode
        item.bIn = 32'h87654321;   // This value should be written
        // Expected result: 0x87654321 (bIn value in immediate mode)
        
        start_item(item);
        `uvm_info(get_type_name(), "CSR Test Case 5: Write Immediate bIn = 0x87654321", UVM_NONE);
        finish_item(item);
        
        // Test Case 6: CSR Write Register Mode
        item.ap = 0;               // Clear all ap fields
        item.ap.csr_write = 1;     // Enable CSR write
        item.ap.csr_imm = 0;       // Register mode (use aIn)
        item.csrRenIn = 0;         // Must be 0 for write operations
        item.csrRdataIn = 32'h00000000; // Not used for write
        item.aIn = 32'h13579BDF;   // This value should be written
        item.bIn = 32'h24681ACE;   // Should be ignored in register mode
        // Expected result: 0x13579BDF (aIn value in register mode)
        
        start_item(item);
        `uvm_info(get_type_name(), "CSR Test Case 6: Write Register aIn = 0x13579BDF", UVM_NONE);
        finish_item(item);
        
        // Test Case 7: CSR Write Immediate Mode with zero
        item.ap = 0;
        item.ap.csr_write = 1;
        item.ap.csr_imm = 1;
        item.csrRenIn = 0;
        item.aIn = 32'hFFFFFFFF;   // Should be ignored
        item.bIn = 32'h00000000;   // Write zero
        // Expected result: 0x00000000
        
        start_item(item);
        `uvm_info(get_type_name(), "CSR Test Case 7: Write Immediate bIn = 0x00000000", UVM_NONE);
        finish_item(item);
        
        // Test Case 8: CSR Write Register Mode with all ones
        item.ap = 0;
        item.ap.csr_write = 1;
        item.ap.csr_imm = 0;
        item.csrRenIn = 0;
        item.aIn = 32'hFFFFFFFF;   // Write all ones
        item.bIn = 32'h00000000;   // Should be ignored
        // Expected result: 0xFFFFFFFF
        
        start_item(item);
        `uvm_info(get_type_name(), "CSR Test Case 8: Write Register aIn = 0xFFFFFFFF", UVM_NONE);
        finish_item(item);
        
    endtask

endclass
