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
    endtask

endclass
