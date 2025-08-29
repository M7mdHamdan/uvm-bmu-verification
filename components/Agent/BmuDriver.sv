class BmuDriver extends uvm_driver #(BmuSequenceItem);  
    `uvm_component_utils(BmuDriver)
    virtual BmuInterface vif;
    BmuSequenceItem item;

    uvm_analysis_port #(BmuSequenceItem) ap;

    function new(string name = "BmuDriver", uvm_component parent);
        super.new(name, parent);
    endfunction

    task drive();
        @(vif.DriverCb);
        vif.DriverCb.rstL <= item.rstL;  
        vif.DriverCb.scanMode <= item.scanMode;
        vif.DriverCb.validIn <= item.validIn;
        vif.DriverCb.ap <= item.ap;
        vif.DriverCb.csrRenIn <= item.csrRenIn;
        vif.DriverCb.csrRdataIn <= item.csrRdataIn;
        vif.DriverCb.aIn <= item.aIn;
        vif.DriverCb.bIn <= item.bIn;
    endtask

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        ap = new("ap", this);
        if (!uvm_config_db#(virtual BmuInterface)::get(this, "", "vif", vif))
            `uvm_fatal(get_type_name(), "Virtual interface not set at top level");
    endfunction

    virtual task run_phase(uvm_phase phase);
        super.run_phase(phase);
        forever begin
            seq_item_port.get_next_item(item);
            drive();
            ap.write(item);
            `uvm_info(get_type_name(), $sformatf(
                "Driver: signals driven to the DUT are: rstL= %0d, scanMode= %0d, validIn= %0d, ap= %0d, csrRenIn= %0d, csrRdataIn= %0h, aIn= %0h, bIn= %0h",
                item.rstL, item.scanMode, item.validIn, item.ap, item.csrRenIn,
                item.csrRdataIn, item.aIn, item.bIn), UVM_HIGH);
            seq_item_port.item_done();
        end
    endtask

endclass: BmuDriver