class xorSequence extends uvm_sequence #(BmuSequenceItem);

    `uvm_object_utils(xorSequence)
    function new (string name = "xorSequence");
        super.new(name);
    endfunction 

    task body();
        BmuSequenceItem item = BmuSequenceItem::type_id::create("item");

        // Reset DUT
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
        
        // XOR operation setup
        item.rstL = 1;
        item.validIn = 1;
        item.scanMode = 0;
        item.csrRenIn = 0;
        item.csrRdataIn = 0;
        item.ap = 0;
        item.ap.lxor = 1;
        
        // Various XOR test patterns
        item.aIn = 32'h55555555; item.bIn = 32'h33333333;
        start_item(item);
        `uvm_info(get_type_name(), "XOR test: alternating patterns", UVM_NONE);
        finish_item(item);
        
        item.ap.zbb = 1;
        start_item(item);
        `uvm_info(get_type_name(), "XOR test: with ZBB flag", UVM_NONE);
        finish_item(item);
        
        item.ap = 0; item.ap.lxor = 1;
        item.aIn = 32'hFFFFFFFF; item.bIn = 32'h00000000;
        start_item(item);
        `uvm_info(get_type_name(), "XOR test: ones vs zeros", UVM_NONE);
        finish_item(item);
        
        item.aIn = 32'hDEADBEEF; item.bIn = 32'hDEADBEEF;
        start_item(item);
        `uvm_info(get_type_name(), "XOR test: identical values", UVM_NONE);
        finish_item(item);
        
        item.aIn = 32'hAAAAAAAA; item.bIn = 32'h55555555;
        start_item(item);
        `uvm_info(get_type_name(), "XOR test: inverted patterns", UVM_NONE);
        finish_item(item);
        
        item.aIn = 32'h12345678; item.bIn = 32'h12345679;
        start_item(item);
        `uvm_info(get_type_name(), "XOR test: single bit diff", UVM_NONE);
        finish_item(item);
        
        item.aIn = 32'h80000000; item.bIn = 32'h00000001;
        start_item(item);
        `uvm_info(get_type_name(), "XOR test: MSB vs LSB", UVM_NONE);
        finish_item(item);
        
        item.aIn = 32'hF0F0F0F0; item.bIn = 32'h0F0F0F0F;
        start_item(item);
        `uvm_info(get_type_name(), "XOR test: nibble patterns", UVM_NONE);
        finish_item(item);
        
        item.aIn = 32'h12345678; item.bIn = 32'h87654321;
        start_item(item);
        `uvm_info(get_type_name(), "XOR test: byte patterns", UVM_NONE);
        finish_item(item);
        
        item.aIn = 32'h7FFFFFFF; item.bIn = 32'h80000000;
        start_item(item);
        `uvm_info(get_type_name(), "XOR test: max positive vs min negative", UVM_NONE);
        finish_item(item);
    endtask

endclass
