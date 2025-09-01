class csrReadSequence extends uvm_sequence #(BmuSequenceItem);

    `uvm_object_utils(csrReadSequence)
    function new (string name = "csrReadSequence");
        super.new(name);
    endfunction 

    task body();
        BmuSequenceItem item = BmuSequenceItem::type_id::create("item");

        item.rstL = 0;
        start_item(item);
        `uvm_info(get_type_name(), "Reset the DUT", UVM_NONE);
        finish_item(item);


            item.rstL = 1;
            item.csrRenIn = 1; 
            item.csrRdataIn = 32'hABCD_1234; 
            item.ap = 0;
        start_item(item);
        finish_item(item);
            




    endtask

endclass