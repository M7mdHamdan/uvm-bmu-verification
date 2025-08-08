class BmuSubscriber extends uvm_subscriber #(BmuSequenceItem);
    `uvm_component_utils(BmuSubscriber)
    
    covergroup bmu_cg;
        cp_operation: coverpoint m_item.operation {
            bins left_shift = {3'b000};
            bins right_shift = {3'b001};
            bins rotate_left = {3'b010};
            bins rotate_right = {3'b011};
            bins arith_right = {3'b100};
            bins bit_reverse = {3'b101};
            bins invalid = {[3'b110:3'b111]};
        }
        
        cp_shift_amount: coverpoint m_item.shift_amount {
            bins zero = {0};
            bins small = {[1:7]};
            bins medium = {[8:15]};
            bins large = {[16:31]};
        }
        
        cp_data_patterns: coverpoint m_item.data_in {
            bins all_zeros = {32'h00000000};
            bins all_ones = {32'hFFFFFFFF};
            bins alternating1 = {32'hAAAAAAAA};
            bins alternating2 = {32'h55555555};
            bins others = default;
        }
        
        cross_op_shift: cross cp_operation, cp_shift_amount;
    endgroup
    
    BmuSequenceItem m_item;
    
    function new(string name = "BmuSubscriber", uvm_component parent = null);
        super.new(name, parent);
        bmu_cg = new();
    endfunction
    
    function void write(BmuSequenceItem t);
        m_item = t;
        bmu_cg.sample();
        `uvm_info(get_type_name(), $sformatf("Coverage sample: Op=%0d, Shift=%0d", t.operation, t.shift_amount), UVM_HIGH)
    endfunction
    
    function void report_phase(uvm_phase phase);
        `uvm_info(get_type_name(), $sformatf("Coverage: %0.2f%%", bmu_cg.get_coverage()), UVM_LOW)
    endfunction
endclass
