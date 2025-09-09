class andSequence extends uvm_sequence #(BmuSequenceItem);

    `uvm_object_utils(andSequence)
    function new (string name = "andSequence");
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

        // AND operation setup
        item.validIn = 1;  
        item.scanMode = 0;
        item.ap = 0;
        item.csrRenIn = 0;
        item.csrRdataIn = 0;
        item.rstL = 1;
        item.ap.land = 1;
        item.ap.zbb = 0;

        // AND test patterns
        item.aIn = 32'b10101010; item.bIn = 32'b11001100;
        start_item(item);
        `uvm_info(get_type_name(), "AND test: basic pattern", UVM_NONE);
        finish_item(item);

        item.aIn = 32'b10101010; item.bIn = 32'b00000110;
        start_item(item);
        `uvm_info(get_type_name(), "AND test: partial mask", UVM_NONE);
        finish_item(item);

        // AND with ZBB flag
        item.ap.zbb = 1;
        start_item(item);
        `uvm_info(get_type_name(), "AND test: with ZBB flag", UVM_NONE);
        finish_item(item);
    endtask

endclass