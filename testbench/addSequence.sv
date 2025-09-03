import uvm_pkg::*;
`include "uvm_macros.svh"

class addSequence extends uvm_sequence #(BmuSequenceItem);

    `uvm_object_utils(addSequence)
    function new (string name = "addSequence");
        super.new(name);
    endfunction 

    task body();
        BmuSequenceItem item = BmuSequenceItem::type_id::create("item");

        // Reset transaction
        item.rstL = 0;
        item.validIn = 0;  // No valid operation during reset
        item.scanMode = 0;
        item.ap = 0;
        item.csrRenIn = 0;
        item.csrRdataIn = 0;
        item.aIn = 0;
        item.bIn = 0;
        
        start_item(item);
        `uvm_info(get_type_name(), "Reset the DUT", UVM_NONE);
        finish_item(item);
        
        // 15 + 27 = 42 LEGIT
        $display("15 + 27 = 42");
        item.rstL = 1;
        item.validIn = 1;  // Set valid input flag to enable operation
        item.scanMode = 0;
        item.csrRenIn = 0;
        item.csrRdataIn = 0;
        item.ap = 0;       // Clear all operation flags first
        item.ap.add = 1;   // Set the add flag
        item.aIn = 32'd15;
        item.bIn = 32'd27;
        // 15 + 27 = 42
        start_item(item);
        finish_item(item);
        $display("transaction sent");
    endtask

endclass