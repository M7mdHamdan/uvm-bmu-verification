import uvm_pkg::*;
`include "uvm_macros.svh"

class csrSequence extends uvm_sequence #(BmuSequenceItem);

    `uvm_object_utils(csrSequence)
    function new (string name = "csrSequence");
        super.new(name);
    endfunction 

    task body();
        BmuSequenceItem item = BmuSequenceItem::type_id::create("item");

        // Reset DUT
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
        
        // CSR read operations
        item.rstL = 1;
        item.validIn = 1;
        item.scanMode = 0;
        item.ap = 0;
        item.csrRenIn = 1;
        
        item.csrRdataIn = 32'h12345678; item.aIn = 32'hDEADBEEF; item.bIn = 32'hCAFEBABE;
        start_item(item);
        `uvm_info(get_type_name(), "CSR read test: basic read", UVM_NONE);
        finish_item(item);
        
        item.csrRdataIn = 32'hABCDEF00; item.aIn = 32'h11111111; item.bIn = 32'h22222222;
        start_item(item);
        `uvm_info(get_type_name(), "CSR read test: different value", UVM_NONE);
        finish_item(item);
        
        item.csrRdataIn = 32'h00000000;
        start_item(item);
        `uvm_info(get_type_name(), "CSR read test: zero value", UVM_NONE);
        finish_item(item);
        
        item.csrRdataIn = 32'hFFFFFFFF;
        start_item(item);
        `uvm_info(get_type_name(), "CSR read test: all ones", UVM_NONE);
        finish_item(item);
        
        // CSR write operations  
        item.ap = 0;
        item.ap.csr_write = 1;
        item.ap.csr_imm = 1;
        item.csrRenIn = 0;
        item.csrRdataIn = 32'h00000000;
        item.aIn = 32'h11111111;
        item.bIn = 32'h87654321;
        start_item(item);
        `uvm_info(get_type_name(), "CSR write test: immediate mode", UVM_NONE);
        finish_item(item);
        
        // CSR write register mode
        item.ap = 0;
        item.ap.csr_write = 1;
        item.ap.csr_imm = 0;
        item.csrRenIn = 0;
        item.csrRdataIn = 32'h00000000;
        item.aIn = 32'h13579BDF; item.bIn = 32'h24681ACE;
        start_item(item);
        `uvm_info(get_type_name(), "CSR write test: register mode", UVM_NONE);
        finish_item(item);
        
        item.ap.csr_imm = 1;
        item.aIn = 32'hFFFFFFFF; item.bIn = 32'h00000000;
        start_item(item);
        `uvm_info(get_type_name(), "CSR write test: zero immediate", UVM_NONE);
        finish_item(item);
        
        item.ap.csr_imm = 0;
        item.aIn = 32'hFFFFFFFF; item.bIn = 32'h00000000;
        start_item(item);
        `uvm_info(get_type_name(), "CSR write test: all ones register", UVM_NONE);
        finish_item(item);
        
    endtask

endclass
