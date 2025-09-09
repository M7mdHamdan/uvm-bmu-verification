class clzSequence extends uvm_sequence #(BmuSequenceItem);

    `uvm_object_utils(clzSequence)
    function new (string name = "clzSequence");
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
        
        // CLZ operation setup
        item.rstL = 1;
        item.validIn = 1;
        item.scanMode = 0;
        item.csrRenIn = 0;
        item.csrRdataIn = 0;
        item.ap = 0;
        item.ap.clz = 1;
        
        // Various CLZ test patterns
        item.aIn = 32'h00100000; item.bIn = 32'h0;
        start_item(item);
        `uvm_info(get_type_name(), "CLZ test: 10 leading zeros", UVM_NONE);
        finish_item(item);
        
        item.aIn = 32'h80000000;
        start_item(item);
        `uvm_info(get_type_name(), "CLZ test: MSB set", UVM_NONE);
        finish_item(item);
        
        item.aIn = 32'h00000000;
        start_item(item);
        `uvm_info(get_type_name(), "CLZ test: all zeros", UVM_NONE);
        finish_item(item);
        
        item.aIn = 32'h00000001;
        start_item(item);
        `uvm_info(get_type_name(), "CLZ test: LSB set", UVM_NONE);
        finish_item(item);
        
        item.aIn = 32'h00008000;
        start_item(item);
        `uvm_info(get_type_name(), "CLZ test: bit 15 set", UVM_NONE);
        finish_item(item);
        
        item.aIn = 32'h40000000;
        start_item(item);
        `uvm_info(get_type_name(), "CLZ test: bit 30 set", UVM_NONE);
        finish_item(item);
        
        item.aIn = 32'h00000100;
        start_item(item);
        `uvm_info(get_type_name(), "CLZ test: bit 8 set", UVM_NONE);
        finish_item(item);
        
        item.aIn = 32'h00000010;
        start_item(item);
        `uvm_info(get_type_name(), "CLZ test: bit 4 set", UVM_NONE);
        finish_item(item);
        
        item.aIn = 32'h000F0000;
        start_item(item);
        `uvm_info(get_type_name(), "CLZ test: multiple bits", UVM_NONE);
        finish_item(item);
        
        item.aIn = 32'h01010101;
        start_item(item);
        `uvm_info(get_type_name(), "CLZ test: alternating pattern", UVM_NONE);
        finish_item(item);
    endtask

endclass
