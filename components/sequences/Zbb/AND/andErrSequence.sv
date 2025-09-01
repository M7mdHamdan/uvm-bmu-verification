class andErrSequence extends uvm_sequence #(BmuSequenceItem);
    `uvm_object_utils(andErrSequence)
    function new (string name = "andErrSequence");
        super.new(name);
    endfunction 

    task body();
        BmuSequenceItem item = BmuSequenceItem::type_id::create("item");

        item.rstL = 0;
        start_item(item);
        `uvm_info(get_type_name(), "Reset the DUT", UVM_NONE);
        finish_item(item);
        // 
            item.rstL = 1;
            item.csrRenIn = 0;
            item.ap = 0;
            item.ap.land = 1;
            assert(item.randomize() with {
                aIn inside {[32'h0000_0000:32'hFFFF_FFFF]};
                bIn inside {[32'h0000_0000:32'hFFFF_FFFF]};
            });
            item.ap.zbb = 0;
            //csr not zero
            item.csrRenIn = 1;
        //
        start_item(item);
        finish_item(item);
            item.ap.zbb = 1;
        start_item(item);
        finish_item(item);
    endtask

endclass