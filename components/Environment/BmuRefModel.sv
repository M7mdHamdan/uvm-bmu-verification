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
                //Initial phase -- Read
                if(refItem.csrRenIn == 1 && refItem.ap.csr_write == 0) begin
                        refItem.resultFf = refItem.csrRdataIn;
                    end

            end
            1: begin
                // Generate stimulus for case 1
                // All operations in case 1 require csrRenIn == 0
                assert (refItem.csrRenIn == 0)
                    else begin
                        `uvm_error("BMU_REF_MODEL", "csrRenIn must be 0 for all operations in case 1")
                        refItem.error = 1;
                        refItem.resultFf = 0;
                    end
                //AND Operations
                //Ex2
                if (refItem.ap.land == 1) begin
                    refItem.resultFf = refItem.aIn & refItem.bIn;
                end
                //XOR Operations
                //Ex3
                if (refItem.ap.lxor == 1) begin
                    refItem.resultFf = refItem.aIn ^ refItem.bIn;
                end
                //SHIFTING Operations
                //Shift Left
                //Ex5
                if (refItem.ap.sll == 1) begin
                    refItem.resultFf = refItem.aIn << refItem.bIn[4:0];
                end
                //Shift Right
                //Ex6
                if (refItem.ap.sra == 1) begin
                    refItem.resultFf = refItem.aIn >> refItem.bIn[4:0];
                end
                //Shift Right arithmetic BONUS
                if (refItem.ap.srl == 1) begin
                    refItem.resultFf = $unsigned(refItem.aIn) >> refItem.bIn[4:0];
                end
                //Rotate Left
                //Ex7
                if (refItem.ap.rol == 1) begin
                    refItem.resultFf = (refItem.aIn << refItem.bIn[4:0]) | (refItem.aIn >> (32 - refItem.bIn[4:0]));
                end
                //Rotate Right BONUS
                if (refItem.ap.ror == 1) begin
                    refItem.resultFf = (refItem.aIn >> refItem.bIn[4:0]) | (refItem.aIn << (32 - refItem.bIn[4:0]));
                end
                //Ex8 Extract one bit 
                if (refItem.ap.bext == 1) begin
                    refItem.resultFf = refItem.aIn[refItem.bIn[4:0]];
                end

                //Arithmetic Operations
                //Ex 10
                if (refItem.ap.add == 1) begin
                    refItem.resultFf = refItem.aIn + refItem.bIn;
                end
                if (refItem.ap.sub == 1) begin
                    refItem.resultFf = refItem.aIn - refItem.bIn;
                end

                //Ex 12 CLZ
                if (refItem.ap.clz == 1) begin
                    refItem.resultFf = $count_zeros(refItem.aIn);
                end
                //Ex 13 CPOP
                if (refItem.ap.cpop == 1) begin
                    refItem.resultFf = $countones(refItem.aIn);
                end
                //Ex 14 SIGNED EXTENSION 16 bit
                if (refItem.ap.siext_h == 1) begin
                    refItem.resultFf = {{16{refItem.aIn[15]}}, refItem.aIn[15:0]};
                end
                //Ex 15 Skipped Min


                //Ex 16 PACKU
                if (refItem.ap.packu == 1) begin
                    refItem.resultFf = {refItem.bIn[31:16], refItem.aIn[31:16]};
                end
                //Ex 17 GORC
                if (refItem.ap.gorc == 1 && refItem.bIn[4:0] == 5'b00111) begin
                    refItem.resultFf = {|(refItem.aIn[31:24] ? 8'hFF : 8'h00),
                                        |(refItem.aIn[23:16] ? 8'hFF : 8'h00),
                                        |(refItem.aIn[15:8] ? 8'hFF : 8'h00),
                                        |(refItem.aIn[7:0] ? 8'hFF : 8'h00)};
                end
            end

            2: begin
                // Generate stimulus for case 2
                assert (refItem.csrRenIn == 0)
                    else begin
                        `uvm_error("BMU_REF_MODEL", "csrRenIn must be 0 for all operations in case 2")
                        refItem.error = 1;
                        refItem.resultFf = 0;
                    end
                //Secondary non-Initial CSR phase Write (EX1)
                if(refItem.ap.csr_write == 1 && refItem.ap.csr_imm == 1) begin
                        refItem.resultFf = refItem.bIn;
                end
                else if(refItem.ap.csr_write == 1 && refItem.ap.csr_imm == 0) begin
                    refItem.resultFf = refItem.aIn;
                end


                //AND Operations
                //Ex2 INVERSION
                if (refItem.ap.land == 1 && refItem.ap.zbb == 1) begin
                    refItem.resultFf = refItem.aIn & ~refItem.bIn;
                end

                //XOR Operations
                //Ex4
                if (refItem.ap.lxor == 1 && refItem.ap.zbb) begin
                    refItem.resultFf = refItem.aIn ^ ~refItem.bIn;
                end
                
                //SH3ADD
                //Ex 9
                if (refItem.ap.sh3add == 1 && refItem.ap.zba == 1) begin
                    refItem.resultFf = (refItem.aIn << 3) + refItem.bIn;
                end
                //Ex 11
                if (refItem.ap.slt == 1 && refItem.ap.sub == 1) begin
                    refItem.resultFf = ($signed(refItem.aIn) < $signed(refItem.bIn)) ? 1 : 0;
                end
            end
            3: begin
                // Generate stimulus for case 3
                //SET LESS THAN SLT
                //Ex 11
                if (refItem.ap.slt == 1 && refItem.ap.sub == 1 && refItem.ap.unsign == 1) begin
                    refItem.resultFf = ($unsigned(refItem.aIn) < $unsigned(refItem.bIn)) ? 1 : 0;
                end
            end
            default: begin
                refItem.error = 1;
                refItem.resultFf = 0;
                // Generate stimulus for default case
            end
        endcase
        



    
        exp_port.write(refItem);
    endfunction

endclass: BmuRefModel
    
        exp_port.write(refItem);
    endfunction

endclass: BmuRefModel
