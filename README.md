# Fence Insertion for LLVM IR

A modification of the LLVM compiler infrastructure for automatically inserting fences in weak memory model concurrent programs.

## Running instructions
The main python script can be used to compile the test programs and run the tool against them. First compile by running:
```bash
$ python main.py --compile-tests
```
And then run the tool by doing:
```bash
$ python main.py --run
```


## Requirements 
- ortools: https://github.com/google/or-tools/blob/stable/ortools/linear_solver/samples/linear_programming_example.py
- https://llvmlite.readthedocs.io/en/latest/index.html
- clang-11

## Tests and Benchmarks 
To test the tool we utilize the *classic* and *fast* benchmarks provided [here](http://www.cprover.org/wmm/musketeer/).
