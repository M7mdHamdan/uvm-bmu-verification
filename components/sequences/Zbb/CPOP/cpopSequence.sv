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
        
        // CPOP operation setup
        item.rstL = 1; item.validIn = 1; item.scanMode = 0;
        item.csrRenIn = 0; item.csrRdataIn = 0; item.ap = 0;
        item.ap.cpop = 1;
        
        item.aIn = 32'h55555555; item.bIn = 32'h0;
        start_item(item); `uvm_info(get_type_name(), "CPOP: alternating bits", UVM_NONE); finish_item(item);
        
        item.aIn = 32'hFFFFFFFF;
        start_item(item); `uvm_info(get_type_name(), "CPOP: all ones", UVM_NONE); finish_item(item);
        
        item.aIn = 32'h0008FFFF;
        start_item(item); `uvm_info(get_type_name(), "CPOP: mixed pattern", UVM_NONE); finish_item(item);
        
        item.aIn = 32'h0009FFFF;
        start_item(item); `uvm_info(get_type_name(), "CPOP: another pattern", UVM_NONE); finish_item(item);

    endtask

endclass
