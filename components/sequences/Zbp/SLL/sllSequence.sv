import uvm_pkg::*;
`include "uvm_macros.svh"

class sllSequence extends uvm_sequence #(BmuSequenceItem);

    `uvm_object_utils(sllSequence)
    function new (string name = "sllSequence");
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
        
        // Now activate the DUT and set up SLL operation
        // SLL (Shift Left Logical) - shifts a_in left by b_in[4:0] positions
        // result = a_in << b_in[4:0]
        item.rstL = 1;
        item.validIn = 1;
        item.scanMode = 0;
        item.csrRenIn = 0;       // Must be 0
        item.csrRdataIn = 0;
        item.ap = 0;             // Clear all ap fields first
        
        // Set SLL flag (Primary Enable: ap.sll = 1)
        item.ap.sll = 1;
        
        // Test Case 1: Basic left shift by 1
        item.aIn = 32'h00000001;  // 1
        item.bIn = 32'd1;         // Shift left by 1
        // Expected result: 0x00000002 (1 << 1 = 2)
        
        start_item(item);
        `uvm_info(get_type_name(), "SLL Test Case 1: 1 << 1 = 2", UVM_NONE);
        finish_item(item);
        
        // Test Case 2: Shift by 4 positions
        item.aIn = 32'h0000000F;  // 15 (0xF)
        item.bIn = 32'd4;         // Shift left by 4
        // Expected result: 0x000000F0 (15 << 4 = 240)
        
        start_item(item);
        `uvm_info(get_type_name(), "SLL Test Case 2: 0xF << 4 = 0xF0", UVM_NONE);
        finish_item(item);
        
        // Test Case 3: Shift by 8 positions
        item.aIn = 32'h000000AB;  // 171 (0xAB)
        item.bIn = 32'd8;         // Shift left by 8
        // Expected result: 0x0000AB00 (171 << 8 = 43776)
        
        start_item(item);
        `uvm_info(get_type_name(), "SLL Test Case 3: 0xAB << 8 = 0xAB00", UVM_NONE);
        finish_item(item);
        
        // Test Case 4: Maximum shift (31 positions)
        item.aIn = 32'h00000001;  // 1
        item.bIn = 32'd31;        // Shift left by 31
        // Expected result: 0x80000000 (1 << 31 = -2147483648 in signed)
        
        start_item(item);
        `uvm_info(get_type_name(), "SLL Test Case 4: 1 << 31 = 0x80000000", UVM_NONE);
        finish_item(item);
        
        // Test Case 5: Zero shift amount
        item.aIn = 32'h12345678;  // Some pattern
        item.bIn = 32'd0;         // No shift
        // Expected result: 0x12345678 (no change)
        
        start_item(item);
        `uvm_info(get_type_name(), "SLL Test Case 5: 0x12345678 << 0 = 0x12345678", UVM_NONE);
        finish_item(item);
        
        // Test Case 6: Shift amount > 31 (only lower 5 bits matter)
        item.aIn = 32'h00000003;  // 3
        item.bIn = 32'd35;        // 35 = 32 + 3, so effective shift is 3
        // Expected result: 0x00000018 (3 << 3 = 24)
        
        start_item(item);
        `uvm_info(get_type_name(), "SLL Test Case 6: 3 << 35 (effective 3) = 0x18", UVM_NONE);
        finish_item(item);
        #40;
    endtask

endclass
