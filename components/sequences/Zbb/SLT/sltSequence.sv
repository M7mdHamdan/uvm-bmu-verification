import uvm_pkg::*;
`include "uvm_macros.svh"

class sltSequence extends uvm_sequence #(BmuSequenceItem);

    `uvm_object_utils(sltSequence)
    function new (string name = "sltSequence");
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
        
        // SLT operation setup 
        item.rstL = 1; item.validIn = 1; item.scanMode = 0;
        item.csrRenIn = 0; item.csrRdataIn = 0; item.ap = 0;
        item.ap.slt = 1; item.ap.sub = 1;
        
        item.ap.unsign = 0; item.aIn = 32'd10; item.bIn = 32'd20;
        start_item(item); `uvm_info(get_type_name(), "SLT: signed true", UVM_NONE); finish_item(item);
        
        item.ap.unsign = 0; item.aIn = 32'd30; item.bIn = 32'd15;
        start_item(item); `uvm_info(get_type_name(), "SLT: signed false", UVM_NONE); finish_item(item);
        
        item.ap.unsign = 0; item.aIn = 32'hFFFFFFF0; item.bIn = 32'd5;
        start_item(item); `uvm_info(get_type_name(), "SLT: negative vs positive", UVM_NONE); finish_item(item);
        
        item.ap.unsign = 0; item.aIn = 32'd10; item.bIn = 32'hFFFFFFF0;
        start_item(item); `uvm_info(get_type_name(), "SLT: positive vs negative", UVM_NONE); finish_item(item);
        
        item.ap.unsign = 1; item.aIn = 32'hFFFFFFF0; item.bIn = 32'd5;
        start_item(item); `uvm_info(get_type_name(), "SLT: unsigned comparison", UVM_NONE); finish_item(item);
        
        item.ap.unsign = 0; item.aIn = 32'd100; item.bIn = 32'd100;
        start_item(item); `uvm_info(get_type_name(), "SLT: equal values", UVM_NONE); finish_item(item);
        
        item.ap.unsign = 0; item.aIn = 32'h80000000; item.bIn = 32'h7FFFFFFF;
        start_item(item); `uvm_info(get_type_name(), "SLT: edge case", UVM_NONE); finish_item(item);
        
    endtask

endclass
