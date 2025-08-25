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
    endfunction

    function void write (BmuSequenceItem inItem);
        BmuSequenceItem refItem = BmuSequenceItem::type_id::create("item");
        refItem.copy(inItem);
        //Ref Model Stimulus Generation
        case ($countones(refItem.ap))
        refItem.error = 0;
        0: begin
            // Generate stimulus for case 0

                //CSR Operations
                //Ex1
                if(refItem.csrRenIn == 1) begin
                    refItem.resultFf = refItem.csrRdataIn;
                end
                

            end
            1: begin
                // Generate stimulus for case 1
                //AND Operations
                //Ex2
                if (refItem.ap.land == 1 && refItem.csrRenIn == 0) begin
                    refItem.resultFf = refItem.aIn & refItem.bIn;
                end
                //XOR Operations
                //Ex3
                if (refItem.ap.lxor == 1 && refItem.csrRenIn == 0) begin
                    refItem.resultFf = refItem.aIn ^ refItem.bIn;
                end
                //SHIFTING Operations
                //Shift Left
                //Ex5
                if (refItem.ap.sll == 1 && refItem.csrRenIn == 0) begin
                    refItem.resultFf = refItem.aIn << refItem.bIn[4:0];
                end
                //Shift Right
                //Ex6
                if (refItem.ap.sra == 1&& refItem.csrRenIn == 0) begin
                    refItem.resultFf = refItem.aIn >> refItem.bIn[4:0];
                end
                //Rotate Left
                //Ex7
                if (refItem.ap.rol == 1&& refItem.csrRenIn == 0) begin
                    refItem.resultFf = (refItem.aIn << refItem.bIn[4:0]) | (refItem.aIn >> (32 - refItem.bIn[4:0]));
                end
                //Ex8
                if (refItem.ap.bext )

            end

            2: begin
                // Generate stimulus for case 2
                //XOR Operations
                //Ex4
                if (refItem.ap.lxor == 1 && refItem.csrRenIn == 0 && refItem.ap.zbb) begin
                    refItem.resultFf = refItem.aIn ^ ~refItem.bIn;
                end
            end
            default: begin
                refItem.error = 1;
                // Generate stimulus for default case
            end[]
        endcase
        



    
        exp_port.write(refItem);
    endfunction

endclass: BmuRefModel