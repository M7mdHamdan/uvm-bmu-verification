class BmuEnvironment extends uvm_env;
    BmuAgent agent;
    BmuScoreboard scoreboard;
    BmuSubscriber subscriber;
    
    `uvm_component_utils(BmuEnvironment)
    
    function new(string name = "BmuEnvironment", uvm_component parent = null);
        super.new(name, parent);
    endfunction
    
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        agent = BmuAgent::type_id::create("agent", this);
        scoreboard = BmuScoreboard::type_id::create("scoreboard", this);
        subscriber = BmuSubscriber::type_id::create("subscriber", this);
    endfunction
    
    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        agent.monitor.ap.connect(scoreboard.ap_imp);
        agent.monitor.ap.connect(subscriber.analysis_export);
    endfunction
endclass
