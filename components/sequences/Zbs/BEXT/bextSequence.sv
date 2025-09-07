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
        
        // Now activate the DUT and set up BEXT operation
        // BEXT (Bit Extraction) - ZBS instruction
        // Extract single bit from a_in at position specified by lower 5 bits of b_in
        item.rstL = 1;
        item.validIn = 1;
        item.scanMode = 0;
        item.csrRenIn = 0;  // Must be 0 per specification
        item.csrRdataIn = 0;
        item.ap = 0;        // Clear all ap fields first
        
        // Set BEXT flag (Primary Enable: ap.bext = 1)
        item.ap.bext = 1;
        
        // Test Case 1: Extract bit at position 0 (LSB)
        item.aIn = 32'b11111111111111111111111111111101; // All 1s except bit 0
        item.bIn = 32'd0;  // Extract bit position 0 (should return 0)
        
        start_item(item);
        `uvm_info(get_type_name(), "BEXT Test Case 1: Extract bit 0 from 0xFFFFFFFD", UVM_NONE);
        finish_item(item);
        
        // Test Case 2: Extract bit at position 5
        item.aIn = 32'b00000000000000000000000000100000; // Only bit 5 is set
        item.bIn = 32'd5;  // Extract bit position 5 (should return 1)
        
        start_item(item);
        `uvm_info(get_type_name(), "BEXT Test Case 2: Extract bit 5 from 0x00000020", UVM_NONE);
        finish_item(item);
        
        // Test Case 3: Extract bit at position 31 (MSB)
        item.aIn = 32'b10000000000000000000000000000000; // Only MSB is set
        item.bIn = 32'd31; // Extract bit position 31 (should return 1)
        
        start_item(item);
        `uvm_info(get_type_name(), "BEXT Test Case 3: Extract bit 31 from 0x80000000", UVM_NONE);
        finish_item(item);
        
        // Test Case 4: Extract from alternating bit pattern
        item.aIn = 32'h55555555; // Pattern: 01010101...
        item.bIn = 32'd10; // Extract bit position 10 (should return 0 in this pattern)
        
        start_item(item);
        `uvm_info(get_type_name(), "BEXT Test Case 4: Extract bit 10 from alternating pattern", UVM_NONE);
        finish_item(item);
        
        // Test Case 5: Test with bit position > 31 (should use only lower 5 bits)
        item.aIn = 32'hAAAAAAAA; // Pattern: 10101010...
        item.bIn = 32'd33; // This should be treated as position 1 (33 & 0x1F = 1)
        
        start_item(item);
        `uvm_info(get_type_name(), "BEXT Test Case 5: Extract with b_in=33 (wraps to position 1)", UVM_NONE);
        finish_item(item);
        
        // Test Case 6: Extract from all zeros
        item.aIn = 32'h00000000; // All zeros
        item.bIn = 32'd15; // Extract bit position 15 (should return 0)
        
        start_item(item);
        `uvm_info(get_type_name(), "BEXT Test Case 6: Extract bit 15 from all zeros", UVM_NONE);
        finish_item(item);
        
        // Test Case 7: Extract from specific bit pattern (powers of 2)
        item.aIn = 32'h00000100; // Only bit 8 is set (256 in decimal)
        item.bIn = 32'd8; // Extract bit position 8 (should return 1)
        
        start_item(item);
        `uvm_info(get_type_name(), "BEXT Test Case 7: Extract bit 8 from 0x00000100", UVM_NONE);
        finish_item(item);
        
        // Test Case 8: Extract from complex bit pattern with multiple bits set
        item.aIn = 32'hDEADBEEF; // Complex pattern
        item.bIn = 32'd16; // Extract bit position 16 (check bit 16 of 0xDEADBEEF)
        
        start_item(item);
        `uvm_info(get_type_name(), "BEXT Test Case 8: Extract bit 16 from 0xDEADBEEF", UVM_NONE);
        finish_item(item);
        
    endtask

endclass
