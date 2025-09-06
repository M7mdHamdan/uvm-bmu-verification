class andSequence extends uvm_sequence #(BmuSequenceItem);

    `uvm_object_utils(andSequence)
    function new (string name = "andSequence");
        super.new(name);
    endfunction 

    task body();
        BmuSequenceItem item = BmuSequenceItem::type_id::create("item");

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
        $display("Hello world");
        finish_item(item);
        $display("after first fnish");
        // 
            item.validIn = 1;  
        item.scanMode = 0;
        item.ap = 0;
        item.csrRenIn = 0;
        item.csrRdataIn = 0;
        item.aIn = 0;
        item.bIn = 0;

        item.rstL = 1;
        item.csrRenIn = 0;
        item.ap = 0;
        item.ap.land = 1;
        item.aIn = 32'b10101010;
        item.bIn = 32'b11001100;
        item.ap.zbb = 0;
        `uvm_info(get_type_name(), "INIT values DUT", UVM_NONE);
        //
        $display("wsp");
        start_item(item);
        finish_item(item);
        #20;
        item.validIn = 1;
        item.rstL = 1;
        item.csrRenIn = 0;
        item.ap = 0;
        item.ap.land = 1;
        item.aIn = 32'b10101010;
        item.bIn = 32'b00000110;
        item.ap.zbb = 0;
        `uvm_info(get_type_name(), "INIT values DUT", UVM_NONE);
        //
        $display("broo");
        start_item(item);
        finish_item(item);
        #20;


            `uvm_info(get_type_name(), "Set ZBB to 1. 2nd transaction", UVM_NONE);
            item.ap.zbb = 1;
        start_item(item);
        finish_item(item);
        $display("after transaction is completed");
    endtask

endclass