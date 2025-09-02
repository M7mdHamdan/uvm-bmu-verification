import uvm_pkg::*;
`include "uvm_macros.svh"

class addSequence extends uvm_sequence #(BmuSequenceItem);

    `uvm_object_utils(addSequence)
    function new (string name = "addSequence");
        super.new(name);
    endfunction 

    task body();
        BmuSequenceItem item = BmuSequenceItem::type_id::create("item");

        item.rstL = 0;
        start_item(item);
        `uvm_info(get_type_name(), "Reset the DUT", UVM_NONE);
        finish_item(item);
        // 15 + 27 = 42 LEGIT
            item.rstL = 1;
            item.csrRenIn = 0;
            item.ap = 0;
            item.ap.add = 1;
            item.aIn = 32'd15;
            item.bIn = 32'd27;
        // 15 + 27 = 42
        start_item(item);
        finish_item(item);
    endtask

endclass