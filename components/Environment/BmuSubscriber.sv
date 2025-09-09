class BmuSubscriber extends uvm_subscriber #(BmuSequenceItem);
    `uvm_component_utils(BmuSubscriber)
    
    // Coverage groups for the 5 main RISC-V extensions only
    
    // Zbb Extension Coverage
    covergroup cg_zbb_operations;
        option.per_instance = 1;
        option.name = "zbb_operations_cg";
        
        cp_clz: coverpoint transaction.ap.clz {
            bins clz_active = {1};
            bins clz_inactive = {0};
        }
        
        cp_cpop: coverpoint transaction.ap.cpop {
            bins cpop_active = {1};
            bins cpop_inactive = {0};
        }
        
        cp_min: coverpoint transaction.ap.min {
            bins min_active = {1};
            bins min_inactive = {0};
        }
        
        cp_land: coverpoint transaction.ap.land {
            bins and_active = {1};
            bins and_inactive = {0};
        }
        
        cp_lxor: coverpoint transaction.ap.lxor {
            bins xor_active = {1};
            bins xor_inactive = {0};
        }
        
        cp_add: coverpoint transaction.ap.add {
            bins add_active = {1};
            bins add_inactive = {0};
        }
        
        cp_sub: coverpoint transaction.ap.sub {
            bins sub_active = {1};
            bins sub_inactive = {0};
        }
        
        cp_slt: coverpoint transaction.ap.slt {
            bins slt_active = {1};
            bins slt_inactive = {0};
        }
        
        // Cross coverage for actual Zbb operations only
        cross_zbb_logical: cross cp_land, cp_lxor;
        cross_zbb_arith: cross cp_add, cp_sub, cp_slt;
        cross_zbb_bit_ops: cross cp_clz, cp_cpop, cp_min;
    endgroup
    
    // Zbs Extension Coverage
    covergroup cg_zbs_operations;
        option.per_instance = 1;
        option.name = "zbs_operations_cg";
        
        cp_bext: coverpoint transaction.ap.bext {
            bins bext_active = {1};
            bins bext_inactive = {0};
        }
        
        cp_siext_h: coverpoint transaction.ap.siext_h {
            bins siext_h_active = {1};
            bins siext_h_inactive = {0};
        }
        
        // Cross coverage for actual operations only
        cross_zbs_ops: cross cp_bext, cp_siext_h;
    endgroup
    
    // Zba Extension Coverage
    covergroup cg_zba_operations;
        option.per_instance = 1;
        option.name = "zba_operations_cg";
        
        cp_sh3add: coverpoint transaction.ap.sh3add {
            bins sh3add_active = {1};
            bins sh3add_inactive = {0};
        }
    endgroup
    
    // Zbp Extension Coverage
    covergroup cg_zbp_operations;
        option.per_instance = 1;
        option.name = "zbp_operations_cg";
        
        cp_rol: coverpoint transaction.ap.rol {
            bins rol_active = {1};
            bins rol_inactive = {0};
        }
        
        cp_packu: coverpoint transaction.ap.packu {
            bins packu_active = {1};
            bins packu_inactive = {0};
        }
        
        cp_gorc: coverpoint transaction.ap.gorc {
            bins gorc_active = {1};
            bins gorc_inactive = {0};
        }
        
        cp_sll: coverpoint transaction.ap.sll {
            bins sll_active = {1};
            bins sll_inactive = {0};
        }
        
        cp_sra: coverpoint transaction.ap.sra {
            bins sra_active = {1};
            bins sra_inactive = {0};
        }
        
        // Cross coverage for actual operations only
        cross_zbp_ops: cross cp_rol, cp_packu, cp_gorc;
        cross_zbp_shifts: cross cp_sll, cp_sra;
    endgroup
    
    // CSR Operations Coverage
    covergroup cg_csr_operations;
        option.per_instance = 1;
        option.name = "csr_operations_cg";
        
        cp_csr_write: coverpoint transaction.ap.csr_write {
            bins csr_write_active = {1};
            bins csr_write_inactive = {0};
        }
        
        cp_csr_imm: coverpoint transaction.ap.csr_imm {
            bins csr_imm_active = {1};
            bins csr_imm_inactive = {0};
        }
        
        cp_csr_ren: coverpoint transaction.csrRenIn {
            bins csr_read_enable = {1};
            bins csr_read_disable = {0};
        }
        
        cp_csr_data: coverpoint transaction.csrRdataIn {
            bins zero = {32'h00000000};
            bins all_ones = {32'hFFFFFFFF};
            bins test_patterns[] = {32'hABCD1234, 32'hDEADBEEF, 32'h12345678, 32'h87654321};
            bins others = default;
        }
        
        // Cross coverage for CSR operations
        cross_csr_ops: cross cp_csr_write, cp_csr_imm, cp_csr_ren;
    endgroup
    
    // Transaction reference for coverage groups
    BmuSequenceItem transaction;
    
    // Coverage statistics
    int total_transactions;
    
    // Constructor
    function new(string name = "BmuSubscriber", uvm_component parent);
        super.new(name, parent);
        
        // Initialize coverage groups - only the 5 main extensions
        cg_zbb_operations = new();
        cg_zbs_operations = new();
        cg_zba_operations = new();
        cg_zbp_operations = new();
        cg_csr_operations = new();
        
        // Initialize statistics
        total_transactions = 0;
    endfunction
    
    // Build phase
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        `uvm_info("BMU_SUBSCRIBER", "Building BMU functional coverage subscriber - 5 Extensions Only", UVM_MEDIUM)
    endfunction
    
    // Write function called when transaction is received
    function void write(BmuSequenceItem t);
        `uvm_info("BMU_SUBSCRIBER", "Received transaction for coverage collection", UVM_HIGH)
        
        // Store transaction reference for coverage groups
        transaction = t;
        total_transactions++;
        
        // Sample only the 5 main extension coverage groups
        cg_zbb_operations.sample();
        cg_zbs_operations.sample();
        cg_zba_operations.sample();
        cg_zbp_operations.sample();
        cg_csr_operations.sample();
        
        // Log coverage progress periodically
        if (total_transactions % 50 == 0) begin
            `uvm_info("BMU_SUBSCRIBER", 
                     $sformatf("Coverage progress: %0d transactions processed", total_transactions), 
                     UVM_MEDIUM)
        end
    endfunction
    
    // Report coverage statistics - only the 5 extensions
    function void report_phase(uvm_phase phase);
        real zbb_cov, zbs_cov, zba_cov, zbp_cov, csr_cov, overall_cov;
        string border_line;
        
        super.report_phase(phase);
        
        // Get coverage percentages for the 5 main extensions
        zbb_cov = cg_zbb_operations.get_coverage();
        zbs_cov = cg_zbs_operations.get_coverage();
        zba_cov = cg_zba_operations.get_coverage();
        zbp_cov = cg_zbp_operations.get_coverage();
        csr_cov = cg_csr_operations.get_coverage();
        
        // Calculate overall coverage (average of 5 extensions)
        overall_cov = (zbb_cov + zbs_cov + zba_cov + zbp_cov + csr_cov) / 5.0;
        
        border_line = "\n+======================================================+\n";
        
        `uvm_info("BMU_SUBSCRIBER", $sformatf("%s|          RISC-V EXTENSIONS COVERAGE REPORT            |\n|                                                      |\n| Total Transactions Processed: %-10d             |\n|                                                      |\n| RISC-V Extension Coverage:                           |\n| Zbb Extension                     : %6.2f%%          |\n| Zbs Extension                     : %6.2f%%          |\n| Zba Extension                     : %6.2f%%          |\n| Zbp Extension                     : %6.2f%%          |\n| CSR Operations                    : %6.2f%%          |\n|                                                      |\n| OVERALL FUNCTIONAL COVERAGE       : %6.2f%%          |%s",
            border_line,
            total_transactions,
            zbb_cov, zbs_cov, zba_cov, zbp_cov, csr_cov,
            overall_cov,
            border_line), UVM_LOW)
        
        // Report coverage status
        if (overall_cov >= 80.0) begin
            `uvm_info("BMU_SUBSCRIBER", 
                     $sformatf("EXCELLENT! Coverage target achieved: %.2f%%", overall_cov), 
                     UVM_LOW)
        end else begin
            `uvm_warning("BMU_SUBSCRIBER", 
                        $sformatf("Coverage target not reached: %.2f%% (Target: 80%%)", overall_cov))
        end
        
        // Report individual low coverage areas
        if (zbb_cov < 80.0) `uvm_info("BMU_SUBSCRIBER", "Need more Zbb extension tests", UVM_MEDIUM);
        if (zbs_cov < 80.0) `uvm_info("BMU_SUBSCRIBER", "Need more Zbs extension tests", UVM_MEDIUM);
        if (zba_cov < 80.0) `uvm_info("BMU_SUBSCRIBER", "Need more Zba extension tests", UVM_MEDIUM);
        if (zbp_cov < 80.0) `uvm_info("BMU_SUBSCRIBER", "Need more Zbp extension tests", UVM_MEDIUM);
        if (csr_cov < 80.0) `uvm_info("BMU_SUBSCRIBER", "Need more CSR tests", UVM_MEDIUM);
    endfunction

endclass: BmuSubscriber
