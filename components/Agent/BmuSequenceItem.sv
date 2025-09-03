// `include "/home/Trainee3/BMU/package/BmuDef.sv"
class BmuSequenceItem extends uvm_sequence_item;
    //For write in checker
    typedef enum {Actual, Expected} itemKind;
    itemKind kind;

    rand logic clk;
    rand logic rstL;
    rand logic scanMode;
    rand logic validIn;
    typedef struct packed {
                    logic clz;  // done
                    logic ctz;  // done
                    logic cpop;
                    logic siext_b;
                    logic siext_h;
                    logic min;
                    logic max;
                    logic pack;
                    logic packu;
                    logic packh;
                    logic rol; // done
                    logic ror; // done
                    logic grev;
                    logic gorc;
                    logic zbb;
                    logic bset;
                    logic bclr;
                    logic binv;
                    logic bext;
                    logic sh1add; // done
                    logic sh2add; // done
                    logic sh3add; // done
                    logic zba; // done
                    logic land; // done
                    logic lor; // done
                    logic lxor; // done
                    logic sll; // done
                    logic srl; // done
                    logic sra; // done
                    logic beq;
                    logic bne;
                    logic blt;
                    logic bge;
                    logic add;    // done
                    logic sub;    // done
                    logic slt;    // done
                    logic unsign; // done
                    logic jal;
                    logic predict_t;
                    logic predict_nt;
                    logic csr_write;
                    logic csr_imm;
                    } rtl_alu_pkt_t;
    rand rtl_alu_pkt_t ap;
    rand logic csrRenIn;
    rand logic [31:0] csrRdataIn;
    rand logic [31:0] aIn;
    rand logic [31:0] bIn;
    
    logic [31:0] resultFf;  // Output - Final result
    logic error;            // Output - Error signal

    // Utility and Field macros
    `uvm_object_utils_begin(BmuSequenceItem)
        `uvm_field_int(clk, UVM_ALL_ON)
        `uvm_field_int(rstL, UVM_ALL_ON)
        `uvm_field_int(scanMode, UVM_ALL_ON)
        `uvm_field_int(validIn, UVM_ALL_ON)
        `uvm_field_int(ap, UVM_ALL_ON)
        `uvm_field_int(csrRenIn, UVM_ALL_ON)
        `uvm_field_int(csrRdataIn, UVM_ALL_ON)
        `uvm_field_int(aIn, UVM_ALL_ON)
        `uvm_field_int(bIn, UVM_ALL_ON)
        `uvm_field_int(resultFf, UVM_ALL_ON)
        `uvm_field_int(error, UVM_ALL_ON)
    `uvm_object_utils_end


    //  Constructor: new
    function new(string name = "BmuSequenceItem");
        super.new(name);
                // Initialize with default values
        // clk = 0;
        // rstL = 1;
        // scanMode = 0;
        // validIn = 0;
        // ap = 0;
        // csrRenIn = 0;
        // csrRdataIn = 0;
        // aIn = 0;
        // bIn = 0;
        // resultFf = 0;
        // error = 0;
    endfunction: new
    
endclass: BmuSequenceItem
