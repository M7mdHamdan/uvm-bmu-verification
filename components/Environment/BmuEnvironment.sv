class BmuEnvironment extends uvm_env;
    BmuAgent agent;
    // Temporarily commented out until these components are fixed
    // BmuScoreboard scoreboard;
    // BmuSubscriber subscriber;
    
    `uvm_component_utils(BmuEnvironment)
    
    function new(string name = "BmuEnvironment", uvm_component parent = null);
        super.new(name, parent);
    endfunction
    
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        agent = BmuAgent::type_id::create("agent", this);
        // scoreboard = BmuScoreboard::type_id::create("scoreboard", this);
        // subscriber = BmuSubscriber::type_id::create("subscriber", this);
    endfunction
    
    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        // Connections will be added when components are ready
        // agent.monitor.monitorPort.connect(scoreboard.monitorAnalysisImp);
    endfunction
endclass
