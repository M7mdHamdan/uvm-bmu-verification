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
            @(vif.MONITOR_CB);
            item = BmuSequenceItem::type_id::create("item");
            item.rstL = vif.MONITOR_CB.rstL;
            item.scanMode = vif.MONITOR_CB.scanMode;
            item.validIn = vif.MONITOR_CB.validIn;
            item.ap = vif.MONITOR_CB.ap;
            item.csrRenIn = vif.MONITOR_CB.csrRenIn;
            item.csrRdataIn = vif.MONITOR_CB.csrRdataIn;
            item.aIn = vif.MONITOR_CB.aIn;
            item.bIn = vif.MONITOR_CB.bIn;
            item.opcode = vif.MONITOR_CB.opcode;
            item.resultFf = vif.MONITOR_CB.resultFf;
            item.error = vif.MONITOR_CB.error;
            ap.write(item);
            `uvm_info(get_type_name(), $sformatf("Monitor captured: %s", item.sprint()), UVM_HIGH)
        end
    endtask
endclass
