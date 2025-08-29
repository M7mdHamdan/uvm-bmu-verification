class BmuSequencer extends uvm_sequencer#(BmuSequenceItem);
    `uvm_component_utils(BmuSequencer)

    function new (string name = "BmuSequencer", uvm_component parent);
        super.new(name, parent);
    endfunction

endclass: BmuSequencer