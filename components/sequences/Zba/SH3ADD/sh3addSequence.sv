import uvm_pkg::*;
`include "uvm_macros.svh"

class sh3addSequence extends uvm_sequence #(BmuSequenceItem);

    `uvm_object_utils(sh3addSequence)
    function new (string name = "sh3addSequence");
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
        
        // SH3ADD operation setup
        item.rstL = 1; item.validIn = 1; item.scanMode = 0;
        item.csrRenIn = 0; item.csrRdataIn = 0; item.ap = 0;
        item.ap.sh3add = 1; item.ap.zba = 1;
        
        item.aIn = 32'd5; item.bIn = 32'd10;
        start_item(item); `uvm_info(get_type_name(), "SH3ADD: basic shift add", UVM_NONE); finish_item(item);
        
        item.aIn = 32'd100; item.bIn = 32'd200;
        start_item(item); `uvm_info(get_type_name(), "SH3ADD: larger values", UVM_NONE); finish_item(item);
        
        item.aIn = 32'd0; item.bIn = 32'd42;
        start_item(item); `uvm_info(get_type_name(), "SH3ADD: zero handling", UVM_NONE); finish_item(item);
        
        item.aIn = 32'h0FFFFFFF; item.bIn = 32'd1;
        start_item(item); `uvm_info(get_type_name(), "SH3ADD: large value", UVM_NONE); finish_item(item);
        
        item.aIn = 32'hFFFFFFFF; item.bIn = 32'd20;
        start_item(item); `uvm_info(get_type_name(), "SH3ADD: negative value", UVM_NONE); finish_item(item);
        
        item.aIn = 32'd7; item.bIn = 32'b00000000000000000000000000001001;
        start_item(item); `uvm_info(get_type_name(), "SH3ADD: pattern test", UVM_NONE); finish_item(item);
        
        item.ap.zba = 0;
        item.aIn = 32'd10;
        item.bIn = 32'd5;
        
        start_item(item);
        `uvm_info(get_type_name(), "SH3ADD Test Case 6: Without zba flag (should fail guard condition)", UVM_NONE);
        finish_item(item);
        #20;
    endtask

endclass
