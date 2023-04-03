; ModuleID = 'Cilk_WSQ.c'
source_filename = "Cilk_WSQ.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@L = dso_local global i32 0, align 4
@counter = dso_local global i32 0, align 4
@T = dso_local global i32 5, align 4
@H = dso_local global i32 5, align 4

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @lock() #0 {
  %1 = call i32 (...) @__CPROVER_atomic_begin()
  call void asm sideeffect "mfence", "~{memory},~{dirflag},~{fpsr},~{flags}"() #2, !srcloc !2
  %2 = load volatile i32, i32* @L, align 4
  %3 = icmp eq i32 %2, 0
  %4 = zext i1 %3 to i32
  %5 = call i32 (i32, ...) bitcast (i32 (...)* @__CPROVER_assume to i32 (i32, ...)*)(i32 %4)
  store volatile i32 1, i32* @L, align 4
  call void asm sideeffect "mfence", "~{memory},~{dirflag},~{fpsr},~{flags}"() #2, !srcloc !3
  %6 = call i32 (...) @__CPROVER_atomic_end()
  ret void
}

declare dso_local i32 @__CPROVER_atomic_begin(...) #1

declare dso_local i32 @__CPROVER_assume(...) #1

declare dso_local i32 @__CPROVER_atomic_end(...) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @unlock() #0 {
  %1 = call i32 (...) @__CPROVER_atomic_begin()
  call void asm sideeffect "mfence", "~{memory},~{dirflag},~{fpsr},~{flags}"() #2, !srcloc !4
  %2 = load volatile i32, i32* @L, align 4
  %3 = icmp eq i32 %2, 1
  %4 = zext i1 %3 to i32
  %5 = call i32 (i32, ...) bitcast (i32 (...)* @__CPROVER_assume to i32 (i32, ...)*)(i32 %4)
  store volatile i32 0, i32* @L, align 4
  call void asm sideeffect "mfence", "~{memory},~{dirflag},~{fpsr},~{flags}"() #2, !srcloc !5
  %6 = call i32 (...) @__CPROVER_atomic_end()
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @push() #0 {
  %1 = load volatile i32, i32* @T, align 4
  %2 = add nsw i32 %1, 1
  store volatile i32 %2, i32* @T, align 4
  %3 = call i32 (...) @__CPROVER_atomic_begin()
  %4 = load i32, i32* @counter, align 4
  %5 = add nsw i32 %4, 1
  store i32 %5, i32* @counter, align 4
  %6 = call i32 (...) @__CPROVER_atomic_end()
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @pop() #0 {
  %1 = alloca i32, align 4
  %2 = load volatile i32, i32* @T, align 4
  %3 = add nsw i32 %2, -1
  store volatile i32 %3, i32* @T, align 4
  %4 = load volatile i32, i32* @H, align 4
  %5 = load volatile i32, i32* @T, align 4
  %6 = icmp sgt i32 %4, %5
  br i1 %6, label %7, label %19

7:                                                ; preds = %0
  %8 = load volatile i32, i32* @T, align 4
  %9 = add nsw i32 %8, 1
  store volatile i32 %9, i32* @T, align 4
  call void @lock()
  %10 = load volatile i32, i32* @T, align 4
  %11 = add nsw i32 %10, -1
  store volatile i32 %11, i32* @T, align 4
  %12 = load volatile i32, i32* @H, align 4
  %13 = load volatile i32, i32* @T, align 4
  %14 = icmp sgt i32 %12, %13
  br i1 %14, label %15, label %18

15:                                               ; preds = %7
  %16 = load volatile i32, i32* @T, align 4
  %17 = add nsw i32 %16, 1
  store volatile i32 %17, i32* @T, align 4
  call void @unlock()
  store i32 0, i32* %1, align 4
  br label %24

18:                                               ; preds = %7
  call void @unlock()
  br label %19

19:                                               ; preds = %18, %0
  %20 = call i32 (...) @__CPROVER_atomic_begin()
  %21 = load i32, i32* @counter, align 4
  %22 = add nsw i32 %21, -1
  store i32 %22, i32* @counter, align 4
  %23 = call i32 (...) @__CPROVER_atomic_end()
  store i32 1, i32* %1, align 4
  br label %24

24:                                               ; preds = %19, %15
  %25 = load i32, i32* %1, align 4
  ret i32 %25
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @steal() #0 {
  %1 = alloca i32, align 4
  call void @lock()
  %2 = load volatile i32, i32* @H, align 4
  %3 = add nsw i32 %2, 1
  store volatile i32 %3, i32* @H, align 4
  %4 = load volatile i32, i32* @H, align 4
  %5 = load volatile i32, i32* @T, align 4
  %6 = icmp sgt i32 %4, %5
  br i1 %6, label %7, label %10

7:                                                ; preds = %0
  %8 = load volatile i32, i32* @H, align 4
  %9 = add nsw i32 %8, -1
  store volatile i32 %9, i32* @H, align 4
  call void @unlock()
  store i32 0, i32* %1, align 4
  br label %15

10:                                               ; preds = %0
  call void @unlock()
  %11 = call i32 (...) @__CPROVER_atomic_begin()
  %12 = load i32, i32* @counter, align 4
  %13 = add nsw i32 %12, -1
  store i32 %13, i32* @counter, align 4
  %14 = call i32 (...) @__CPROVER_atomic_end()
  store i32 1, i32* %1, align 4
  br label %15

15:                                               ; preds = %10, %7
  %16 = load i32, i32* %1, align 4
  ret i32 %16
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i8* @owner(i8* %0) #0 {
  %2 = alloca i8*, align 8
  %3 = alloca i8*, align 8
  %4 = alloca i32, align 4
  store i8* %0, i8** %3, align 8
  store i32 0, i32* %4, align 4
  br label %5

5:                                                ; preds = %15, %1
  %6 = load i32, i32* %4, align 4
  %7 = icmp slt i32 %6, 10
  br i1 %7, label %8, label %18

8:                                                ; preds = %5
  %9 = call i32 (...) @nondet()
  %10 = icmp ne i32 %9, 0
  br i1 %10, label %11, label %13

11:                                               ; preds = %8
  %12 = call i32 @pop()
  br label %14

13:                                               ; preds = %8
  call void @push()
  br label %14

14:                                               ; preds = %13, %11
  br label %15

15:                                               ; preds = %14
  %16 = load i32, i32* %4, align 4
  %17 = add nsw i32 %16, 1
  store i32 %17, i32* %4, align 4
  br label %5, !llvm.loop !6

18:                                               ; preds = %5
  %19 = load i8*, i8** %2, align 8
  ret i8* %19
}

declare dso_local i32 @nondet(...) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i8* @thief(i8* %0) #0 {
  %2 = alloca i8*, align 8
  %3 = alloca i8*, align 8
  %4 = alloca i32, align 4
  store i8* %0, i8** %3, align 8
  store i32 0, i32* %4, align 4
  br label %5

5:                                                ; preds = %10, %1
  %6 = load i32, i32* %4, align 4
  %7 = icmp slt i32 %6, 10
  br i1 %7, label %8, label %13

8:                                                ; preds = %5
  %9 = call i32 @steal()
  br label %10

10:                                               ; preds = %8
  %11 = load i32, i32* %4, align 4
  %12 = add nsw i32 %11, 1
  store i32 %12, i32* %4, align 4
  br label %5, !llvm.loop !8

13:                                               ; preds = %5
  %14 = load i8*, i8** %2, align 8
  ret i8* %14
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 {
  %1 = alloca i32, align 4
  store i32 0, i32* %1, align 4
  br label %2

2:                                                ; preds = %0
  %3 = call i8* @owner(i8* null)
  %4 = call i8* @thief(i8* null)
  %5 = load i32, i32* @counter, align 4
  %6 = icmp sge i32 %5, 0
  %7 = zext i1 %6 to i32
  %8 = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %7)
  ret i32 0
}

declare dso_local i32 @assert(...) #1

attributes #0 = { noinline nounwind optnone uwtable "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"Ubuntu clang version 12.0.0-3ubuntu1~20.04.5"}
!2 = !{i32 353}
!3 = !{i32 436}
!4 = !{i32 557}
!5 = !{i32 640}
!6 = distinct !{!6, !7}
!7 = !{!"llvm.loop.mustprogress"}
!8 = distinct !{!8, !7}
