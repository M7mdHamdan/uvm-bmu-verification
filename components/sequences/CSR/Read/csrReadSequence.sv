import uvm_pkg::*;
`include "uvm_macros.svh"

class csrReadSequence extends uvm_sequence #(BmuSequenceItem);

    `uvm_object_utils(csrReadSequence)
    function new (string name = "csrReadSequence");
        super.new(name);
    endfunction 

    task body();
        BmuSequenceItem item = BmuSequenceItem::type_id::create("item");

        item.rstL = 0;
        start_item(item);
        `uvm_info(get_type_name(), "Reset the DUT", UVM_NONE);
        finish_item(item);

        // CSR Read Test Case 1: Basic read operation
        item.ap.csr_imm = 0;
        item.ap.csr_write = 0;
        item.ap = 0;
        item.rstL = 1;
        item.csrRenIn = 1; 
        item.csrRdataIn = 32'hABCD_1234; 
        item.aIn = 32'h0;  // Not used for read, set to 0
        item.bIn = 32'h0;  // Not used for read, set to 0
        
        `uvm_info(get_type_name(), $sformatf("CSR Read Test Case 1: Reading value 0x%08h", item.csrRdataIn), UVM_MEDIUM);
        start_item(item);
        finish_item(item);
        
        // CSR Read Test Case 2: Read all zeros
        item.csrRdataIn = 32'h0000_0000;
        `uvm_info(get_type_name(), $sformatf("CSR Read Test Case 2: Reading zero value 0x%08h", item.csrRdataIn), UVM_MEDIUM);
        start_item(item);
        finish_item(item);
        
        // CSR Read Test Case 3: Read all ones
        item.csrRdataIn = 32'hFFFF_FFFF;
        `uvm_info(get_type_name(), $sformatf("CSR Read Test Case 3: Reading max value 0x%08h", item.csrRdataIn), UVM_MEDIUM);
        start_item(item);
        finish_item(item);
        
        // CSR Read Test Case 4: Read alternating pattern
        item.csrRdataIn = 32'hAAAA_AAAA;
        `uvm_info(get_type_name(), $sformatf("CSR Read Test Case 4: Reading alternating pattern 0x%08h", item.csrRdataIn), UVM_MEDIUM);
        start_item(item);
        finish_item(item);
        
        // CSR Read Test Case 5: Read inverted alternating pattern
        item.csrRdataIn = 32'h5555_5555;
        `uvm_info(get_type_name(), $sformatf("CSR Read Test Case 5: Reading inverted alternating 0x%08h", item.csrRdataIn), UVM_MEDIUM);
        start_item(item);
        finish_item(item);
        
        // CSR Read Test Case 6: Read realistic register value
        item.csrRdataIn = 32'hDEAD_BEEF;
        `uvm_info(get_type_name(), $sformatf("CSR Read Test Case 6: Reading realistic pattern 0x%08h", item.csrRdataIn), UVM_MEDIUM);
        start_item(item);
        finish_item(item);
        
        // CSR Read Test Case 7: Read power of 2 value
        item.csrRdataIn = 32'h8000_0000;
        `uvm_info(get_type_name(), $sformatf("CSR Read Test Case 7: Reading power of 2 MSB 0x%08h", item.csrRdataIn), UVM_MEDIUM);
        start_item(item);
        finish_item(item);
        
        // CSR Read Test Case 8: Read small power of 2
        item.csrRdataIn = 32'h0000_0001;
        `uvm_info(get_type_name(), $sformatf("CSR Read Test Case 8: Reading power of 2 LSB 0x%08h", item.csrRdataIn), UVM_MEDIUM);
        start_item(item);
        finish_item(item);
            




    endtask

endclass