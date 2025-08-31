`include "/home/Trainee3/BMU/package/BmuDef.sv"
interface BmuInterface(input logic clk);
    itemKind kind; // To distinguish between actual and expected items
    // Input signals
    logic rstL;
    logic scanMode;
    logic validIn;
    typedef struct packed {
                    logic clz;  // done
                    logic ctz;  // done
                    logic cpop;
                    logic siext_b;
                    logic siext_h;
                    logic min;
                    logic max;
                    logic pack;
                    logic packu;
                    logic packh;
                    logic rol; // done
                    logic ror; // done
                    logic grev;
                    logic gorc;
                    logic zbb;
                    logic bset;
                    logic bclr;
                    logic binv;
                    logic bext;
                    logic sh1add; // done
                    logic sh2add; // done
                    logic sh3add; // done
                    logic zba; // done
                    logic land; // done
                    logic lor; // done
                    logic lxor; // done
                    logic sll; // done
                    logic srl; // done
                    logic sra; // done
                    logic beq;
                    logic bne;
                    logic blt;
                    logic bge;
                    logic add;    // done
                    logic sub;    // done
                    logic slt;    // done
                    logic unsign; // done
                    logic jal;
                    logic predict_t;
                    logic predict_nt;
                    logic csr_write;
                    logic csr_imm;
                    } rtl_alu_pkt_t;
    rtl_alu_pkt_t ap;

    logic csrRenIn;
    logic [31:0] csrRdataIn;
    logic [31:0] aIn;
    logic [31:0] bIn;
    
    // Output signals
    logic [31:0] resultFf;
    logic error;

    clocking DriverCb @ (negedge clk);
        default input #1 output #0;
        output rstL;
        output scanMode;
        output validIn;
        output ap;
        output csrRenIn;
        output csrRdataIn;
        output aIn;
        output bIn;
    endclocking

    clocking MonitorCb @ (posedge clk);
        default input #0 output #1;
        input rstL;
        input scanMode;
        input validIn;
        input ap;
        input csrRenIn;
        input csrRdataIn;
        input aIn;
        input bIn;
        input resultFf;
        input error;
    endclocking

    // Modports
    modport DRIVER_MOD (clocking DriverCb, input clk);
    modport MONITOR_MOD (clocking MonitorCb, input clk);

endinterface: BmuInterface
