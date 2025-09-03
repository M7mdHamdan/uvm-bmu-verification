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
        
        // Try different test value - let's use smaller numbers for debugging
        $display("10 + 5 = 15");
        item.rstL = 1;
        item.validIn = 1;  // Set valid input flag to enable operation
        item.scanMode = 0;
        item.csrRenIn = 0;
        item.csrRdataIn = 0;
        
        // Explicitly clear all control bits
        item.ap = 0;
        
        // Turn on only the addition operation
        item.ap.add = 1;
        
        // Make sure all other operations are off
        item.ap.land = 0;  // Ensure logical AND is off
        item.ap.lor = 0;   // Ensure logical OR is off
        item.ap.lxor = 0;  // Ensure logical XOR is off
        item.ap.zbb = 0;   // Ensure Zbb extension is off
        item.ap.zba = 0;   // Ensure Zba extension is off
        item.ap.sub = 0;   // Ensure subtraction is off
        
        // Print control bits for debugging
        $display("Control bits: add=%0d, land=%0d, lor=%0d, lxor=%0d, zbb=%0d, zba=%0d, sub=%0d", 
                 item.ap.add, item.ap.land, item.ap.lor, item.ap.lxor, item.ap.zbb, item.ap.zba, item.ap.sub);
        
        item.aIn = 32'd10;
        item.bIn = 32'd6;
        // 15 + 27 = 42
        start_item(item);
        finish_item(item);
        $display("transaction sent");
    endtask

endclass