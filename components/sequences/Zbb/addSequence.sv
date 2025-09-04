import uvm_pkg::*;
`include "uvm_macros.svh"

class addSequence extends uvm_sequence #(BmuSequenceItem);

    `uvm_object_utils(addSequence)
    function new (string name = "addSequence");
        super.new(name);
    endfunction 

    task body();
        BmuSequenceItem item = BmuSequenceItem::type_id::create("item");
        $display("WTFYO");
        // Reset transaction
        `uvm_info(get_type_name(), "Reset the DUT", UVM_NONE);
        item.rstL = 0;
        item.validIn = 1;  
        item.scanMode = 0;
        item.ap = 0;
        item.csrRenIn = 0;
        item.csrRdataIn = 0;
        item.aIn = 0;
        item.bIn = 0;
        
        start_item(item);
        finish_item(item);
        // #10;
        item.rstL = 1;
        item.validIn = 1;  
        item.scanMode = 0;
        item.csrRenIn = 0;
        item.csrRdataIn = 0;
        item.ap = 0;
        item.ap.add = 1;
        item.aIn = 32'd10;
        item.bIn = 32'd1;

        start_item(item);
        finish_item(item);
        // #10;
        item.bIn = 32'd2;
        start_item(item);
        finish_item(item);
        // #10;
        item.bIn = 32'd3;
        start_item(item);
        finish_item(item);
        // #10;
        item.bIn = 32'd4;
        start_item(item);
        finish_item(item);
        // #10;
        item.bIn = 32'd5;
        start_item(item);
        finish_item(item);
        // #10;
        item.bIn = 32'd10;
        start_item(item);
        finish_item(item);
        // #10;
        item.bIn = 32'd20;
        start_item(item);
        finish_item(item);
        // #10;
        item.bIn = 32'd30;
        start_item(item);
        finish_item(item);
        // #10;
        

    // Reset transaction
        `uvm_info(get_type_name(), "Reset the DUT", UVM_NONE);
        item.rstL = 0;
        item.validIn = 1;  
        item.scanMode = 0;
        item.ap = 0;
        item.csrRenIn = 0;
        item.csrRdataIn = 0;
        item.aIn = 0;
        item.bIn = 0;
        
        start_item(item);
        finish_item(item);
        // #10;
        item.rstL = 1;

    endtask

endclass