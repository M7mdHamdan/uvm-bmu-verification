interface BmuInterface(input logic clk);

    // Input signals
    logic rstL;
    logic scanMode;
    logic validIn;
    logic ap;  // Should be rtl_alu_pkt_t in actual implementation
    logic csrRenIn;
    logic [31:0] csrRdataIn;
    logic [31:0] aIn;
    logic [31:0] bIn;
    logic [31:0] opcode;
    
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
        output opcode;
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
        input opcode;
        input resultFf;
        input error;
    endclocking

    // Modports
    modport DRIVER_MOD (clocking DriverCb, input clk);
    modport MONITOR_MOD (clocking MonitorCb, input clk);

endinterface: BmuInterface
