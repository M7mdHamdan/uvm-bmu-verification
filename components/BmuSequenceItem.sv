class BmuSequenceItem extends uvm_sequence_item;

    rand logic clk;
    rand logic rstL;
    rand logic scanMode;
    rand logic validIn;
    rand logic ap;  //Fix
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
    endfunction: new
    
endclass: BmuSequenceItem
