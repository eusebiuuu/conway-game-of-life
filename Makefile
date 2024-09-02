compile_task_1:
	gcc -m32 './task_1/code.S' -o './task_1/code'
	g++ './task_1/gen.cpp' -o './task_1/gen'
	g++ './task_1/brute.cpp' -o './task_1/brute'
	
test_task_1: ./task_1/script.sh
	'./task_1/script.sh'

run_task_1: compile_task_1 test_task_1

compile_task_2:
	gcc -m32 './task_2/code.S' -o './task_2/code'
	g++ './task_2/gen.cpp' -o './task_2/gen'
	g++ './task_2/brute.cpp' -o './task_2/brute'
	g++ './task_2/validator.cpp' -o './task_2/validator'
	
test_task_2: ./task_2/script.sh
	'./task_2/script.sh'

run_task_2: compile_task_2 test_task_2