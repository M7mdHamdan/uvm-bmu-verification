# 	xrun -sv -uvm ../testbench/testbench.sv -incdir /home/Trainee3/BMU/package -incdir /home/Trainee3/BMU/rtl/library
run:
	rm -rf waves.shm 
	rm -rf xrun.log
	rm -rf xrun.history
	rm -rf xcelium.*
# 	xrun -sv -uvm ../testbench/testbench.sv +UVM_NO_RELNOTES +UVM_TESTNAME=AndTest
	xrun -sv -uvm ../testbench/testbench.sv +UVM_NO_RELNOTES \
	+UVM_TESTNAME=AndTest \
#  	-access +rwc -debug_opt verisium_interactive


chat:
	xrun -sv -uvm \
	-incdir /home/Trainee3/BMU/package \
	-incdir /home/Trainee3/BMU/rtl/library \
	-incdir /home/Trainee3/BMU/components \
	-incdir /home/Trainee3/BMU/components/interfaces \
	-incdir /home/Trainee3/BMU/tests \
	../testbench/testbench.sv \
	+UVM_NO_RELNOTES +UVM_TESTNAME=AndTest
clean:
	rm -rf waves.shm 
	rm -rf xrun.log
	rm -rf xrun.history
	rm -rf xcelium.*

# Run CPOP test
cpop:
	rm -rf waves.shm 
	rm -rf xrun.log
	rm -rf xrun.history
	rm -rf xcelium.*
	xrun -sv -uvm ../testbench/testbench.sv +UVM_NO_RELNOTES +UVM_TESTNAME=CpopTest \
	-access +rwc

# Run Arithmetic test
arith:
	rm -rf waves.shm 
	rm -rf xrun.log
	rm -rf xrun.history
	rm -rf xcelium.*
	xrun -sv -uvm ../testbench/testbench.sv +UVM_NO_RELNOTES +UVM_TESTNAME=ArithmeticTest \
	-access +rwc

# Run BEXT test
bext:
	rm -rf waves.shm 
	rm -rf xrun.log
	rm -rf xrun.history
	rm -rf xcelium.*
	xrun -sv -uvm ../testbench/testbench.sv +UVM_NO_RELNOTES +UVM_TESTNAME=BextTest \
	-access +rwc

# Run SH3ADD test (Zba extension)
sh3add:
	rm -rf waves.shm 
	rm -rf xrun.log
	rm -rf xrun.history
	rm -rf xcelium.*
	xrun -sv -uvm ../testbench/testbench.sv +UVM_NO_RELNOTES +UVM_TESTNAME=Sh3addTest \
	-access +rwc

# Run ROL test (Zbp extension)
rol:
	rm -rf waves.shm 
	rm -rf xrun.log
	rm -rf xrun.history
	rm -rf xcelium.*
	xrun -sv -uvm ../testbench/testbench.sv +UVM_NO_RELNOTES +UVM_TESTNAME=RolTest \
	-access +rwc

# Run PACKU test (Zbp extension)
packu:
	rm -rf waves.shm 
	rm -rf xrun.log
	rm -rf xrun.history
	rm -rf xcelium.*
	xrun -sv -uvm ../testbench/testbench.sv +UVM_NO_RELNOTES +UVM_TESTNAME=PackuTest \
	-access +rwc

# Run GORC test (Zbp extension)
gorc:
	rm -rf waves.shm 
	rm -rf xrun.log
	rm -rf xrun.history
	rm -rf xcelium.*
	xrun -sv -uvm ../testbench/testbench.sv +UVM_NO_RELNOTES +UVM_TESTNAME=GorcTest \
	-access +rwc

# Run SLL test (Zbp extension)
sll:
	rm -rf waves.shm 
	rm -rf xrun.log
	rm -rf xrun.history
	rm -rf xcelium.*
	xrun -sv -uvm ../testbench/testbench.sv +UVM_NO_RELNOTES +UVM_TESTNAME=SllTest \
	-access +rwc

# Run SRA test (Zbp extension)
sra:
	rm -rf waves.shm 
	rm -rf xrun.log
	rm -rf xrun.history
	rm -rf xcelium.*
	xrun -sv -uvm ../testbench/testbench.sv +UVM_NO_RELNOTES +UVM_TESTNAME=SraTest \
	-access +rwc

# Run SLT test (Zbb extension)
slt:
	rm -rf waves.shm 
	rm -rf xrun.log
	rm -rf xrun.history
	rm -rf xcelium.*
	xrun -sv -uvm ../testbench/testbench.sv +UVM_NO_RELNOTES +UVM_TESTNAME=SltTest \
	-access +rwc

# Run XOR test (Zbb extension)
xor:
	rm -rf waves.shm 
	rm -rf xrun.log
	rm -rf xrun.history
	rm -rf xcelium.*
	xrun -sv -uvm ../testbench/testbench.sv +UVM_NO_RELNOTES +UVM_TESTNAME=XorTest \
	-access +rwc

# Run CLZ test (Zbb extension)
clz:
	rm -rf waves.shm 
	rm -rf xrun.log
	rm -rf xrun.history
	rm -rf xcelium.*
	xrun -sv -uvm ../testbench/testbench.sv +UVM_NO_RELNOTES +UVM_TESTNAME=ClzTest \
	-access +rwc

# Run SUB test (Zbb extension)
sub:
	rm -rf waves.shm 
	rm -rf xrun.log
	rm -rf xrun.history
	rm -rf xcelium.*
	xrun -sv -uvm ../testbench/testbench.sv +UVM_NO_RELNOTES +UVM_TESTNAME=SubTest \
	-access +rwc

# Run MIN test (Zbb extension)
min:
	rm -rf waves.shm 
	rm -rf xrun.log
	rm -rf xrun.history
	rm -rf xcelium.*
	xrun -sv -uvm ../testbench/testbench.sv +UVM_NO_RELNOTES +UVM_TESTNAME=MinTest \
	-access +rwc

# Run SIEXT_H test (Zbs extension)
siext_h:
	rm -rf waves.shm 
	rm -rf xrun.log
	rm -rf xrun.history
	rm -rf xcelium.*
	xrun -sv -uvm ../testbench/testbench.sv +UVM_NO_RELNOTES +UVM_TESTNAME=SiextHTest \
	-access +rwc

# Run CSR test (Control and Status Register)
csr:
	rm -rf waves.shm 
	rm -rf xrun.log
	rm -rf xrun.history
	rm -rf xcelium.*
	xrun -sv -uvm ../testbench/testbench.sv +UVM_NO_RELNOTES +UVM_TESTNAME=CsrTest \
	-access +rwc

