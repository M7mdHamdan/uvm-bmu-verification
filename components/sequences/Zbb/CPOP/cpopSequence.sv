import uvm_pkg::*;
`include "uvm_macros.svh"

class cpopSequence extends uvm_sequence #(BmuSequenceItem);

    `uvm_object_utils(cpopSequence)
    function new (string name = "cpopSequence");
        super.new(name);
    endfunction 

    task body();
        BmuSequenceItem item = BmuSequenceItem::type_id::create("item");

        // Reset transaction
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
        
        // Now activate the DUT and set up CPOP operation
        // CPOP (Count Population - count number of 1s) - ZBB instruction
        // TODO: Add proper input values and control settings for CPOP
        item.rstL = 1;
        item.validIn = 1;
        item.scanMode = 0;
        item.csrRenIn = 0;
        item.csrRdataIn = 0;
        item.ap = 0;
        
        // Set CPOP flag
        item.ap.cpop = 1;
        
        // Set test values for CPOP operation
        // CPOP will count number of 1s in aIn
        item.aIn = 32'h55555555; // Should result in count of 16 bits set to 1
        item.bIn = 32'h0;        // Not used for CPOP
        
        start_item(item);
        `uvm_info(get_type_name(), "CPOP first test case", UVM_NONE);
        finish_item(item);
        #20;
        // Try another test case with different input
        item.aIn = 32'hFFFFFFFF; // Should result in count of 32 bits set to 1
        
        start_item(item);
        `uvm_info(get_type_name(), "CPOP second test case", UVM_NONE);
        finish_item(item);
        #20;
        item.aIn = 32'h0008FFFF; // Should result in count of 32 bits set to 1
        
        start_item(item);
        `uvm_info(get_type_name(), "CPOP second test case", UVM_NONE);
        finish_item(item);
        #20;
        item.aIn = 32'h0009FFFF; // Should result in count of 32 bits set to 1
        
        start_item(item);
        `uvm_info(get_type_name(), "CPOP second test case", UVM_NONE);
        finish_item(item);
        #20;

    endtask

endclass
