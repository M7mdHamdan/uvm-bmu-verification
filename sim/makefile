# 	xrun -sv -uvm ../testbench/testbench.sv -incdir /home/Trainee3/BMU/package -incdir /home/Trainee3/BMU/rtl/library
run:
	xrun -sv -uvm ../testbench/testbench.sv +UVM_NO_RELNOTES +UVM_TESTNAME=AndTest

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
