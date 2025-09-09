import uvm_pkg::*;
`include "uvm_macros.svh"

class bextSequence extends uvm_sequence #(BmuSequenceItem);

    `uvm_object_utils(bextSequence)
    function new (string name = "bextSequence");
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
        
        // BEXT operation setup
        item.rstL = 1; item.validIn = 1; item.scanMode = 0;
        item.csrRenIn = 0; item.csrRdataIn = 0; item.ap = 0;
        item.ap.bext = 1;
        
        item.aIn = 32'b11111111111111111111111111111101; item.bIn = 32'd0;
        start_item(item); `uvm_info(get_type_name(), "BEXT: bit 0 extraction", UVM_NONE); finish_item(item);
        
        item.aIn = 32'b00000000000000000000000000100000; item.bIn = 32'd5;
        start_item(item); `uvm_info(get_type_name(), "BEXT: bit 5 extraction", UVM_NONE); finish_item(item);
        
        item.aIn = 32'b10000000000000000000000000000000; item.bIn = 32'd31;
        start_item(item); `uvm_info(get_type_name(), "BEXT: MSB extraction", UVM_NONE); finish_item(item);
        
        item.aIn = 32'h55555555; item.bIn = 32'd10;
        start_item(item); `uvm_info(get_type_name(), "BEXT: alternating pattern", UVM_NONE); finish_item(item);
        
        item.aIn = 32'hAAAAAAAA; item.bIn = 32'd33;
        start_item(item); `uvm_info(get_type_name(), "BEXT: position wrap", UVM_NONE); finish_item(item);
        
        item.aIn = 32'h00000000; item.bIn = 32'd15;
        start_item(item); `uvm_info(get_type_name(), "BEXT: all zeros", UVM_NONE); finish_item(item);
        
        item.aIn = 32'h00000100; item.bIn = 32'd8;
        start_item(item); `uvm_info(get_type_name(), "BEXT: power of 2", UVM_NONE); finish_item(item);
        
        item.aIn = 32'hDEADBEEF; item.bIn = 32'd16;
        start_item(item); `uvm_info(get_type_name(), "BEXT: complex pattern", UVM_NONE); finish_item(item);
        
    endtask

endclass
