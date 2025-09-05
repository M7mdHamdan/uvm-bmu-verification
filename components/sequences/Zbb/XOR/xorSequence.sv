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
    endtask

endclass
