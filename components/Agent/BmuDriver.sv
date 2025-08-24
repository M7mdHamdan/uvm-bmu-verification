class BmuDriver extends uvm_driver #(BmuSequenceItem);  
    `uvm_component_utils(BmuDriver)
    virtual BmuInterface vif;
    BmuSequenceItem item;



    function new(string name = "BmuDriver", uvm_component parent);
        super.new(name, parent);
    endfunction

    task drive();
        @(vif.DRIVER_CB);
        vif.DRIVER_CB.rstL <= item.rstL;  
        vif.DRIVER_CB.scanMode <= item.scanMode;
        vif.DRIVER_CB.validIn <= item.validIn;
        vif.DRIVER_CB.ap <= item.ap;
        vif.DRIVER_CB.csrRenIn <= item.csrRenIn;
        vif.DRIVER_CB.csrRdataIn <= item.csrRdataIn;
        vif.DRIVER_CB.aIn <= item.aIn;
        vif.DRIVER_CB.bIn <= item.bIn;
        vif.DRIVER_CB.opcode <= item.opcode;
    endtask

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if (!uvm_config_db#(virtual BmuInterface)::get(this, "", "vif", vif))
            `uvm_fatal(get_type_name(), "Virtual interface not set at top level");
    endfunction

    virtual task run_phase(uvm_phase phase);
        super.run_phase(phase);
        forever begin
            seq_item_port.get_next_item(item);
            drive();
            `uvm_info(get_type_name(), $sformatf(
                "Driver: signals driven to the DUT are: rstL= %0d, scanMode= %0d, validIn= %0d, ap= %0d, csrRenIn= %0d, csrRdataIn= %0h, aIn= %0h, bIn= %0h, opcode= %0h",
                item.rstL, item.scanMode, item.validIn, item.ap, item.csrRenIn,
                item.csrRdataIn, item.aIn, item.bIn, item.opcode), UVM_HIGH);
            seq_item_port.item_done();
        end
    endtask

endclass: BmuDriver