
import uvm_pkg::*;
`include "uvm_macros.svh"

class gorcSequence extends uvm_sequence #(BmuSequenceItem);

    `uvm_object_utils(gorcSequence)
    function new (string name = "gorcSequence");
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
        
        // Now activate the DUT and set up GORC operation
        // GORC (Bitwise OR-Combine) - Byte Granule
        // Performs bitwise OR reduction within each byte of a_in
        // If any bit in a byte is 1, entire byte becomes 0xFF
        // If all bits in a byte are 0, byte becomes 0x00
        item.rstL = 1;
        item.validIn = 1;
        item.scanMode = 0;
        item.csrRenIn = 0;
        item.csrRdataIn = 0;
        item.ap = 0;        // Clear all ap fields first
        
        // Set GORC flag (Primary Enable: ap.gorc = 1)
        item.ap.gorc = 1;
        
        // Test Case 1: Mixed byte pattern
        item.aIn = 32'h01020304; // Bytes: 01, 02, 03, 04 (all have bits set)
        item.bIn = 32'd7;        // Mode Select: b_in[4:0] = 5'b00111 (7)
        // Expected result: 0xFFFFFFFF (all bytes become 0xFF)
        
        start_item(item);
        `uvm_info(get_type_name(), "GORC Test Case 1: Mixed bytes 0x01020304", UVM_NONE);
        finish_item(item);
        
        // Test Case 2: Some zero bytes
        item.aIn = 32'h00FF0001; // Bytes: 00, FF, 00, 01
        item.bIn = 32'd7;        // Mode Select: b_in[4:0] = 5'b00111 (7)
        // Expected result: 0x00FF00FF (zero bytes stay 0x00, others become 0xFF)
        
        start_item(item);
        `uvm_info(get_type_name(), "GORC Test Case 2: Pattern with zero bytes 0x00FF0001", UVM_NONE);
        finish_item(item);
        
        // Test Case 3: All zero bytes
        item.aIn = 32'h00000000; // All bytes are zero
        item.bIn = 32'd7;        // Mode Select: b_in[4:0] = 5'b00111 (7)
        // Expected result: 0x00000000 (all bytes remain 0x00)
        
        start_item(item);
        `uvm_info(get_type_name(), "GORC Test Case 3: All zero bytes 0x00000000", UVM_NONE);
        finish_item(item);
        
        // Test Case 4: Single bit set in each byte
        item.aIn = 32'h01010101; // Each byte has only LSB set
        item.bIn = 32'd7;        // Mode Select: b_in[4:0] = 5'b00111 (7)
        // Expected result: 0xFFFFFFFF (each byte becomes 0xFF)
        
        start_item(item);
        `uvm_info(get_type_name(), "GORC Test Case 4: Single bit per byte 0x01010101", UVM_NONE);
        finish_item(item);
        
        // Test Case 5: Alternating pattern
        item.aIn = 32'h00AA0055; // Bytes: 00, AA, 00, 55
        item.bIn = 32'd7;        // Mode Select: b_in[4:0] = 5'b00111 (7)
        // Expected result: 0x00FF00FF
        
        start_item(item);
        `uvm_info(get_type_name(), "GORC Test Case 5: Alternating pattern 0x00AA0055", UVM_NONE);
        finish_item(item);
        
        // Test Case 6: Test with different b_in value (should not work as GORC)
        item.aIn = 32'h12345678;
        item.bIn = 32'd3;        // Different mode (not 7), might not trigger GORC
        
        start_item(item);
        `uvm_info(get_type_name(), "GORC Test Case 6: Wrong mode b_in=3 (should not be GORC)", UVM_NONE);
        finish_item(item);

        // Test Case 7: 
        item.aIn = 32'h12345678;
        item.bIn = 32'd7;        
        item.ap.zbb = 1; // Set another ap flag along with gorc
        start_item(item);
        `uvm_info(get_type_name(), "GORC Test Case 7: Correct mode b_in=7 (should be GORC)", UVM_NONE);
        finish_item(item);
        #20;
    endtask

endclass
