import uvm_pkg::*;
`include "uvm_macros.svh"

class rolSequence extends uvm_sequence #(BmuSequenceItem);

    `uvm_object_utils(rolSequence)
    function new (string name = "rolSequence");
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
        
        // Now activate the DUT and set up ROL operation
        // ROL (Rotate Left) - Zbp instruction
        // Rotates bits of a_in left by positions specified in lower 5 bits of b_in
        item.rstL = 1;
        item.validIn = 1;
        item.scanMode = 0;
        item.csrRenIn = 0;  // Must be 0 per specification
        item.csrRdataIn = 0;
        item.ap = 0;        // Clear all ap fields first (all other ap.* must be 0)
        
        // Set ROL flag (Primary Enable: ap.rol = 1)
        item.ap.rol = 1;
        
        // Test Case 1: Rotate left by 1 position
        item.aIn = 32'h80000001; // MSB=1, LSB=1
        item.bIn = 32'd1;        // Rotate left by 1 (should become 0x00000003)
        
        start_item(item);
        `uvm_info(get_type_name(), "ROL Test Case 1: Rotate 0x80000001 left by 1", UVM_NONE);
        finish_item(item);
        
        // Test Case 2: Rotate left by 4 positions
        item.aIn = 32'hF0000000; // Upper nibble all 1s
        item.bIn = 32'd4;        // Rotate left by 4 (should become 0x0000000F)
        
        start_item(item);
        `uvm_info(get_type_name(), "ROL Test Case 2: Rotate 0xF0000000 left by 4", UVM_NONE);
        finish_item(item);
        
        // Test Case 3: Rotate left by 8 positions
        item.aIn = 32'h12345678;
        item.bIn = 32'd8;        // Rotate left by 8 positions
        
        start_item(item);
        `uvm_info(get_type_name(), "ROL Test Case 3: Rotate 0x12345678 left by 8", UVM_NONE);
        finish_item(item);
        
        // Test Case 4: Rotate left by 16 positions (half word swap)
        item.aIn = 32'hAAAABBBB;
        item.bIn = 32'd16;       // Rotate left by 16 (should become 0xBBBBAAAA)
        
        start_item(item);
        `uvm_info(get_type_name(), "ROL Test Case 4: Rotate 0xAAAABBBB left by 16", UVM_NONE);
        finish_item(item);
        
        // Test Case 5: Test with rotation > 31 (should use only lower 5 bits)
        item.aIn = 32'h80000000;
        item.bIn = 32'd33;       // This should be treated as 1 (33 & 0x1F = 1)
        
        start_item(item);
        `uvm_info(get_type_name(), "ROL Test Case 5: Rotate with b_in=33 (wraps to 1)", UVM_NONE);
        finish_item(item);
        item.aIn = 32'h12345678;
        item.bIn = 32'd32;       // This should be treated as 0 (32 & 0x1F = 0)

        start_item(item);
        `uvm_info(get_type_name(), "ROL Test Case 6: Rotate with b_in=32 (wraps to 0)", UVM_NONE);
        finish_item(item);
        #40;
    endtask

endclass
