# RISC-V Bit Manipulation Unit (BMU) Verification Environment

## Overview

This project implements a comprehensive SystemVerilog UVM-based verification environment for a RISC-V Bit Manipulation Unit (BMU). The BMU supports multiple RISC-V bit manipulation extensions and provides hardware acceleration for common bit manipulation operations.

## Supported Extensions

- **Zba**: Address generation instructions (SH3ADD)
- **Zbb**: Basic bit manipulation (AND, XOR, MIN, SUB, CLZ, CPOP, SLT)
- **Zbp**: Permutation operations (ROL, PACKU, GORC, SLL, SRA)
- **Zbs**: Single-bit operations (BEXT, SIEXT_H)
- **CSR**: Control and Status Register operations (Read, Write)

## Directory Structure

```text
BMU/
├── components/          # UVM components
│   ├── Agent/          # Driver, Monitor, Sequencer
│   ├── Environment/    # Testbench environment components
│   └── interfaces/     # System interfaces
├── package/            # Package definitions and includes
├── rtl/               # Design Under Test (DUT)
│   └── library/       # RTL source files
├── sequences/         # Test sequences organized by extension
│   ├── CSR/          # Control Status Register sequences
│   ├── Zba/          # Address generation sequences
│   ├── Zbb/          # Basic bit manipulation sequences
│   ├── Zbp/          # Permutation sequences
│   └── Zbs/          # Single-bit sequences
├── sim/              # Simulation files and makefile
├── testbench/        # Top-level testbench
└── tests/            # Test classes organized by extension
```

## Quick Start

### Prerequisites

- Cadence Xcelium simulator
- SystemVerilog and UVM support
- Linux environment with bash shell

### Running Tests

Navigate to the simulation directory:

```bash
cd sim/
```

#### Run Individual Extension Tests

**Zbb Extension (Basic Bit Manipulation):**

```bash
make and     # Bitwise AND operation
make xor     # Bitwise XOR operation
make min     # Minimum value selection
make sub     # Subtraction operation
make clz     # Count Leading Zeros
make cpop    # Count Population (set bits)
make slt     # Set Less Than comparison
```

**Zba Extension (Address Generation):**

```bash
make sh3add  # Shift left 3 and add
```

**Zbs Extension (Single-bit Operations):**

```bash
make bext     # Bit extract
make siext_h  # Sign extend halfword
```

**Zbp Extension (Permutation):**

```bash
make rol     # Rotate left
make packu   # Pack upper bits
make gorc    # Generalized reverse complement
make sll     # Shift left logical
make sra     # Shift right arithmetic
```

**CSR Operations:**

```bash
make csr     # Control Status Register tests
```

#### Utility Commands

```bash
make clean   # Remove simulation files
make run     # Run default test configuration
```

## Test Coverage

Each extension includes comprehensive test scenarios:

- **Basic functionality tests**: Core operation validation
- **Edge case testing**: Boundary conditions and special values
- **Random stimulus**: Pseudo-random input generation
- **Error condition testing**: Invalid operations and error handling

## Key Features

### Verification Components

- **UVM Testbench**: Complete UVM-based verification environment
- **Reference Model**: Golden reference for result comparison
- **Scoreboard**: Automatic result checking and reporting
- **Coverage**: Functional coverage collection for all operations

### Test Sequences

- **Directed Tests**: Specific test cases for each instruction
- **Random Tests**: Constrained random stimulus generation
- **CSR Tests**: Register access and configuration testing
- **Error Injection**: Fault condition testing

## Usage Examples

### Running a Basic Test

```bash
# Run XOR operation test
make xor
```

### Running Multiple Tests

```bash
# Run all Zbb extension tests
make and && make xor && make min && make sub
```

### Viewing Results

Test results are displayed in the terminal and logged to `xrun.log`. Look for:

- `UVM_INFO` messages for test progress
- `PASS/FAIL` status for individual test cases
- Final test summary with overall results

## Project Structure Details

### Components

- **BmuAgent**: Complete UVM agent with driver, monitor, and sequencer
- **BmuEnvironment**: Top-level verification environment
- **BmuScoreboard**: Result checking and reporting
- **BmuRefModel**: Reference model for expected results

### Test Organization

- Tests are organized by RISC-V extension for easy maintenance
- Each test includes multiple scenarios and edge cases
- Sequences provide reusable stimulus patterns

## Troubleshooting

### Common Issues

1. **Compilation Errors**: Ensure all include paths are correct in makefile
2. **Missing Files**: Check that all sequence files are properly included in package
3. **Simulation Hangs**: Verify testbench timeout settings

### Log Files

- `xrun.log`: Complete simulation log with all messages
- `waves.shm/`: Waveform database for debugging (if enabled)

## Development Notes

This verification environment was designed for educational purposes and follows industry-standard UVM methodology. The implementation covers all major bit manipulation operations and provides a solid foundation for RISC-V processor verification.

---

**Note**: This project uses Cadence Xcelium for simulation. Ensure proper tool licensing and environment setup before running tests.
