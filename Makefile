# Simple BMU Makefile - Learning Step by Step

# Variables (like constants)
SIM_DIR = sim

# .PHONY means these targets don't create files
.PHONY: help clean run sim

# Default target (runs when you just type 'make')
help:
	@echo "=== BMU Makefile Help ==="
	@echo "Available commands:"
	@echo "  make help  - Show this help"
	@echo "  make run   - Run simulation (using script)"
	@echo "  make sim   - Run simulation directly"
	@echo "  make clean - Clean files"

# Run simulation using script
run:
	@echo "Running BMU simulation..."
	cd $(SIM_DIR) && ./run.sh

# Run simulation directly (no script needed)
sim:
	@echo "Running BMU simulation directly..."
	xrun -sv -uvm +incdir+rtl +incdir+rtl/library testbench/testbench.sv

# Clean files
clean:
	@echo "Cleaning simulation files..."
	rm -f $(SIM_DIR)/logs/*
	rm -rf $(SIM_DIR)/xcelium.d
