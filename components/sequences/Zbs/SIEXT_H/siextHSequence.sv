import uvm_pkg::*;
`include "uvm_macros.svh"

class siextHSequence extends uvm_sequence #(BmuSequenceItem);

    `uvm_object_utils(siextHSequence)
    function new (string name = "siextHSequence");
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
        
                // SIEXT_H operation setup
        item.rstL = 1; item.validIn = 1; item.scanMode = 0;
        item.csrRenIn = 0; item.csrRdataIn = 0; item.ap = 0;
        item.ap.siext_h = 1;
        
                item.aIn = 32'hABCD5678; item.bIn = 32'd0;
        start_item(item); `uvm_info(get_type_name(), "SIEXT_H: positive halfword", UVM_NONE); finish_item(item);
        
        item.aIn = 32'h1234ABCD; item.bIn = 32'd0;
        start_item(item); `uvm_info(get_type_name(), "SIEXT_H: negative halfword", UVM_NONE); finish_item(item);
        
        item.aIn = 32'hFFFF7FFF; item.bIn = 32'd0;
        start_item(item); `uvm_info(get_type_name(), "SIEXT_H: max positive", UVM_NONE); finish_item(item);
        
        item.aIn = 32'h00008000; item.bIn = 32'd0;
        start_item(item); `uvm_info(get_type_name(), "SIEXT_H: max negative", UVM_NONE); finish_item(item);
        
        item.aIn = 32'hFFFF0000; item.bIn = 32'd0;
        start_item(item); `uvm_info(get_type_name(), "SIEXT_H: zero value", UVM_NONE); finish_item(item);
        
        item.aIn = 32'h0000FFFF; item.bIn = 32'd0;
        start_item(item); `uvm_info(get_type_name(), "SIEXT_H: all ones", UVM_NONE); finish_item(item);
        
        item.aIn = 32'h12348001; item.bIn = 32'd0;
        start_item(item); `uvm_info(get_type_name(), "SIEXT_H: boundary case", UVM_NONE); finish_item(item);
        
        // Test Case 2: Negative half-word (sign bit = 1)
        item.aIn = 32'h1234ABCD; // Lower 16 bits: 0xABCD, bit 15 = 1 (negative)
        item.bIn = 32'd0;        // Not used
        // Expected result: 0xFFFFABCD (sign extended with 1s)
        
        start_item(item);
        `uvm_info(get_type_name(), "SIEXT_H Test Case 2: 0xABCD -> 0xFFFFABCD (negative)", UVM_NONE);
        finish_item(item);
        
        // Test Case 3: Maximum positive half-word
        item.aIn = 32'hFFFF7FFF; // Lower 16 bits: 0x7FFF (32767), bit 15 = 0
        item.bIn = 32'd0;        // Not used
        // Expected result: 0x00007FFF (maximum positive 16-bit value)
        
        start_item(item);
        `uvm_info(get_type_name(), "SIEXT_H Test Case 3: 0x7FFF -> 0x00007FFF (max positive)", UVM_NONE);
        finish_item(item);
        
        // Test Case 4: Maximum negative half-word
        item.aIn = 32'h00008000; // Lower 16 bits: 0x8000 (-32768), bit 15 = 1
        item.bIn = 32'd0;        // Not used
        // Expected result: 0xFFFF8000 (maximum negative 16-bit value)
        
        start_item(item);
        `uvm_info(get_type_name(), "SIEXT_H Test Case 4: 0x8000 -> 0xFFFF8000 (max negative)", UVM_NONE);
        finish_item(item);
        
        // Test Case 5: Zero value
        item.aIn = 32'hFFFF0000; // Lower 16 bits: 0x0000, bit 15 = 0
        item.bIn = 32'd0;        // Not used
        // Expected result: 0x00000000 (zero extends to zero)
        
        start_item(item);
        `uvm_info(get_type_name(), "SIEXT_H Test Case 5: 0x0000 -> 0x00000000 (zero)", UVM_NONE);
        finish_item(item);
        
        // Test Case 6: All ones in lower half-word
        item.aIn = 32'h0000FFFF; // Lower 16 bits: 0xFFFF (-1), bit 15 = 1
        item.bIn = 32'd0;        // Not used
        // Expected result: 0xFFFFFFFF (sign extended to all 1s)
        
        start_item(item);
        `uvm_info(get_type_name(), "SIEXT_H Test Case 6: 0xFFFF -> 0xFFFFFFFF (all ones)", UVM_NONE);
        finish_item(item);
        
        // Test Case 7: Boundary case - 0x8001 (negative)
        item.aIn = 32'h12348001; // Lower 16 bits: 0x8001, bit 15 = 1
        item.bIn = 32'd0;        // Not used  
        // Expected result: 0xFFFF8001 (sign extended negative)
        
        start_item(item);
        `uvm_info(get_type_name(), "SIEXT_H Test Case 7: 0x8001 -> 0xFFFF8001 (boundary negative)", UVM_NONE);
        finish_item(item);
        
    endtask

endclass
