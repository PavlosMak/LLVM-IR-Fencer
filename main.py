import llvmParser
from antlr4 import *
from llvmParser.LLVMIRParser import LLVMIRParser
from llvmParser.LLVMIRLexer import LLVMIRLexer


from llvmlite import ir
import llvmlite.binding as llvm
from ortools.linear_solver import pywraplp

ir = '''
; ModuleID = 'add.c'
source_filename = "add.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@globvar = dso_local global i32 12, align 4

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @add(i32 %0) #0 {
  %2 = alloca i32, align 4
  store i32 %0, i32* %2, align 4
  %3 = load i32, i32* @globvar, align 4
  %4 = load i32, i32* %2, align 4
  %5 = add nsw i32 %3, %4
  ret i32 %5
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  store i32 0, i32* %1, align 4
  %3 = call i32 @add(i32 12)
  store i32 %3, i32* %2, align 4
  %4 = load i32, i32* %2, align 4
  ret i32 %4
}

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"Ubuntu clang version 11.0.0-2~ubuntu20.04.1"}
'''

# Press the green button in the gutter to run the script.
if __name__ == '__main__':
    # TODO: add utilities
    # TODO: make graph
    # TODO: parse labels and store them
    # TODO: add file parsing to get the string
    # aaa = ir.Module("test_programs/add.ll")
    llvm.initialize()
    llvm.initialize_native_target()
    module = llvm.parse_assembly(ir)
    for func in module.functions:
        print(func.name)
    # print(module.functions)
    # input_stream = FileStream("test_programs/add.ll")
    # lexer = LLVMIRLexer(input_stream)
    # stream = CommonTokenStream(lexer)
    # parser = LLVMIRParser(stream)
    # print(parser.targetTriple())

# See PyCharm help at https://www.jetbrains.com/help/pycharm/
