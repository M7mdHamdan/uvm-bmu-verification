class clzSequence extends uvm_sequence #(BmuSequenceItem);

    `uvm_object_utils(clzSequence)
    function new (string name = "clzSequence");
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
        
        // Now activate the DUT and set up CLZ operation
        // CLZ (Count Leading Zeros) operation - ZBB instruction
        // TODO: Add proper input values and control settings for CLZ
        item.rstL = 1;
        item.validIn = 1;
        item.scanMode = 0;
        item.csrRenIn = 0;
        item.csrRdataIn = 0;
        item.ap = 0;
        
        // Set CLZ flag
        item.ap.clz = 1;
        
        // Set test values for CLZ operation
        // CLZ will count leading zeros in aIn
        item.aIn = 32'h00100000; // Should result in count of 10 leading zeros
        item.bIn = 32'h0;        // Not used for CLZ
        
        start_item(item);
        `uvm_info(get_type_name(), "CLZ first test case", UVM_NONE);
        finish_item(item);
        
        // Try another test case with different input
        item.aIn = 32'h80000000; // Should result in count of 0 leading zeros
        
        start_item(item);
        `uvm_info(get_type_name(), "CLZ second test case", UVM_NONE);
        finish_item(item);
        
        // Test Case 3: All zeros input (edge case)
        item.aIn = 32'h00000000; // Should result in count of 32 leading zeros
        item.bIn = 32'h0;
        
        start_item(item);
        `uvm_info(get_type_name(), "CLZ Test Case 3: All zeros (should return 32)", UVM_NONE);
        finish_item(item);
        
        // Test Case 4: Single bit set at various positions
        item.aIn = 32'h00000001; // Should result in count of 31 leading zeros
        
        start_item(item);
        `uvm_info(get_type_name(), "CLZ Test Case 4: LSB set (should return 31)", UVM_NONE);
        finish_item(item);
        
        // Test Case 5: Multiple leading zeros
        item.aIn = 32'h00008000; // Should result in count of 16 leading zeros
        
        start_item(item);
        `uvm_info(get_type_name(), "CLZ Test Case 5: 16 leading zeros", UVM_NONE);
        finish_item(item);
        
        // Test Case 6: Few leading zeros
        item.aIn = 32'h40000000; // Should result in count of 1 leading zero
        
        start_item(item);
        `uvm_info(get_type_name(), "CLZ Test Case 6: 1 leading zero", UVM_NONE);
        finish_item(item);
        
        // Test Case 7: Pattern with many leading zeros
        item.aIn = 32'h00000100; // Should result in count of 23 leading zeros
        
        start_item(item);
        `uvm_info(get_type_name(), "CLZ Test Case 7: 23 leading zeros", UVM_NONE);
        finish_item(item);
        
        // Test Case 8: Power of 2 pattern
        item.aIn = 32'h00000010; // Should result in count of 27 leading zeros
        
        start_item(item);
        `uvm_info(get_type_name(), "CLZ Test Case 8: Power of 2 (bit 4 set)", UVM_NONE);
        finish_item(item);
        
        // Test Case 9: Multiple bits set (count only leading zeros)
        item.aIn = 32'h000F0000; // Should result in count of 15 leading zeros
        
        start_item(item);
        `uvm_info(get_type_name(), "CLZ Test Case 9: Multiple bits, 15 leading zeros", UVM_NONE);
        finish_item(item);
        
        // Test Case 10: Alternating pattern starting with zeros
        item.aIn = 32'h01010101; // Should result in count of 7 leading zeros
        
        start_item(item);
        `uvm_info(get_type_name(), "CLZ Test Case 10: Alternating pattern, 7 leading zeros", UVM_NONE);
        finish_item(item);
    endtask

endclass
