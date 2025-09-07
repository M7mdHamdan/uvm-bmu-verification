class BmuEnvironment extends uvm_env;
    BmuAgent agent;
    BmuScoreboard scoreboard;
    BmuSubscriber subscriber;
    BmuRefModel refModel;
    BmuChecker bmuChecker;
    `uvm_component_utils(BmuEnvironment)
    
    function new(string name = "BmuEnvironment", uvm_component parent = null);
        super.new(name, parent);
    endfunction
    
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        agent = BmuAgent::type_id::create("agent", this);
        scoreboard = BmuScoreboard::type_id::create("scoreboard", this);
        refModel = BmuRefModel::type_id::create("refModel", this);
        bmuChecker = BmuChecker::type_id::create("bmuChecker", this);
        subscriber = BmuSubscriber::type_id::create("subscriber", this);
    endfunction
    
    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        agent.monitor.monitorPort.connect(scoreboard.monitorAnalysisImp);
        scoreboard.refModelPort.connect(refModel.inExport);
        scoreboard.checkerActualPort.connect(bmuChecker.actualExport);
        refModel.refExpectedExport.connect(bmuChecker.expectedExport);
        agent.monitor.monitorPort.connect(subscriber.analysis_export);

    endfunction
endclass
