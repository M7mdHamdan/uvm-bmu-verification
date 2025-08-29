class BmuAgent extends uvm_agent;
    `uvm_component_utils(BmuAgent)

    BmuDriver driver;
    BmuMonitor monitor;
    BmuSequencer sequencer;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if (get_is_active() == UVM_ACTIVE) begin
            sequencer = BmuSequencer::type_id::create("sequencer", this);
            driver = BmuDriver::type_id::create("driver", this);
        end
        monitor = BmuMonitor::type_id::create("monitor", this);
    endfunction
    
    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        if (get_is_active() == UVM_ACTIVE) begin
            driver.seq_item_port.connect(sequencer.seq_item_export);
        end
    endfunction

endclass: BmuAgent