import uvm_pkg::*;
`include "uvm_macros.svh"

class packuSequence extends uvm_sequence #(BmuSequenceItem);

    `uvm_object_utils(packuSequence)
    function new (string name = "packuSequence");
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
        
        // Now activate the DUT and set up PACKU operation
        // PACKU (Pack Upper) - Zbp instruction
        // Concatenates upper 16 bits of b_in and a_in to form 32-bit result
        item.rstL = 1;
        item.validIn = 1;
        item.scanMode = 0;
        item.csrRenIn = 0;
        item.csrRdataIn = 0;
        item.ap = 0;        // Clear all ap fields first
        
        // Set PACKU flag (Primary Enable: ap.packu = 1)
        item.ap.packu = 1;
        
        // Test Case 1: Pack upper halves of simple patterns
        item.aIn = 32'h1234ABCD; // Upper 16 bits: 0x1234
        item.bIn = 32'h5678EF00; // Upper 16 bits: 0x5678
        // Expected result: {b_in[31:16], a_in[31:16]} = 0x56781234
        
        start_item(item);
        `uvm_info(get_type_name(), "PACKU Test Case 1: Pack 0x1234 from a_in and 0x5678 from b_in", UVM_NONE);
        finish_item(item);
        
        // Test Case 2: Pack with alternating bit patterns
        item.aIn = 32'hAAAA5555; // Upper 16 bits: 0xAAAA
        item.bIn = 32'h3333CCCC; // Upper 16 bits: 0x3333
        // Expected result: 0x3333AAAA
        
        start_item(item);
        `uvm_info(get_type_name(), "PACKU Test Case 2: Pack alternating patterns", UVM_NONE);
        finish_item(item);
        
        // Test Case 3: Pack with all zeros in upper halves
        item.aIn = 32'h0000FFFF; // Upper 16 bits: 0x0000
        item.bIn = 32'h00001111; // Upper 16 bits: 0x0000
        // Expected result: 0x00000000
        
        start_item(item);
        `uvm_info(get_type_name(), "PACKU Test Case 3: Pack with zero upper halves", UVM_NONE);
        finish_item(item);
        
        // Test Case 4: Pack with all ones in upper halves
        item.aIn = 32'hFFFF0000; // Upper 16 bits: 0xFFFF
        item.bIn = 32'hFFFF1234; // Upper 16 bits: 0xFFFF
        // Expected result: 0xFFFFFFFF
        
        start_item(item);
        `uvm_info(get_type_name(), "PACKU Test Case 4: Pack with all ones upper halves", UVM_NONE);
        finish_item(item);
        
        // Test Case 5: Pack with mixed patterns
        item.aIn = 32'hDEAD0000; // Upper 16 bits: 0xDEAD
        item.bIn = 32'hBEEFFFFF; // Upper 16 bits: 0xBEEF
        // Expected result: 0xBEEFDEAD
        
        start_item(item);
        `uvm_info(get_type_name(), "PACKU Test Case 5: Pack 0xDEAD and 0xBEEF", UVM_NONE);
        finish_item(item);
        
    endtask

endclass
