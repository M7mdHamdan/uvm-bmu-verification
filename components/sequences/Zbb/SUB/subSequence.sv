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
        
        // Now activate the DUT and set up SUB operation
        // SUB (Subtraction) operation - result = aIn - bIn
        item.rstL = 1;
        item.validIn = 1;
        item.scanMode = 0;
        item.csrRenIn = 0;       // Must be 0
        item.csrRdataIn = 0;
        item.ap = 0;             // Clear all ap fields first
        
        // Set SUB flag (Primary Enable: ap.sub = 1)
        item.ap.sub = 1;
        
        // Test Case 1: Basic subtraction (positive result)
        item.aIn = 32'd100;      // 100
        item.bIn = 32'd30;       // 30
        // Expected result: 70 (100 - 30)
        
        start_item(item);
        `uvm_info(get_type_name(), "SUB Test Case 1: 100 - 30 = 70", UVM_NONE);
        finish_item(item);
        
        // Test Case 2: Subtraction resulting in zero
        item.aIn = 32'd50;       // 50
        item.bIn = 32'd50;       // 50
        // Expected result: 0 (50 - 50)
        
        start_item(item);
        `uvm_info(get_type_name(), "SUB Test Case 2: 50 - 50 = 0", UVM_NONE);
        finish_item(item);
        
        // Test Case 3: Subtraction resulting in negative (underflow)
        item.aIn = 32'd25;       // 25
        item.bIn = 32'd100;      // 100
        // Expected result: 0xFFFFFF8B (-75 in 2's complement)
        
        start_item(item);
        `uvm_info(get_type_name(), "SUB Test Case 3: 25 - 100 = -75 (underflow)", UVM_NONE);
        finish_item(item);
        
        // Test Case 4: Large number subtraction
        item.aIn = 32'hFFFFFFFF; // Maximum value
        item.bIn = 32'd1;        // 1
        // Expected result: 0xFFFFFFFE
        
        start_item(item);
        `uvm_info(get_type_name(), "SUB Test Case 4: 0xFFFFFFFF - 1", UVM_NONE);
        finish_item(item);
        
        // Test Case 5: Zero minus value
        item.aIn = 32'd0;        // 0
        item.bIn = 32'd42;       // 42
        // Expected result: 0xFFFFFFD6 (-42 in 2's complement)
        
        start_item(item);
        `uvm_info(get_type_name(), "SUB Test Case 5: 0 - 42 = -42", UVM_NONE);
        finish_item(item);
        
        // Test Case 6: Subtract zero
        item.aIn = 32'd123;      // 123
        item.bIn = 32'd0;        // 0
        // Expected result: 123
        
        start_item(item);
        `uvm_info(get_type_name(), "SUB Test Case 6: 123 - 0 = 123", UVM_NONE);
        finish_item(item);
        
        // Test Case 7: Power of 2 subtraction
        item.aIn = 32'h80000000; // -2147483648 (MSB set)
        item.bIn = 32'd1;        // 1
        // Expected result: 0x7FFFFFFF (wraps around)
        
        start_item(item);
        `uvm_info(get_type_name(), "SUB Test Case 7: 0x80000000 - 1 (wrap around)", UVM_NONE);
        finish_item(item);
        
        // Test Case 8: Hex pattern subtraction
        item.aIn = 32'hDEADBEEF; // Complex pattern
        item.bIn = 32'hCAFEBABE; // Another pattern
        // Expected result: 0x13AF0431
        
        start_item(item);
        `uvm_info(get_type_name(), "SUB Test Case 8: 0xDEADBEEF - 0xCAFEBABE", UVM_NONE);
        finish_item(item);
        
        // Test Case 9: Alternating bit patterns
        item.aIn = 32'hAAAAAAAA; // 10101010... pattern
        item.bIn = 32'h55555555; // 01010101... pattern
        // Expected result: 0x55555555
        
        start_item(item);
        `uvm_info(get_type_name(), "SUB Test Case 9: Alternating patterns", UVM_NONE);
        finish_item(item);
        
        // Test Case 10: Edge case - minimum minus maximum
        item.aIn = 32'h80000000; // Most negative
        item.bIn = 32'h7FFFFFFF; // Most positive
        // Expected result: 0x00000001 (overflow wraps)
        
        start_item(item);
        `uvm_info(get_type_name(), "SUB Test Case 10: Min - Max (edge case)", UVM_NONE);
        finish_item(item);
        
    endtask

endclass
