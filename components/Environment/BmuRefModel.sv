class BmuRefModel extends uvm_component;
    uvm_analysis_export #(BmuSequenceItem) in_export;
    uvm_analysis_port #(BmuSequenceItem) exp_port;

    function new(string name = "BmuRefModel", uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        in_export = new("in_export", this);
        exp_port = new("exp_port", this);
    endfunction

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        in_export.connect(exp_port);
    endfunction

    function void write (BmuSequenceItem inItem);
        BmuSequenceItem refItem = BmuSequenceItem::type_id::create("item");
        refItem.copy(inItem);
        //Ref Model Stimulus Generation
        



    
        exp_port.write(item);
    endfunction

endclass: BmuRefModel