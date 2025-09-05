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
    endtask

endclass
