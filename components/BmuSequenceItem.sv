class BmuSequenceItem extends uvm_sequence_item;
    // Input signals
    rand logic [31:0] data_in;
    rand logic [4:0] shift_amount;
    rand logic [2:0] operation;
    
    // Output signals
    logic [31:0] data_out;
    logic overflow;
    logic underflow;
    logic error;
    
    // UVM macros
    `uvm_object_utils_begin(BmuSequenceItem)
        `uvm_field_int(data_in, UVM_ALL_ON)
        `uvm_field_int(shift_amount, UVM_ALL_ON)
        `uvm_field_int(operation, UVM_ALL_ON)
        `uvm_field_int(data_out, UVM_ALL_ON)
        `uvm_field_int(overflow, UVM_ALL_ON)
        `uvm_field_int(underflow, UVM_ALL_ON)
        `uvm_field_int(error, UVM_ALL_ON)
    `uvm_object_utils_end
    
    // Constructor
    function new(string name = "BmuSequenceItem");
        super.new(name);
    endfunction
    
    // Constraints
    constraint valid_operation {
        operation inside {3'b000, 3'b001, 3'b010, 3'b011, 3'b100, 3'b101};
    }
    
    constraint valid_shift {
        shift_amount inside {[0:31]};
    }
endclass
