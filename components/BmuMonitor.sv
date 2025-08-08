class BmuMonitor extends uvm_monitor;
    virtual BmuInterface vif;
    uvm_analysis_port #(BmuSequenceItem) ap;
    BmuSequenceItem item;
    
    `uvm_component_utils(BmuMonitor)
    
    function new(string name = "BmuMonitor", uvm_component parent = null);
        super.new(name, parent);
        ap = new("ap", this);
    endfunction
    
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if (!uvm_config_db#(virtual BmuInterface)::get(this, "", "vif", vif)) begin
            `uvm_fatal(get_type_name(), "Virtual interface not found")
        end
    endfunction
    
    task run_phase(uvm_phase phase);
        forever begin
            @(posedge vif.clk);
            if (vif.reset_n) begin
                item = BmuSequenceItem::type_id::create("item");
                item.data_in = vif.MONITOR_CB.data_in;
                item.shift_amount = vif.MONITOR_CB.shift_amount;
                item.operation = vif.MONITOR_CB.operation;
                item.data_out = vif.MONITOR_CB.data_out;
                item.overflow = vif.MONITOR_CB.overflow;
                item.underflow = vif.MONITOR_CB.underflow;
                item.error = vif.MONITOR_CB.error;
                ap.write(item);
                `uvm_info(get_type_name(), $sformatf("Monitor captured: %s", item.sprint()), UVM_HIGH)
            end
        end
    endtask
endclass
