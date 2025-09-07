import uvm_pkg::*;
`include "uvm_macros.svh"

class sh3addSequence extends uvm_sequence #(BmuSequenceItem);

    `uvm_object_utils(sh3addSequence)
    function new (string name = "sh3addSequence");
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
        
        // Now activate the DUT and set up SH3ADD operation
        // SH3ADD (Shift Left by 3 and Add) - shifts a_in left by 3 bits and adds to b_in
        // result = (a_in << 3) + b_in
        item.rstL = 1;
        item.validIn = 1;
        item.scanMode = 0;
        item.csrRenIn = 0;       // Must be 0
        item.csrRdataIn = 0;
        item.ap = 0;             // Clear all ap fields first
        
        // Set SH3ADD and ZBA flags (Primary Enable: ap.sh3add = 1, Required Mode: ap.zba = 1)
        item.ap.sh3add = 1;
        item.ap.zba = 1;
        
        // Test Case 1: Basic shift and add
        item.aIn = 32'd5;        // 5 << 3 = 40
        item.bIn = 32'd10;       // 40 + 10 = 50
        // Expected result: 50
        
        start_item(item);
        `uvm_info(get_type_name(), "SH3ADD Test Case 1: (5 << 3) + 10 = 50", UVM_NONE);
        finish_item(item);
        
        // Test Case 2: Larger values
        item.aIn = 32'd100;      // 100 << 3 = 800
        item.bIn = 32'd200;      // 800 + 200 = 1000
        // Expected result: 1000
        
        start_item(item);
        `uvm_info(get_type_name(), "SH3ADD Test Case 2: (100 << 3) + 200 = 1000", UVM_NONE);
        finish_item(item);
        
        // Test Case 3: Zero handling
        item.aIn = 32'd0;        // 0 << 3 = 0
        item.bIn = 32'd42;       // 0 + 42 = 42
        // Expected result: 42
        
        start_item(item);
        `uvm_info(get_type_name(), "SH3ADD Test Case 3: (0 << 3) + 42 = 42", UVM_NONE);
        finish_item(item);
        
        // Test Case 4: Maximum shift before overflow
        item.aIn = 32'h0FFFFFFF; // Large value that won't overflow when shifted
        item.bIn = 32'd1;        
        // Expected result: (0x0FFFFFFF << 3) + 1 = 0x7FFFFFF8 + 1 = 0x7FFFFFF9
        
        start_item(item);
        `uvm_info(get_type_name(), "SH3ADD Test Case 4: Large value shift test", UVM_NONE);
        finish_item(item);
        
        // Test Case 5: Negative number handling (sign extension)
        item.aIn = 32'hFFFFFFFF; // -1 in 2's complement
        item.bIn = 32'd20;       // (-1 << 3) + 20 = -8 + 20 = 12
        // Expected result: 12
        
        start_item(item);
        `uvm_info(get_type_name(), "SH3ADD Test Case 5: Negative value (-1 << 3) + 20 = 12", UVM_NONE);
        finish_item(item);
        item.aIn = 32'd7; // -1 in 2's complement
        item.bIn = 32'b00000000000000000000000000001001;       // (-1 << 3) + 20 = -8 + 20 = 12
        // Expected result: 12
        
        start_item(item);
        `uvm_info(get_type_name(), "SH3ADD Test Case 5: Negative value (-1 << 3) + 20 = 12", UVM_NONE);
        finish_item(item);
        
        // Test Case 6: Test without zba flag (should not work)
        item.ap.zba = 0;         // Disable zba flag
        item.aIn = 32'd10;
        item.bIn = 32'd5;
        
        start_item(item);
        `uvm_info(get_type_name(), "SH3ADD Test Case 6: Without zba flag (should fail guard condition)", UVM_NONE);
        finish_item(item);
        #20;
    endtask

endclass
