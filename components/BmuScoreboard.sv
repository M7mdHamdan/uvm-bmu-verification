class BmuScoreboard extends uvm_scoreboard;
    uvm_analysis_imp #(BmuSequenceItem, BmuScoreboard) ap_imp;
    int pass_count = 0;
    int fail_count = 0;
    
    `uvm_component_utils(BmuScoreboard)
    
    function new(string name = "BmuScoreboard", uvm_component parent = null);
        super.new(name, parent);
        ap_imp = new("ap_imp", this);
    endfunction
    
    function void write(BmuSequenceItem item);
        logic [31:0] expected_out;
        logic expected_overflow, expected_underflow, expected_error;
        
        // Calculate expected results based on operation
        case (item.operation)
            3'b000: begin // Left shift
                expected_out = item.data_in << item.shift_amount;
                expected_overflow = (item.shift_amount > 0) && (item.data_in[31-:item.shift_amount] != 0);
                expected_underflow = 1'b0;
                expected_error = 1'b0;
            end
            3'b001: begin // Right shift
                expected_out = item.data_in >> item.shift_amount;
                expected_overflow = 1'b0;
                expected_underflow = (item.shift_amount > 0) && (item.data_in[item.shift_amount-1:0] != 0);
                expected_error = 1'b0;
            end
            3'b010: begin // Rotate left
                expected_out = (item.data_in << item.shift_amount) | (item.data_in >> (32 - item.shift_amount));
                expected_overflow = 1'b0;
                expected_underflow = 1'b0;
                expected_error = 1'b0;
            end
            3'b011: begin // Rotate right
                expected_out = (item.data_in >> item.shift_amount) | (item.data_in << (32 - item.shift_amount));
                expected_overflow = 1'b0;
                expected_underflow = 1'b0;
                expected_error = 1'b0;
            end
            3'b100: begin // Arithmetic right shift
                expected_out = $signed(item.data_in) >>> item.shift_amount;
                expected_overflow = 1'b0;
                expected_underflow = 1'b0;
                expected_error = 1'b0;
            end
            3'b101: begin // Bit reversal
                for (int i = 0; i < 32; i++) begin
                    expected_out[i] = item.data_in[31-i];
                end
                expected_overflow = 1'b0;
                expected_underflow = 1'b0;
                expected_error = 1'b0;
            end
            default: begin
                expected_out = 32'h0;
                expected_overflow = 1'b0;
                expected_underflow = 1'b0;
                expected_error = 1'b1;
            end
        endcase
        
        // Compare results
        if (item.data_out == expected_out && 
            item.overflow == expected_overflow &&
            item.underflow == expected_underflow &&
            item.error == expected_error) begin
            pass_count++;
            `uvm_info(get_type_name(), $sformatf("PASS: Expected=0x%0h, Actual=0x%0h", expected_out, item.data_out), UVM_LOW)
        end else begin
            fail_count++;
            `uvm_error(get_type_name(), $sformatf("FAIL: Expected=0x%0h, Actual=0x%0h, Op=%0d", expected_out, item.data_out, item.operation))
        end
    endfunction
    
    function void report_phase(uvm_phase phase);
        `uvm_info(get_type_name(), $sformatf("Scoreboard Results: PASS=%0d, FAIL=%0d", pass_count, fail_count), UVM_LOW)
    endfunction
endclass
