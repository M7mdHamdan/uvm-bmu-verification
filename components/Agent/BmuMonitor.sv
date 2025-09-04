class BmuMonitor extends uvm_monitor;
    virtual BmuInterface vif;
    uvm_analysis_port #(BmuSequenceItem) monitorPort;
    BmuSequenceItem item;
    
    `uvm_component_utils(BmuMonitor)
    
    function new(string name = "BmuMonitor", uvm_component parent = null);
        super.new(name, parent);
        monitorPort = new("monitorPort", this);
    endfunction
    
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if (!uvm_config_db#(virtual BmuInterface)::get(this, "", "vif", vif)) begin
            `uvm_fatal(get_type_name(), "Virtual interface not found")
        end
    endfunction
    
    task run_phase(uvm_phase phase);
        forever begin
            // @(vif.MonitorCb);
            @(posedge vif.clk);
            item = BmuSequenceItem::type_id::create("item");
            item.rstL = vif.MonitorCb.rstL;
            item.scanMode = vif.MonitorCb.scanMode;
            item.validIn = vif.MonitorCb.validIn;
            item.ap = vif.MonitorCb.ap;
            item.csrRenIn = vif.MonitorCb.csrRenIn;
            item.csrRdataIn = vif.MonitorCb.csrRdataIn;
            item.aIn = vif.MonitorCb.aIn;
            item.bIn = vif.MonitorCb.bIn;
            item.resultFf = vif.MonitorCb.resultFf;
            item.error = vif.MonitorCb.error;
            monitorPort.write(item);
            `uvm_info(get_type_name(), $sformatf("Monitor captured: %s", item.sprint()), UVM_HIGH)
        end
    endtask
endclass
