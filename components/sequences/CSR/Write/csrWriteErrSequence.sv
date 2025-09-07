import uvm_pkg::*;
`include "uvm_macros.svh"

class csrWriteErrSequence extends uvm_sequence #(BmuSequenceItem);

    `uvm_object_utils(csrWriteErrSequence)
    function new (string name = "csrWriteErrSequence");
        super.new(name);
    endfunction 

    task body();
            BmuSequenceItem item = BmuSequenceItem::type_id::create("item");
        item.rstL = 0;
        start_item(item);
        `uvm_info(get_type_name(), "Reset the DUT", UVM_NONE);
        finish_item(item);
            item.ap.csr_imm = 1;
            assert(item.randomize() with {
                aIn inside {[32'h0000_0000:32'hFFFF_FFFF]};
                bIn inside {[32'h0000_0000:32'hFFFF_FFFF]};
            });
            item.rstL = 1;
            item.csrRenIn = 0; 
            item.ap = 0;
            item.ap.csr_write = 1;
            item.ap.csr_imm = 1;
            item.ap.zbb = 1;

        `uvm_info(get_type_name(), 
                $sformatf("CSR Write: aIn=0x%0h, bIn=0x%0h, csr_imm=%0b", 
                item.aIn, item.bIn, item.ap.csr_imm), UVM_MEDIUM);
        start_item(item);
        finish_item(item);
            item.ap.csr_imm = 0;
        `uvm_info(get_type_name(), 
                $sformatf("CSR Write: aIn=0x%0h, bIn=0x%0h, csr_imm=%0b", 
                item.aIn, item.bIn, item.ap.csr_imm), UVM_MEDIUM);
        start_item(item);
        finish_item(item);



    endtask

endclass