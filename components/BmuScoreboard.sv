class BmuScoreboard extends uvm_scoreboard;

    `uvm_component_utils(BmuScoreboard)

    function new(string name = "BmuScoreboard", uvm_component parent);
        super.new(name, parent);
    endfunction
    // TODO check scoreboard in UVM n do so

endclass