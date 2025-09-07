import uvm_pkg::*;
`include "uvm_macros.svh"

class csrWriteSequence extends uvm_sequence #(BmuSequenceItem);

    `uvm_object_utils(csrWriteSequence)
    function new (string name = "csrWriteSequence");
        super.new(name);
    endfunction 

    task body();
            BmuSequenceItem item = BmuSequenceItem::type_id::create("item");
        item.rstL = 0;
        start_item(item);
        `uvm_info(get_type_name(), "Reset the DUT", UVM_NONE);
        finish_item(item);
            item.ap.csr_imm = 1;
            item.aIn = 32'hFFFF_0000;
            item.bIn = 32'h0F0F_0F0F;
            item.rstL = 1;
            item.csrRenIn = 0; 
            item.ap = 0;
            item.ap.csr_write = 1;
            item.ap.csr_imm = 1;

            
        start_item(item);
        finish_item(item);
            item.ap.csr_imm = 0;
        start_item(item);
        finish_item(item);



    endtask

endclass