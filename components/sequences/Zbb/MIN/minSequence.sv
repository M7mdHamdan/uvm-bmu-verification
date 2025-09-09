class minSequence extends uvm_sequence #(BmuSequenceItem);

    `uvm_object_utils(minSequence)
    function new (string name = "minSequence");
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
        
        // MIN operation setup
        item.rstL = 1;
        item.validIn = 1;
        item.scanMode = 0;
        item.csrRenIn = 0;
        item.csrRdataIn = 0;
        item.ap = 0;
        item.ap.min = 1;
        
        // Various MIN test patterns
        item.aIn = 32'd10; item.bIn = 32'd20;
        start_item(item);
        `uvm_info(get_type_name(), "MIN test: positive values", UVM_NONE);
        finish_item(item);
        
        item.aIn = -32'd5; item.bIn = 32'd15;
        start_item(item);
        `uvm_info(get_type_name(), "MIN test: negative vs positive", UVM_NONE);
        finish_item(item);
        
        item.aIn = 32'hFFFFFFF0; item.bIn = 32'hFFFFFFFA;
        start_item(item);
        `uvm_info(get_type_name(), "MIN test: both negative", UVM_NONE);
        finish_item(item);
        
        item.aIn = 32'd42; item.bIn = 32'd42;
        start_item(item);
        `uvm_info(get_type_name(), "MIN test: equal values", UVM_NONE);
        finish_item(item);
        
        item.aIn = 32'd0; item.bIn = 32'd100;
        start_item(item);
        `uvm_info(get_type_name(), "MIN test: zero vs positive", UVM_NONE);
        finish_item(item);
        
        item.aIn = 32'd0; item.bIn = 32'hFFFFFFFF;
        start_item(item);
        `uvm_info(get_type_name(), "MIN test: zero vs negative", UVM_NONE);
        finish_item(item);
        
        item.aIn = 32'h7FFFFFFF; item.bIn = 32'h80000000;
        start_item(item);
        `uvm_info(get_type_name(), "MIN test: max vs min signed", UVM_NONE);
        finish_item(item);
        
        item.aIn = 32'd1000000; item.bIn = 32'd999999;
        start_item(item);
        `uvm_info(get_type_name(), "MIN test: large numbers", UVM_NONE);
        finish_item(item);
        
        item.aIn = 32'hFFFFFFFE; item.bIn = 32'hFFFFFFFD;
        start_item(item);
        `uvm_info(get_type_name(), "MIN test: small negatives", UVM_NONE);
        finish_item(item);
        
        item.aIn = 32'h40000000; item.bIn = 32'h20000000;
        start_item(item);
        `uvm_info(get_type_name(), "MIN test: powers of 2", UVM_NONE);
        finish_item(item);
    endtask

endclass
