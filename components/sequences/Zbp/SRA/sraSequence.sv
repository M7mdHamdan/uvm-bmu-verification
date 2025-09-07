import uvm_pkg::*;
`include "uvm_macros.svh"

class sraSequence extends uvm_sequence #(BmuSequenceItem);

    `uvm_object_utils(sraSequence)
    function new (string name = "sraSequence");
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
        
        // Now activate the DUT and set up SRA operation
        // SRA (Shift Right Arithmetic) - shifts a_in right by b_in[4:0] positions
        // with sign extension (preserves sign bit)
        item.rstL = 1;
        item.validIn = 1;
        item.scanMode = 0;
        item.csrRenIn = 0;       // Must be 0
        item.csrRdataIn = 0;
        item.ap = 0;             // Clear all ap fields first
        
        // Set SRA flag (Primary Enable: ap.sra = 1)
        item.ap.sra = 1;
        
        // Test Case 1: Positive number right shift by 1
        item.aIn = 32'h00000008;  // 8 (positive)
        item.bIn = 32'd1;         // Shift right by 1
        // Expected result: 0x00000004 (8 >> 1 = 4, sign extended with 0s)
        
        start_item(item);
        `uvm_info(get_type_name(), "SRA Test Case 1: 8 >> 1 = 4 (positive)", UVM_NONE);
        finish_item(item);
        
        // Test Case 2: Negative number right shift by 1
        item.aIn = 32'hFFFFFFF8;  // -8 (negative in 2's complement)
        item.bIn = 32'd1;         // Shift right by 1
        // Expected result: 0xFFFFFFFC (-8 >> 1 = -4, sign extended with 1s)
        
        start_item(item);
        `uvm_info(get_type_name(), "SRA Test Case 2: -8 >> 1 = -4 (negative)", UVM_NONE);
        finish_item(item);
        
        // Test Case 3: Positive number right shift by 4
        item.aIn = 32'h000000F0;  // 240 (positive)
        item.bIn = 32'd4;         // Shift right by 4
        // Expected result: 0x0000000F (240 >> 4 = 15)
        
        start_item(item);
        `uvm_info(get_type_name(), "SRA Test Case 3: 240 >> 4 = 15", UVM_NONE);
        finish_item(item);
        
        // Test Case 4: Negative number right shift by 4
        item.aIn = 32'hFFFFFFF0;  // -16 (negative)
        item.bIn = 32'd4;         // Shift right by 4
        // Expected result: 0xFFFFFFFF (-16 >> 4 = -1, sign extended)
        
        start_item(item);
        `uvm_info(get_type_name(), "SRA Test Case 4: -16 >> 4 = -1", UVM_NONE);
        finish_item(item);
        
        // Test Case 5: Maximum negative number
        item.aIn = 32'h80000000;  // -2147483648 (most negative 32-bit number)
        item.bIn = 32'd1;         // Shift right by 1
        // Expected result: 0xC0000000 (-1073741824, sign extended)
        
        start_item(item);
        `uvm_info(get_type_name(), "SRA Test Case 5: 0x80000000 >> 1 = 0xC0000000", UVM_NONE);
        finish_item(item);
        
        // Test Case 6: Zero shift amount
        item.aIn = 32'hDEADBEEF;  // Some negative pattern
        item.bIn = 32'd0;         // No shift
        // Expected result: 0xDEADBEEF (no change)
        
        start_item(item);
        `uvm_info(get_type_name(), "SRA Test Case 6: 0xDEADBEEF >> 0 = 0xDEADBEEF", UVM_NONE);
        finish_item(item);
        
        // Test Case 7: Large shift (31 positions) on negative number
        item.aIn = 32'h80000000;  // -2147483648
        item.bIn = 32'd31;        // Shift right by 31
        // Expected result: 0xFFFFFFFF (-1, all sign bits)
        
        start_item(item);
        `uvm_info(get_type_name(), "SRA Test Case 7: 0x80000000 >> 31 = 0xFFFFFFFF", UVM_NONE);
        finish_item(item);
        
    endtask

endclass
