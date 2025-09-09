import uvm_pkg::*;
`include "uvm_macros.svh"

class subSequence extends uvm_sequence #(BmuSequenceItem);

    `uvm_object_utils(subSequence)
    function new (string name = "subSequence");
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
        
        // SUB operation setup
        item.rstL = 1; item.validIn = 1; item.scanMode = 0;
        item.csrRenIn = 0; item.csrRdataIn = 0; item.ap = 0;
        item.ap.sub = 1;
        
        item.aIn = 32'd100; item.bIn = 32'd30;
        start_item(item); `uvm_info(get_type_name(), "SUB: basic subtraction", UVM_NONE); finish_item(item);
        
        item.aIn = 32'd50; item.bIn = 32'd50;
        start_item(item); `uvm_info(get_type_name(), "SUB: result zero", UVM_NONE); finish_item(item);
        
        item.aIn = 32'd25; item.bIn = 32'd100;
        start_item(item); `uvm_info(get_type_name(), "SUB: negative result", UVM_NONE); finish_item(item);
        
        item.aIn = 32'hFFFFFFFF; item.bIn = 32'd1;
        start_item(item); `uvm_info(get_type_name(), "SUB: max value", UVM_NONE); finish_item(item);
        
        item.aIn = 32'd0; item.bIn = 32'd42;
        start_item(item); `uvm_info(get_type_name(), "SUB: zero minus value", UVM_NONE); finish_item(item);
        
        item.aIn = 32'd123; item.bIn = 32'd0;
        start_item(item); `uvm_info(get_type_name(), "SUB: subtract zero", UVM_NONE); finish_item(item);
        
        item.aIn = 32'h80000000; item.bIn = 32'd1;
        start_item(item); `uvm_info(get_type_name(), "SUB: MSB wrap", UVM_NONE); finish_item(item);
        
        item.aIn = 32'hDEADBEEF; item.bIn = 32'hCAFEBABE;
        start_item(item); `uvm_info(get_type_name(), "SUB: hex patterns", UVM_NONE); finish_item(item);
        
        item.aIn = 32'hAAAAAAAA; item.bIn = 32'h55555555;
        start_item(item); `uvm_info(get_type_name(), "SUB: alternating bits", UVM_NONE); finish_item(item);
        
        item.aIn = 32'h80000000; item.bIn = 32'h7FFFFFFF;
        start_item(item); `uvm_info(get_type_name(), "SUB: min minus max", UVM_NONE); finish_item(item);
        
    endtask

endclass
