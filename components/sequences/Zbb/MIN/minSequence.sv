class minSequence extends uvm_sequence #(BmuSequenceItem);

    `uvm_object_utils(minSequence)
    function new (string name = "minSequence");
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
        
        // Now activate the DUT and set up MIN operation
        // MIN (Minimum) - ZBB instruction
        // TODO: Add proper input values and control settings for MIN
        item.rstL = 1;
        item.validIn = 1;
        item.scanMode = 0;
        item.csrRenIn = 0;
        item.csrRdataIn = 0;
        item.ap = 0;
        
        // Set MIN flag
        item.ap.min = 1;
        
        // Set test values for MIN operation
        // MIN will return the smaller of aIn and bIn (signed comparison)
        item.aIn = 32'd10;  // First value for comparison
        item.bIn = 32'd20;  // Second value for comparison, 10 is smaller
        
        start_item(item);
        `uvm_info(get_type_name(), "MIN first test case: 10 vs 20", UVM_NONE);
        finish_item(item);
        
        // Try another test case with negative numbers
        item.aIn = -32'd5;  // Negative number
        item.bIn = 32'd15;  // Positive number, -5 is smaller in signed comparison
        
        start_item(item);
        `uvm_info(get_type_name(), "MIN second test case: -5 vs 15", UVM_NONE);
        finish_item(item);
        
        // Test Case 3: Both negative numbers
        item.aIn = 32'hFFFFFFF0; // -16 in 2's complement
        item.bIn = 32'hFFFFFFFA; // -6 in 2's complement
        // Expected result: -16 (more negative is smaller)
        
        start_item(item);
        `uvm_info(get_type_name(), "MIN Test Case 3: -16 vs -6 (both negative)", UVM_NONE);
        finish_item(item);
        
        // Test Case 4: Equal values
        item.aIn = 32'd42;       // Same value
        item.bIn = 32'd42;       // Same value
        // Expected result: 42 (both are equal, either is correct)
        
        start_item(item);
        `uvm_info(get_type_name(), "MIN Test Case 4: 42 vs 42 (equal values)", UVM_NONE);
        finish_item(item);
        
        // Test Case 5: Zero vs positive
        item.aIn = 32'd0;        // Zero
        item.bIn = 32'd100;      // Positive
        // Expected result: 0 (zero is smaller)
        
        start_item(item);
        `uvm_info(get_type_name(), "MIN Test Case 5: 0 vs 100", UVM_NONE);
        finish_item(item);
        
        // Test Case 6: Zero vs negative
        item.aIn = 32'd0;        // Zero
        item.bIn = 32'hFFFFFFFF; // -1 in 2's complement
        // Expected result: -1 (negative is smaller)
        
        start_item(item);
        `uvm_info(get_type_name(), "MIN Test Case 6: 0 vs -1", UVM_NONE);
        finish_item(item);
        
        // Test Case 7: Maximum vs minimum signed integers
        item.aIn = 32'h7FFFFFFF; // 2147483647 (max positive)
        item.bIn = 32'h80000000; // -2147483648 (max negative)
        // Expected result: -2147483648 (most negative)
        
        start_item(item);
        `uvm_info(get_type_name(), "MIN Test Case 7: Max positive vs max negative", UVM_NONE);
        finish_item(item);
        
        // Test Case 8: Large positive numbers
        item.aIn = 32'd1000000;  // Large positive
        item.bIn = 32'd999999;   // Slightly smaller
        // Expected result: 999999
        
        start_item(item);
        `uvm_info(get_type_name(), "MIN Test Case 8: 1000000 vs 999999", UVM_NONE);
        finish_item(item);
        
        // Test Case 9: One's complement vs two's complement
        item.aIn = 32'hFFFFFFFE; // -2 in 2's complement
        item.bIn = 32'hFFFFFFFD; // -3 in 2's complement
        // Expected result: -3 (more negative)
        
        start_item(item);
        `uvm_info(get_type_name(), "MIN Test Case 9: -2 vs -3", UVM_NONE);
        finish_item(item);
        
        // Test Case 10: Power of 2 comparisons
        item.aIn = 32'h40000000; // 2^30
        item.bIn = 32'h20000000; // 2^29
        // Expected result: 2^29 (smaller power of 2)
        
        start_item(item);
        `uvm_info(get_type_name(), "MIN Test Case 10: 2^30 vs 2^29", UVM_NONE);
        finish_item(item);
        
    endtask

endclass
