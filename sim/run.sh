#!/bin/bash

# BMU Simulation Script
# Organizes all simulation files and runs the testbench

echo "Starting BMU Simulation..."

# Create simulation directory structure
mkdir -p sim/waves.shm
mkdir -p sim/logs
# Don't remove history
# # Clean up previous run
# rm -rf sim/xcelium.d
# rm -f sim/xrun.log
# rm -f sim/xrun.history

# Run xrun with proper paths and file organization (from project root)
xrun -sv -uvm testbench/testbench.sv

echo "Simulation complete. Check sim/logs/ for results."
echo "Wave files are in sim/waves/"
