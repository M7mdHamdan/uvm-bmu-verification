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
        item.validIn = 1;  // No valid operation during reset
        item.scanMode = 0;
        item.ap = 0;
        item.csrRenIn = 0;
        item.csrRdataIn = 0;
        item.aIn = 0;
        item.bIn = 0;
        
        start_item(item);
        `uvm_info(get_type_name(), "Reset the DUT", UVM_NONE);
        finish_item(item);
        
        // Now activate the DUT
        item.rstL = 1;
        item.validIn = 1;
        start_item(item);
        finish_item(item);
        
        // Try a simple addition with known values
        $display("Performing addition: 10 + 6 = 16");
        item.rstL = 1;
        item.validIn = 1;
        item.scanMode = 0;
        item.csrRenIn = 0;
        item.csrRdataIn = 0;
        
        // Explicitly clear all control bits
        item.ap = 0;
        
        // Turn on only the addition operation
        item.ap.add = 1;
        
        item.aIn = 32'd10;
        item.bIn = 32'd6;
        
        // Print control bits for debugging
        $display("Control bits: add=%0d, land=%0d, lor=%0d, lxor=%0d, zbb=%0d, zba=%0d, sub=%0d", 
                 item.ap.add, item.ap.land, item.ap.lor, item.ap.lxor, item.ap.zbb, item.ap.zba, item.ap.sub);
        
        start_item(item);
        finish_item(item);
        $display("transaction sent 10 + 6");
    endtask

endclass