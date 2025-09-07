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
        
        // Now activate the DUT and set up SLT operation
        // SLT (Set on Less Than) - compares a_in and b_in
        // result = (a_in < b_in) ? 1 : 0
        item.rstL = 1;
        item.validIn = 1;
        item.scanMode = 0;
        item.csrRenIn = 0;       // Must be 0
        item.csrRdataIn = 0;
        item.ap = 0;             // Clear all ap fields first
        
        // Set SLT and SUB flags (Primary Enable: ap.slt = 1, other enable: ap.sub = 1)
        item.ap.slt = 1;
        item.ap.sub = 1;
        
        // Test Case 1: Signed comparison - positive < positive (true)
        item.ap.unsign = 0;      // Signed comparison
        item.aIn = 32'd10;       // 10
        item.bIn = 32'd20;       // 20
        // Expected result: 1 (10 < 20 is true)
        
        start_item(item);
        `uvm_info(get_type_name(), "SLT Test Case 1: 10 < 20 = 1 (signed)", UVM_NONE);
        finish_item(item);
        
        // Test Case 2: Signed comparison - positive < positive (false)
        item.ap.unsign = 0;      // Signed comparison
        item.aIn = 32'd30;       // 30
        item.bIn = 32'd15;       // 15
        // Expected result: 0 (30 < 15 is false)
        
        start_item(item);
        `uvm_info(get_type_name(), "SLT Test Case 2: 30 < 15 = 0 (signed)", UVM_NONE);
        finish_item(item);
        
        // Test Case 3: Signed comparison - negative < positive (true)
        item.ap.unsign = 0;      // Signed comparison
        item.aIn = 32'hFFFFFFF0; // -16 in 2's complement
        item.bIn = 32'd5;        // 5
        // Expected result: 1 (-16 < 5 is true)
        
        start_item(item);
        `uvm_info(get_type_name(), "SLT Test Case 3: -16 < 5 = 1 (signed)", UVM_NONE);
        finish_item(item);
        
        // Test Case 4: Signed comparison - positive < negative (false)
        item.ap.unsign = 0;      // Signed comparison
        item.aIn = 32'd10;       // 10
        item.bIn = 32'hFFFFFFF0; // -16 in 2's complement
        // Expected result: 0 (10 < -16 is false)
        
        start_item(item);
        `uvm_info(get_type_name(), "SLT Test Case 4: 10 < -16 = 0 (signed)", UVM_NONE);
        finish_item(item);
        
        // Test Case 5: Unsigned comparison (SLTU) - same values as case 3
        item.ap.unsign = 1;      // Unsigned comparison
        item.aIn = 32'hFFFFFFF0; // Large unsigned value (4294967280)
        item.bIn = 32'd5;        // 5
        // Expected result: 0 (4294967280 < 5 is false in unsigned)
        
        start_item(item);
        `uvm_info(get_type_name(), "SLT Test Case 5: 0xFFFFFFF0 < 5 = 0 (unsigned)", UVM_NONE);
        finish_item(item);
        
        // Test Case 6: Equal values
        item.ap.unsign = 0;      // Signed comparison
        item.aIn = 32'd100;      // 100
        item.bIn = 32'd100;      // 100
        // Expected result: 0 (100 < 100 is false)
        
        start_item(item);
        `uvm_info(get_type_name(), "SLT Test Case 6: 100 < 100 = 0 (equal values)", UVM_NONE);
        finish_item(item);
        
        // Test Case 7: Edge case - maximum negative vs maximum positive
        item.ap.unsign = 0;      // Signed comparison
        item.aIn = 32'h80000000; // -2147483648 (most negative)
        item.bIn = 32'h7FFFFFFF; // 2147483647 (most positive)
        // Expected result: 1 (-2147483648 < 2147483647 is true)
        
        start_item(item);
        `uvm_info(get_type_name(), "SLT Test Case 7: 0x80000000 < 0x7FFFFFFF = 1 (edge case)", UVM_NONE);
        finish_item(item);
        
    endtask

endclass
