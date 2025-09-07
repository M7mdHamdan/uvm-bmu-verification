class xorSequence extends uvm_sequence #(BmuSequenceItem);

    `uvm_object_utils(xorSequence)
    function new (string name = "xorSequence");
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
        
        // Now activate the DUT and set up XOR operation
        // XOR (Exclusive OR) - Basic operation
        // TODO: Add proper input values and control settings for XOR
        item.rstL = 1;
        item.validIn = 1;
        item.scanMode = 0;
        item.csrRenIn = 0;
        item.csrRdataIn = 0;
        item.ap = 0;
        
        // Set XOR flag (lxor in the ALU packet)
        item.ap.lxor = 1;
        
        // Set test values for XOR operation
        item.aIn = 32'h55555555; // Pattern of alternating 0s and 1s
        item.bIn = 32'h33333333; // Different pattern to XOR with
        
        start_item(item);
        `uvm_info(get_type_name(), "XOR first test case", UVM_NONE);
        finish_item(item);
        
        // Try another test case with ZBB=1 for inverted XOR
        item.ap.zbb = 1;
        
        start_item(item);
        `uvm_info(get_type_name(), "XOR with ZBB=1 (inverted XOR)", UVM_NONE);
        finish_item(item);
        
        // Test Case 3: XOR with all zeros
        item.ap = 0;
        item.ap.lxor = 1;
        item.aIn = 32'hFFFFFFFF; // All ones
        item.bIn = 32'h00000000; // All zeros
        // Expected result: 0xFFFFFFFF (all ones XOR all zeros = all ones)
        
        start_item(item);
        `uvm_info(get_type_name(), "XOR Test Case 3: 0xFFFFFFFF XOR 0x00000000", UVM_NONE);
        finish_item(item);
        
        // Test Case 4: XOR with identical values (should result in zero)
        item.aIn = 32'hDEADBEEF;
        item.bIn = 32'hDEADBEEF;
        // Expected result: 0x00000000 (any value XOR with itself = 0)
        
        start_item(item);
        `uvm_info(get_type_name(), "XOR Test Case 4: 0xDEADBEEF XOR 0xDEADBEEF = 0", UVM_NONE);
        finish_item(item);
        
        // Test Case 5: XOR with inverted pattern
        item.aIn = 32'hAAAAAAAA; // 10101010... pattern
        item.bIn = 32'h55555555; // 01010101... pattern (inverted)
        // Expected result: 0xFFFFFFFF (complementary patterns XOR = all ones)
        
        start_item(item);
        `uvm_info(get_type_name(), "XOR Test Case 5: 0xAAAAAAAA XOR 0x55555555", UVM_NONE);
        finish_item(item);
        
        // Test Case 6: XOR with single bit differences
        item.aIn = 32'h12345678;
        item.bIn = 32'h12345679; // Same except LSB
        // Expected result: 0x00000001 (only LSB differs)
        
        start_item(item);
        `uvm_info(get_type_name(), "XOR Test Case 6: Single bit difference test", UVM_NONE);
        finish_item(item);
        
        // Test Case 7: XOR with powers of 2
        item.aIn = 32'h80000000; // MSB set only
        item.bIn = 32'h00000001; // LSB set only
        // Expected result: 0x80000001 (both MSB and LSB set)
        
        start_item(item);
        `uvm_info(get_type_name(), "XOR Test Case 7: Powers of 2 (0x80000000 XOR 0x00000001)", UVM_NONE);
        finish_item(item);
        
        // Test Case 8: XOR with nibble patterns
        item.aIn = 32'hF0F0F0F0; // Alternating nibbles
        item.bIn = 32'h0F0F0F0F; // Inverted nibbles
        // Expected result: 0xFFFFFFFF (complementary nibbles)
        
        start_item(item);
        `uvm_info(get_type_name(), "XOR Test Case 8: Nibble patterns (0xF0F0F0F0 XOR 0x0F0F0F0F)", UVM_NONE);
        finish_item(item);
        
        // Test Case 9: XOR with byte-level patterns
        item.aIn = 32'h12345678;
        item.bIn = 32'h87654321; // Reversed byte order
        // Expected result: 0x95511559
        
        start_item(item);
        `uvm_info(get_type_name(), "XOR Test Case 9: Byte patterns (0x12345678 XOR 0x87654321)", UVM_NONE);
        finish_item(item);
        
        // Test Case 10: XOR edge case with maximum values
        item.aIn = 32'h7FFFFFFF; // Maximum positive signed 32-bit
        item.bIn = 32'h80000000; // Minimum negative signed 32-bit
        // Expected result: 0xFFFFFFFF
        
        start_item(item);
        `uvm_info(get_type_name(), "XOR Test Case 10: Max positive XOR min negative", UVM_NONE);
        finish_item(item);
    endtask

endclass
