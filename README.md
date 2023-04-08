# Fence Insertion for LLVM IR

A modification of the LLVM compiler infrastructure for automatically inserting fences in weak memory model concurrent programs.
The project aims to reproduce and adapt the integer linear programming for fence insertion presented by *[Alglave et.al](https://arxiv.org/abs/1312.1411)*. 

## Running instructions
After cloning the repository please follow the steps listed below to setup the project.

### Setting up SVF
Our tool relies on [SVF](https://github.com/SVF-tools/SVF) to perform points-to analysis on the LLVM IR. As such, when 
first setting up the project you have to compile it. Extensive instructions can be found on SVF's github page but in sort: 

Navigate to the `SVF-SVF-2.2` directory and run: 
```bash
$ source ./build.sh
```

If you encounter any problems please consult the SVF setup [page](https://github.com/svf-tools/SVF/wiki/Setup-Guide#getting-started).

### Running and building the fencer
The main python script can be used to compile the test programs and run the tool against them. First compile by running:
```bash
$ python main.py --compile-tests
```
And then run the tool by doing:
```bash
$ python main.py --run
```




## Requirements 
- [or-tools](https://github.com/google/or-tools/blob/stable/ortools/linear_solver/samples/linear_programming_example.py)
- [llvm-lit](https://llvmlite.readthedocs.io/en/latest/index.html)
- [clang-12](https://releases.llvm.org/download.html) (also available through apt)

## Tests and Benchmarks 
To test the tool we utilize the *classic* and *fast* benchmarks provided [here](http://www.cprover.org/wmm/musketeer/).
