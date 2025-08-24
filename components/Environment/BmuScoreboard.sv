class BmuScoreboard extends uvm_scoreboard;
    `uvm_component_utils(BmuScoreboard)

    virtual BmuInterface vif;
    BmuSequenceItem actItem;
    BmuSequenceItem expItem;
    uvm_analysis_imp #(BmuSequenceItem, BmuScoreboard) analysis_imp;
    BmuSequenceItem itemQueue [$];

    // Constructor
    function new(string name, uvm_component parent);
        super.new(name, parent);
        analysis_imp = BmuSequenceItem::type_id::create("analysis_imp", this);
    endfunction

    // Build phase
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if (!uvm_config_db#(virtual BmuInterface)::get(this, "", "vif", vif))
            `uvm_fatal(get_type_name(), "Virtual interface not set at top level");
    endfunction

    function void write(BmuSequenceItem item);
        itemQueue.push_back(item);
    endfunction

    function void bmuExpectedInit (BmuSequenceItem item);
        // TODO FILL IN:
    endfunction

    function bit isEqual(BmuSequenceItem expItem, BmuSequenceItem actItem);
        if(expItem.rstL === actItem.rstL &&
           expItem.scanMode === actItem.scanMode &&
           expItem.validIn === actItem.validIn &&
           expItem.ap === actItem.ap &&
           expItem.csrRenIn === actItem.csrRenIn &&
           expItem.csrRdataIn === actItem.csrRdataIn &&
           expItem.aIn === actItem.aIn &&
           expItem.bIn === actItem.bIn &&
           expItem.opcode === actItem.opcode) begin
            return 1;
        end
        return 0;
    endfunction



    task run_phase(uvm_phase phase);
        forever begin
            if (itemQueue.size() > 0) begin
                actItem = itemQueue.pop_front();
                expItem = BmuSequenceItem::type_id::create("expItem", this);
                bmuExpectedInit(expItem);
                if (isEqual(expItem, actItem)) begin
                    // TODO FILL IN: Handle the case where the items match
                end
                else begin
                    // TODO FILL IN: Handle the case where the items do not match
                    `uvm_error(get_type_name(), $sformatf("Mismatch: Expected %p, Actual %p", expItem, actItem));
                end

                analysis_imp.write(actItem);
        end
    endtask
endclass: BmuScoreboard